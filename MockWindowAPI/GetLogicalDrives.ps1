Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern uint GetLogicalDrives();
    }
"@ -PassThru

function Get-LogicalDrives {
    [Kernel32]::GetLogicalDrives()
}