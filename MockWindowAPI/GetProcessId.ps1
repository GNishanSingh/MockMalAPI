
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll")]
        public static extern uint GetProcessId(IntPtr hProcess);
    }
"@ -PassThru

function Get-ProcessId {
    [Kernel32]::GetProcessId([IntPtr]::Zero)
}

Get-ProcessId
