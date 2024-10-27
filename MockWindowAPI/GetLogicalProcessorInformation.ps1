Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential)]
    public struct SYSTEM_LOGICAL_PROCESSOR_INFORMATION {
        public IntPtr ProcessorMask;
        public int Relationship;
        public CACHE_DESCRIPTOR Cache;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct CACHE_DESCRIPTOR {
        public byte Level;
        public byte Associativity;
        public ushort LineSize;
        public uint Size;
        public int Type;
    }

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool GetLogicalProcessorInformation(
            IntPtr Buffer,
            ref uint ReturnLength
        );
    }
"@ -PassThru

function Get-LogicalProcessorInfo {
    $length = 0
    [Kernel32]::GetLogicalProcessorInformation([IntPtr]::Zero, [ref]$length)
    $buffer = [System.Runtime.InteropServices.Marshal]::AllocHGlobal($length)
    [Kernel32]::GetLogicalProcessorInformation($buffer, [ref]$length)

    $count = $length / [System.Runtime.InteropServices.Marshal]::SizeOf([SYSTEM_LOGICAL_PROCESSOR_INFORMATION])
    for ($i = 0; $i -lt $count; $i++) {
        $info = [System.Runtime.InteropServices.Marshal]::PtrToStructure(
            [IntPtr]($buffer.ToInt64() + $i * [System.Runtime.InteropServices.Marshal]::SizeOf([SYSTEM_LOGICAL_PROCESSOR_INFORMATION])),
            [SYSTEM_LOGICAL_PROCESSOR_INFORMATION]
        )
        Write-Output "Processor Mask: $($info.ProcessorMask)"
    }
    [System.Runtime.InteropServices.Marshal]::FreeHGlobal($buffer)
}