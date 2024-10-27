
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        public delegate bool EnumResTypeProc(IntPtr hModule, IntPtr lpszType, IntPtr lParam);

        [DllImport("kernel32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern bool EnumResourceTypesExA(IntPtr hModule, EnumResTypeProc lpEnumFunc, IntPtr lParam, uint dwFlags, uint LangId);
    }
"@ -PassThru

function Enum-ResourceTypesEx {
    $callback = [Kernel32+EnumResTypeProc]{
        param ($hModule, $lpszType, $lParam)
        Write-Output "Resource Type: $lpszType"
        $true
    }
    [Kernel32]::EnumResourceTypesExA([IntPtr]::Zero, $callback, [IntPtr]::Zero, 0, 0)
}

Enum-ResourceTypesEx
