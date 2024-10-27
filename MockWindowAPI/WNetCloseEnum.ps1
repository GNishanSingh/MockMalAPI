
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Mpr {
        [DllImport("mpr.dll", SetLastError = true)]
        public static extern int WNetCloseEnum(IntPtr hEnum);
    }
"@ -PassThru

function Close-NetworkEnum {
    $result = [Mpr]::WNetCloseEnum([IntPtr]::Zero)
    Write-Output "Close Enum Result: $result"
}

Close-NetworkEnum
