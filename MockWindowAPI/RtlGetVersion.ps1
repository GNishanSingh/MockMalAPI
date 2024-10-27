Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential)]
    public struct RTL_OSVERSIONINFOEX {
        public uint dwOSVersionInfoSize;
        public uint dwMajorVersion;
        public uint dwMinorVersion;
        public uint dwBuildNumber;
        public uint dwPlatformId;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 128)]
        public string szCSDVersion;
    }

    public class Ntdll {
        [DllImport("ntdll.dll", SetLastError = true)]
        public static extern int RtlGetVersion(ref RTL_OSVERSIONINFOEX lpVersionInformation);
    }
"@ -PassThru

function Get-OSVersion {
    $osVersionInfo = New-Object RTL_OSVERSIONINFOEX
    $osVersionInfo.dwOSVersionInfoSize = [System.Runtime.InteropServices.Marshal]::SizeOf([RTL_OSVERSIONINFOEX])
    [Ntdll]::RtlGetVersion([ref]$osVersionInfo)
    $osVersionInfo
}