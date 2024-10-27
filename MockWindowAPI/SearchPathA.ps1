Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    using System.Text;

    public class Kernel32 {
        [DllImport("kernel32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern uint SearchPathA(
            string lpPath,
            string lpFileName,
            string lpExtension,
            uint nBufferLength,
            StringBuilder lpBuffer,
            IntPtr lpFilePart
        );
    }
"@ -PassThru

function Search-Path {
    param (
        [string]$fileName
    )
    $buffer = New-Object System.Text.StringBuilder 260
    [Kernel32]::SearchPathA([IntPtr]::Zero, $fileName, [IntPtr]::Zero, $buffer.Capacity, $buffer, [IntPtr]::Zero)
    $buffer.ToString()
}