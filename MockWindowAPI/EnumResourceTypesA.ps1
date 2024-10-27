
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        public delegate bool EnumResTypeProc(IntPtr hModule, IntPtr lpszType, IntPtr lParam);

        [DllImport("kernel32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern bool EnumResourceTypesA(IntPtr hModule, EnumResTypeProc lpEnumFunc, IntPtr lParam);
    }
"@ -PassThru

function Enum-ResourceTypes {
    $callback = [Kernel32+EnumResTypeProc]{
        param ($hModule, $lpszType, $lParam)
        Write-Output "Resource Type: $lpszType"
        $true
    }
    [Kernel32]::EnumResourceTypesA([IntPtr]::Zero, $callback, [IntPtr]::Zero)
}

Enum-ResourceTypes
