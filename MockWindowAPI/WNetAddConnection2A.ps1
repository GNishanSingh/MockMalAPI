
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Ansi)]
    public struct NETRESOURCE {
        public uint dwScope;
        public uint dwType;
        public uint dwDisplayType;
        public uint dwUsage;
        public string lpLocalName;
        public string lpRemoteName;
        public string lpComment;
        public string lpProvider;
    }

    public class Mpr {
        [DllImport("mpr.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern int WNetAddConnection2A(ref NETRESOURCE lpNetResource, string lpPassword, string lpUserName, uint dwFlags);
    }
"@ -PassThru

function Add-NetworkConnection2 {
    $netResource = New-Object NETRESOURCE
    $netResource.lpRemoteName = "\\\\Server\\Share"
    $netResource.lpLocalName = "Z:"
    $result = [Mpr]::WNetAddConnection2A([ref]$netResource, "password", "username", 0)
    Write-Output "Add Connection2 Result: $result"
}

Add-NetworkConnection2
