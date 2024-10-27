Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        [DllImport("kernel32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern uint GetDriveTypeA(string lpRootPathName);
    }
"@ -PassThru

function Get-DriveType {
    param (
        [string]$drivePath
    )
    [Kernel32]::GetDriveTypeA($drivePath)
}