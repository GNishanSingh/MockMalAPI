Add-Type -TypeDefinition @"
    using System;
    using System.Text;
    using System.Runtime.InteropServices;

    public class Advapi32 {
        [DllImport("advapi32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern int RegEnumKeyA(
            IntPtr hKey,
            uint dwIndex,
            StringBuilder lpName,
            uint cchName
        );
    }
"@ -PassThru

function Enum-RegistryKeys {
    $keyName = New-Object System.Text.StringBuilder 260
    [Advapi32]::RegEnumKeyA([IntPtr]::Zero, 0, $keyName, $keyName.Capacity)
    $keyName.ToString()
}