Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class User32 {
        public delegate bool EnumDesktopWindowsProc(IntPtr hWnd, IntPtr lParam);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern bool EnumDesktopWindows(IntPtr hDesktop, EnumDesktopWindowsProc lpEnumFunc, IntPtr lParam);
    }
"@ -PassThru

function Enum-DesktopWindows {
    $callback = [User32+EnumDesktopWindowsProc]{
        param ($hWnd, $lParam)
        Write-Output "Window Handle: $hWnd"
        $true
    }
    [User32]::EnumDesktopWindows([IntPtr]::Zero, $callback, [IntPtr]::Zero)
}