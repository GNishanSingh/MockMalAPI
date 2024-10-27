
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll")]
        public static extern IntPtr GetCurrentThread();
    }
"@ -PassThru

function Get-CurrentThread {
    [Kernel32]::GetCurrentThread()
}

Get-CurrentThread
