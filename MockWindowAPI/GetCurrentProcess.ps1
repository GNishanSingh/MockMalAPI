
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll")]
        public static extern IntPtr GetCurrentProcess();
    }
"@ -PassThru

function Get-CurrentProcess {
    [Kernel32]::GetCurrentProcess()
}

Get-CurrentProcess
