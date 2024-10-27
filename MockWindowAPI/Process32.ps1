Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential)]
    public struct PROCESSENTRY32 {
        public uint dwSize;
        public uint cntUsage;
        public uint th32ProcessID;
        public IntPtr th32DefaultHeapID;
        public uint th32ModuleID;
        public uint cntThreads;
        public uint th32ParentProcessID;
        public int pcPriClassBase;
        public uint dwFlags;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 260)]
        public string szExeFile;
    }

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool Process32First(IntPtr hSnapshot, ref PROCESSENTRY32 lppe);

        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool Process32Next(IntPtr hSnapshot, ref PROCESSENTRY32 lppe);
    }
"@ -PassThru

function Get-Processes {
    $entry = New-Object PROCESSENTRY32
    $entry.dwSize = [System.Runtime.InteropServices.Marshal]::SizeOf([PROCESSENTRY32])

    if ([Kernel32]::Process32First([IntPtr]::Zero, [ref]$entry)) {
        Write-Output $entry.szExeFile
        while ([Kernel32]::Process32Next([IntPtr]::Zero, [ref]$entry)) {
            Write-Output $entry.szExeFile
        }
    }
}