Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool ReadProcessMemory(
            IntPtr hProcess,
            IntPtr lpBaseAddress,
            byte[] lpBuffer,
            uint nSize,
            out uint lpNumberOfBytesRead
        );
    }
"@ -PassThru

function Read-ProcessMemory {
    $buffer = New-Object byte[] 256
    $bytesRead = 0
    [Kernel32]::ReadProcessMemory([IntPtr]::Zero, [IntPtr]::Zero, $buffer, $buffer.Length, [ref]$bytesRead)
}