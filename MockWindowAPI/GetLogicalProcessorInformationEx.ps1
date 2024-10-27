Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential)]
    public struct SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX {
        public int Relationship;
        public uint ProcessorMask;
    }

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool GetLogicalProcessorInformationEx(
            int RelationshipType,
            IntPtr Buffer,
            ref uint ReturnLength
        );
    }
"@ -PassThru

function Get-LogicalProcessorInfoEx {
    $length = 0
    [Kernel32]::GetLogicalProcessorInformationEx(0, [IntPtr]::Zero, [ref]$length)
    $buffer = [System.Runtime.InteropServices.Marshal]::AllocHGlobal($length)
    [Kernel32]::GetLogicalProcessorInformationEx(0, $buffer, [ref]$length)
    [System.Runtime.InteropServices.Marshal]::FreeHGlobal($buffer)
}