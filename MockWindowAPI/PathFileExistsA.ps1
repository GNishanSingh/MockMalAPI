Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Shlwapi {
        [DllImport("shlwapi.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern bool PathFileExistsA(string pszPath);
    }
"@ -PassThru

function Path-FileExists {
    param (
        [string]$filePath
    )
    [Shlwapi]::PathFileExistsA($filePath)
}