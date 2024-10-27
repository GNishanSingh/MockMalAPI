Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool IsWow64Process(IntPtr hProcess, out bool Wow64Process);
    }
"@ -PassThru

function Get-IsWow64Process {
    $isWow64 = $false
    [Kernel32]::IsWow64Process([IntPtr]::Zero, [ref]$isWow64)
}