
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern uint GetThreadLocale();
    }
"@ -PassThru

function Get-ThreadLocale {
    $locale = [Kernel32]::GetThreadLocale()
    Write-Output "Thread Locale: $locale"
}

Get-ThreadLocale
