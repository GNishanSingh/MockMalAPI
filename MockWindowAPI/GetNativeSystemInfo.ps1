Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential)]
    public struct SYSTEM_INFO {
        public ushort wProcessorArchitecture;
        public ushort wReserved;
        public uint dwPageSize;
        public IntPtr lpMinimumApplicationAddress;
        public IntPtr lpMaximumApplicationAddress;
        public IntPtr dwActiveProcessorMask;
        public uint dwNumberOfProcessors;
        public uint dwProcessorType;
        public uint dwAllocationGranularity;
        public ushort wProcessorLevel;
        public ushort wProcessorRevision;
    }

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern void GetNativeSystemInfo(out SYSTEM_INFO lpSystemInfo);
    }
"@ -PassThru

function Get-NativeSystemInfo {
    $systemInfo = New-Object SYSTEM_INFO
    [Kernel32]::GetNativeSystemInfo([ref]$systemInfo)
}