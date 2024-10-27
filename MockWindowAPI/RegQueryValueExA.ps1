Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    using Microsoft.Win32.SafeHandles;

    public class Advapi32 {
        [DllImport("advapi32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern int RegQueryValueExA(
            IntPtr hKey,
            string lpValueName,
            int lpReserved,
            ref uint lpType,
            byte[] lpData,
            ref uint lpcbData
        );
    }
"@ -PassThru

function Query-RegistryValue {
    $data = New-Object byte[] 256
    $dataLen = [uint32]$data.Length
    $type = 0
    [Advapi32]::RegQueryValueExA([IntPtr]::Zero, "ValueName", 0, [ref]$type, $data, [ref]$dataLen)
}