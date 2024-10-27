
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Mpr {
        [DllImport("mpr.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern int WNetAddConnectionA(string lpRemoteName, string lpPassword, string lpLocalName);
    }
"@ -PassThru

function Add-NetworkConnection {
    $result = [Mpr]::WNetAddConnectionA("\\\\Server\\Share", "password", "Z:")
    Write-Output "Add Connection Result: $result"
}

Add-NetworkConnection
