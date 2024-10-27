Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern uint GetFileAttributesA(string lpFileName);
    }
"@ -PassThru

function Get-FileAttributes {
    param (
        [string]$filePath
    )
    [Kernel32]::GetFileAttributesA($filePath)
}