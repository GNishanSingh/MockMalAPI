Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern ushort GetSystemDefaultLangID();
    }
"@ -PassThru

function Get-SystemDefaultLangId {
    [Kernel32]::GetSystemDefaultLangID()
}