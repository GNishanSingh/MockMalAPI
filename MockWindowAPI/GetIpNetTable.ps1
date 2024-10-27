Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public struct MIB_IPNETROW {
        public int dwIndex;
        public int dwPhysAddrLen;
        [MarshalAs(UnmanagedType.ByValArray, SizeConst = 8)]
        public byte[] bPhysAddr;
        public int dwAddr;
        public int dwType;
    }

    public class IpHlpApi {
        [DllImport("iphlpapi.dll", SetLastError = true)]
        public static extern int GetIpNetTable(IntPtr pIpNetTable, ref uint pdwSize, bool bOrder);
    }
"@ -PassThru

function Get-IpNetTable {
    $size = 0
    [IpHlpApi]::GetIpNetTable([IntPtr]::Zero, [ref]$size, $true)
    $buffer = [System.Runtime.InteropServices.Marshal]::AllocHGlobal($size)
    [IpHlpApi]::GetIpNetTable($buffer, [ref]$size, $true)
    [System.Runtime.InteropServices.Marshal]::FreeHGlobal($buffer)
}