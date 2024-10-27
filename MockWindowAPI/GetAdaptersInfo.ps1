Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    using System.Text;

    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Ansi)]
    public struct IP_ADAPTER_INFO {
        public IntPtr Next;
        public int ComboIndex;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 260)]
        public string AdapterName;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 132)]
        public string Description;
        public uint AddressLength;
        [MarshalAs(UnmanagedType.ByValArray, SizeConst = 8)]
        public byte[] Address;
        public int Index;
        public uint Type;
        public uint DhcpEnabled;
        public IntPtr CurrentIpAddress;
        public IP_ADDR_STRING IpAddressList;
        public IP_ADDR_STRING GatewayList;
        public IP_ADDR_STRING DhcpServer;
        public bool HaveWins;
        public IP_ADDR_STRING PrimaryWinsServer;
        public IP_ADDR_STRING SecondaryWinsServer;
        public uint LeaseObtained;
        public uint LeaseExpires;
    }

    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Ansi)]
    public struct IP_ADDR_STRING {
        public IntPtr Next;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 16)]
        public string IpAddress;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 16)]
        public string IpMask;
        public uint Context;
    }

    public class IpHlpApi {
        [DllImport("iphlpapi.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern int GetAdaptersInfo(IntPtr pAdapterInfo, ref uint pOutBufLen);
    }
"@ -PassThru

function Get-AdaptersInfo {
    $outBufLen = 0
    [IpHlpApi]::GetAdaptersInfo([IntPtr]::Zero, [ref]$outBufLen)
    $pArray = [System.Runtime.InteropServices.Marshal]::AllocHGlobal($outBufLen)
    [IpHlpApi]::GetAdaptersInfo($pArray, [ref]$outBufLen)
    [System.Runtime.InteropServices.Marshal]::FreeHGlobal($pArray)
}