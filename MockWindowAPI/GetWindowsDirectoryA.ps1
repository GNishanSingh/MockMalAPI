Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern uint GetWindowsDirectoryA(System.Text.StringBuilder lpBuffer, uint uSize);
    }
"@ -PassThru

function Get-WindowsDirectory {
    $buffer = New-Object System.Text.StringBuilder 260
    [Kernel32]::GetWindowsDirectoryA($buffer, $buffer.Capacity) | Out-Null
    Write-Output "Windows Directory: $($buffer.ToString())"
}