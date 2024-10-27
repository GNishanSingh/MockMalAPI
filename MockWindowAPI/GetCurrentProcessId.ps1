Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll")]
        public static extern uint GetCurrentProcessId();
    }
"@ -PassThru

function Get-CurrentProcessId {
    $processId = [Kernel32]::GetCurrentProcessId()
    Write-Output "Current Process ID: $processId"
}