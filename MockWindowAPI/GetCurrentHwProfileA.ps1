Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Ansi)]
    public struct HW_PROFILE_INFO {
        public uint dwDockInfo;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 39)]
        public string szHwProfileGuid;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 80)]
        public string szHwProfileName;
    }

    public class Advapi32 {
        [DllImport("advapi32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern bool GetCurrentHwProfileA(out HW_PROFILE_INFO lpHwProfileInfo);
    }
"@ -PassThru

function Get-CurrentHwProfile {
    $profileInfo = New-Object HW_PROFILE_INFO
    [Advapi32]::GetCurrentHwProfileA([ref]$profileInfo)
    $profileInfo
}