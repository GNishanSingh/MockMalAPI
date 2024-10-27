Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential)]
    public struct OSVERSIONINFO {
        public uint dwOSVersionInfoSize;
        public uint dwMajorVersion;
        public uint dwMinorVersion;
        public uint dwBuildNumber;
        public uint dwPlatformId;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 128)]
        public string szCSDVersion;
    }

    public class Kernel32 {
        [DllImport("kernel32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern bool GetVersionExA(ref OSVERSIONINFO lpVersionInfo);
    }
"@ -PassThru

function Get-VersionEx {
    $osInfo = New-Object OSVERSIONINFO
    $osInfo.dwOSVersionInfoSize = [System.Runtime.InteropServices.Marshal]::SizeOf([OSVERSIONINFO])
    [Kernel32]::GetVersionExA([ref]$osInfo)
}