Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class ProcessModules
{
    public const uint PROCESS_QUERY_INFORMATION = 0x0400;
    public const uint PROCESS_VM_READ = 0x0010;

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern IntPtr OpenProcess(uint dwDesiredAccess, bool bInheritHandle, uint dwProcessId);

    [DllImport("psapi.dll", SetLastError = true)]
    public static extern bool EnumProcessModules(IntPtr hProcess, IntPtr[] lphModule, int cb, out int lpcbNeeded);

    [DllImport("psapi.dll", CharSet = CharSet.Auto)]
    public static extern uint GetModuleFileNameEx(IntPtr hProcess, IntPtr hModule, System.Text.StringBuilder lpBaseName, int nSize);

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern bool CloseHandle(IntPtr hObject);
}
"@

function Get-ProcessModules {
    param (
        [uint32]$ProcessID
    )

    $hProcess = [ProcessModules]::OpenProcess(
        [ProcessModules]::PROCESS_QUERY_INFORMATION -bor [ProcessModules]::PROCESS_VM_READ, 
        $false, 
        $ProcessID
    )

    if ($hProcess -eq [IntPtr]::Zero) {
        Write-Error "Failed to open process. Error: $([System.Runtime.InteropServices.Marshal]::GetLastWin32Error())"
        return
    }

    $modules = New-Object IntPtr[] 1024
    $cb = [System.Runtime.InteropServices.Marshal]::SizeOf([IntPtr]) * $modules.Length
    $lpcbNeeded = 0

    $result = [ProcessModules]::EnumProcessModules($hProcess, $modules, $cb, [ref]$lpcbNeeded)

    if (-not $result) {
        Write-Error "Failed to enumerate modules. Error: $([System.Runtime.InteropServices.Marshal]::GetLastWin32Error())"
        [ProcessModules]::CloseHandle($hProcess)
        return
    }

    $numModules = $lpcbNeeded / [System.Runtime.InteropServices.Marshal]::SizeOf([IntPtr])
    for ($i = 0; $i -lt $numModules; $i++) {
        $moduleName = New-Object System.Text.StringBuilder 260
        [ProcessModules]::GetModuleFileNameEx($hProcess, $modules[$i], $moduleName, $moduleName.Capacity) | Out-Null
        Write-Output "Module: $($moduleName.ToString())"
    }

    [ProcessModules]::CloseHandle($hProcess)
}