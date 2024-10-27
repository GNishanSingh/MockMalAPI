Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern uint GetThreadId(IntPtr Thread);
    }
"@ -PassThru

function Get-ThreadId {
    [Kernel32]::GetThreadId([IntPtr]::Zero)
}