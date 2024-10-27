
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Advapi32 {
        [DllImport("advapi32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern bool LookupAccountNameA(
            string lpSystemName,
            string lpAccountName,
            IntPtr Sid,
            ref uint cbSid,
            IntPtr ReferencedDomainName,
            ref uint cchReferencedDomainName,
            out uint peUse
        );
    }
"@ -PassThru

function Lookup-AccountName {
    $sidSize = 0
    $domainNameSize = 0
    $use = 0
    [Advapi32]::LookupAccountNameA([IntPtr]::Zero, "Administrator", [IntPtr]::Zero, [ref]$sidSize, [IntPtr]::Zero, [ref]$domainNameSize, [ref]$use)
}

Lookup-AccountName
