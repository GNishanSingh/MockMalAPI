
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Kernel32 {
        public delegate bool EnumLocalesProcA(string lpLocaleString);

        [DllImport("kernel32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern bool EnumSystemLocalesA(EnumLocalesProcA lpLocaleEnumProc, uint dwFlags);
    }
"@ -PassThru

function Enum-SystemLocales {
    $callback = [Kernel32+EnumLocalesProcA]{
        param ($locale)
        Write-Output "Locale: $locale"
        $true
    }
    [Kernel32]::EnumSystemLocalesA($callback, 0)
}

Enum-SystemLocales
