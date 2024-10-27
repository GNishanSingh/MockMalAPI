Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Ansi)]
    public struct SHARE_INFO_1 {
        [MarshalAs(UnmanagedType.LPStr)]
        public string shi1_netname;
        public uint shi1_type;
        [MarshalAs(UnmanagedType.LPStr)]
        public string shi1_remark;
    }

    public class NetApi32 {
        [DllImport("netapi32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern int NetShareEnum(
            string servername,
            int level,
            out IntPtr bufptr,
            uint prefmaxlen,
            out uint entriesread,
            out uint totalentries,
            IntPtr resume_handle
        );

        [DllImport("netapi32.dll", SetLastError = true)]
        public static extern int NetApiBufferFree(IntPtr Buffer);
    }
"@ -PassThru

function Enum-NetShares {
    $bufptr = [IntPtr]::Zero
    $entriesread = 0
    $totalentries = 0
    [NetApi32]::NetShareEnum([IntPtr]::Zero, 1, [ref]$bufptr, [uint32](-1), [ref]$entriesread, [ref]$totalentries, [IntPtr]::Zero)
    [NetApi32]::NetApiBufferFree($bufptr)
}