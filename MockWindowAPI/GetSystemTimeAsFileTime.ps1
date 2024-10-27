Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential)]
    public struct FILETIME {
        public uint dwLowDateTime;
        public uint dwHighDateTime;
    }

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern void GetSystemTimeAsFileTime(out FILETIME lpSystemTimeAsFileTime);
    }
"@ -PassThru

function Get-SystemTimeAsFileTime {
    $fileTime = New-Object FILETIME
    [Kernel32]::GetSystemTimeAsFileTime([ref]$fileTime)
}