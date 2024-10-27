Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential)]
    public struct NETRESOURCE {
        public uint dwScope;
        public uint dwType;
        public uint dwDisplayType;
        public uint dwUsage;
        [MarshalAs(UnmanagedType.LPStr)]
        public string lpLocalName;
        [MarshalAs(UnmanagedType.LPStr)]
        public string lpRemoteName;
        [MarshalAs(UnmanagedType.LPStr)]
        public string lpComment;
        [MarshalAs(UnmanagedType.LPStr)]
        public string lpProvider;
    }

    public class Mpr {
        [DllImport("mpr.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern int WNetEnumResourceA(
            IntPtr hEnum,
            ref uint lpcCount,
            IntPtr lpBuffer,
            ref uint lpBufferSize
        );
    }
"@ -PassThru

function Enum-NetworkResources {
    $bufferSize = 16384
    $buffer = [System.Runtime.InteropServices.Marshal]::AllocHGlobal($bufferSize)
    $count = 0
    [Mpr]::WNetEnumResourceA([IntPtr]::Zero, [ref]$count, $buffer, [ref]$bufferSize)
    [System.Runtime.InteropServices.Marshal]::FreeHGlobal($buffer)
}