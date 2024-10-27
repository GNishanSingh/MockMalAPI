Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern uint GetProcessIdOfThread(IntPtr Thread);
    }
"@ -PassThru

function Get-ProcessIdOfThread {
    [Kernel32]::GetProcessIdOfThread([IntPtr]::Zero)
}