Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Advapi32 {
        [DllImport("advapi32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern bool LookupPrivilegeValueA(
            string lpSystemName,
            string lpName,
            out IntPtr lpLuid
        );
    }
"@ -PassThru

function Lookup-PrivilegeValue {
    $luid = [IntPtr]::Zero
    [Advapi32]::LookupPrivilegeValueA([IntPtr]::Zero, "SeShutdownPrivilege", [ref]$luid)
}