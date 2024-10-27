Add-Type -TypeDefinition @"
    using System;
    using System.Text;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern bool GetComputerNameA(StringBuilder lpBuffer, ref uint nSize);
    }
"@ -PassThru

function Get-ComputerName {
    $buffer = New-Object System.Text.StringBuilder 260
    $size = [uint32]$buffer.Capacity
    [Kernel32]::GetComputerNameA($buffer, [ref]$size)
}