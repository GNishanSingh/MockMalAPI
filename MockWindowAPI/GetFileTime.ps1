
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
        public static extern bool GetFileTime(
            IntPtr hFile,
            out FILETIME lpCreationTime,
            out FILETIME lpLastAccessTime,
            out FILETIME lpLastWriteTime
        );
    }
"@ -PassThru

function Get-FileTime {
    $creationTime = New-Object FILETIME
    $lastAccessTime = New-Object FILETIME
    $lastWriteTime = New-Object FILETIME
    [Kernel32]::GetFileTime([IntPtr]::Zero, [ref]$creationTime, [ref]$lastAccessTime, [ref]$lastWriteTime)
}

Get-FileTime
