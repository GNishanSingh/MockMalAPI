Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern uint GetSystemDirectoryA(System.Text.StringBuilder lpBuffer, uint uSize);
    }
"@ -PassThru

function Get-SystemDirectory {
    $buffer = New-Object System.Text.StringBuilder 260
    [Kernel32]::GetSystemDirectoryA($buffer, $buffer.Capacity) | Out-Null
    Write-Output "System Directory: $($buffer.ToString())"
}