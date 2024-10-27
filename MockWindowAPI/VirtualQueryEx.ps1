Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential)]
    public struct MEMORY_BASIC_INFORMATION {
        public IntPtr BaseAddress;
        public IntPtr AllocationBase;
        public uint AllocationProtect;
        public IntPtr RegionSize;
        public uint State;
        public uint Protect;
        public uint Type;
    }

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern int VirtualQueryEx(
            IntPtr hProcess,
            IntPtr lpAddress,
            out MEMORY_BASIC_INFORMATION lpBuffer,
            uint dwLength
        );
    }
"@ -PassThru

function Get-VirtualQueryEx {
    $memoryInfo = New-Object MEMORY_BASIC_INFORMATION
    [Kernel32]::VirtualQueryEx([IntPtr]::Zero, [IntPtr]::Zero, [ref]$memoryInfo, [uint32][System.Runtime.InteropServices.Marshal]::SizeOf([MEMORY_BASIC_INFORMATION]))
    $memoryInfo
}