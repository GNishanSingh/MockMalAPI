
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll")]
        public static extern uint GetCurrentThreadId();
    }
"@ -PassThru

function Get-CurrentThreadId {
    [Kernel32]::GetCurrentThreadId()
}

Get-CurrentThreadId
