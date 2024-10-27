Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool ReadFile(
            IntPtr hFile,
            byte[] lpBuffer,
            uint nNumberOfBytesToRead,
            out uint lpNumberOfBytesRead,
            IntPtr lpOverlapped
        );
    }
"@ -PassThru

function Read-File {
    $buffer = New-Object byte[] 1024
    $bytesRead = 0
    [Kernel32]::ReadFile([IntPtr]::Zero, $buffer, $buffer.Length, [ref]$bytesRead, [IntPtr]::Zero)
}