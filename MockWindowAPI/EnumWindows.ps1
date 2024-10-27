Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class User32 {
        public delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern bool EnumWindows(EnumWindowsProc lpEnumFunc, IntPtr lParam);
    }
"@ -PassThru

function Enum-WindowsOS {
    $callback = [User32+EnumWindowsProc]{
        param ($hWnd, $lParam)
        Write-Output "Window Handle: $hWnd"
        $true
    }
    [User32]::EnumWindows($callback, [IntPtr]::Zero)
}