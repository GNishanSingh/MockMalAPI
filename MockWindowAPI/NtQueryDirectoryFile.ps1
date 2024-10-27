Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential)]
    public struct IO_STATUS_BLOCK {
        public IntPtr Status;
        public IntPtr Information;
    }

    public class Ntdll {
        [DllImport("ntdll.dll", SetLastError = true)]
        public static extern uint NtQueryDirectoryFile(
            IntPtr FileHandle,
            IntPtr Event,
            IntPtr ApcRoutine,
            IntPtr ApcContext,
            ref IO_STATUS_BLOCK IoStatusBlock,
            IntPtr FileInformation,
            uint Length,
            uint FileInformationClass,
            bool ReturnSingleEntry,
            IntPtr FileName,
            bool RestartScan
        );
    }
"@ -PassThru

function Query-DirectoryFile {
    $ioStatusBlock = New-Object IO_STATUS_BLOCK
    [Ntdll]::NtQueryDirectoryFile([IntPtr]::Zero, [IntPtr]::Zero, [IntPtr]::Zero, [IntPtr]::Zero, [ref]$ioStatusBlock, [IntPtr]::Zero, 0, 1, $true, [IntPtr]::Zero, $false)
}