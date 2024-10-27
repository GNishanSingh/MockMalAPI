Add-Type -TypeDefinition @"
    using System;
    using System.Text;
    using System.Runtime.InteropServices;

    public class Advapi32 {
        [DllImport("advapi32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern bool GetUserNameA(StringBuilder lpBuffer, ref uint nSize);
    }
"@ -PassThru

function Get-UserName {
    $buffer = New-Object System.Text.StringBuilder 260
    $size = [uint32]$buffer.Capacity
    [Advapi32]::GetUserNameA($buffer, [ref]$size)
}