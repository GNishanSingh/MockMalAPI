
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Ntdll {
        [DllImport("ntdll.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern uint NtQuerySystemEnvironmentValueEx(
            string VariableName,
            ref Guid VendorGuid,
            byte[] Value,
            ref uint ValueLength,
            out uint Attributes
        );
    }
"@ -PassThru

function Query-SystemEnvironmentValue {
    $vendorGuid = [Guid]::NewGuid()
    $value = New-Object byte[] 1024
    $valueLength = [uint32]$value.Length
    $attributes = 0
    [Ntdll]::NtQuerySystemEnvironmentValueEx("SomeVariable", [ref]$vendorGuid, $value, [ref]$valueLength, [ref]$attributes)
}
