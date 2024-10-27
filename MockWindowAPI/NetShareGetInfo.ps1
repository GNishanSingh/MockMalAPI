
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Ansi)]
    public struct SHARE_INFO_2 {
        public IntPtr shi2_netname;
        public uint shi2_type;
        public IntPtr shi2_remark;
        public uint shi2_permissions;
        public uint shi2_max_uses;
        public uint shi2_current_uses;
        public IntPtr shi2_path;
        public IntPtr shi2_passwd;
    }

    public class NetApi32 {
        [DllImport("netapi32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern int NetShareGetInfo(
            string servername,
            string netname,
            int level,
            out IntPtr bufptr
        );

        [DllImport("netapi32.dll", SetLastError = true)]
        public static extern int NetApiBufferFree(IntPtr Buffer);
    }
"@ -PassThru

function Get-ShareInfo {
    $bufptr = [IntPtr]::Zero
    $result = [NetApi32]::NetShareGetInfo([IntPtr]::Zero, "C$", 2, [ref]$bufptr)
    if ($result -eq 0) {
        [NetApi32]::NetApiBufferFree($bufptr)
    }
}
