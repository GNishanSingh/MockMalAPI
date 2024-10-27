Add-Type -TypeDefinition @"
    public enum ModuleFilterFlags : uint {
        LIST_MODULES_DEFAULT = 0x00,
        LIST_MODULES_32BIT = 0x01,
        LIST_MODULES_64BIT = 0x02,
        LIST_MODULES_ALL = 0x03
    }
"@ -PassThru

Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class PsApi {
        [DllImport("psapi.dll", SetLastError = true)]
        public static extern bool EnumProcessModulesEx(
            IntPtr hProcess,
            [Out] IntPtr[] lphModule,
            uint cb,
            out uint lpcbNeeded,
            uint dwFilterFlag
        );
    }

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern IntPtr OpenProcess(
            uint processAccess,
            bool bInheritHandle,
            int processId
        );

        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool CloseHandle(IntPtr hObject);
    }
"@ -PassThru

$PROCESS_QUERY_INFORMATION = 0x0400
$PROCESS_VM_READ = 0x0010

function Get-ProcessModules {
    param (
        [int]$ProcessId
    )

    $hProcess = [Kernel32]::OpenProcess($PROCESS_QUERY_INFORMATION -bor $PROCESS_VM_READ, $false, $ProcessId)
    if ($hProcess -eq [IntPtr]::Zero) {
        Write-Error "Failed to open process with ID $ProcessId."
        return
    }

    $moduleHandles = New-Object IntPtr[] (1024)
    $neededSize = 0

    if ([PsApi]::EnumProcessModulesEx($hProcess, $moduleHandles, [uint32]($moduleHandles.Length * [IntPtr]::Size), [ref]$neededSize, [ModuleFilterFlags]::LIST_MODULES_ALL)) {
        Write-Output "Modules for process ID $ProcessId:"
        
        $moduleCount = $neededSize / [IntPtr]::Size
        for ($i = 0; $i -lt $moduleCount; $i++) {
            $moduleBaseAddr = $moduleHandles[$i]
            Write-Output ("Module Handle: " + $moduleBaseAddr)
        }
    }
    else {
        Write-Error "Failed to enumerate modules for process ID $ProcessId."
    }

    [Kernel32]::CloseHandle($hProcess)
}