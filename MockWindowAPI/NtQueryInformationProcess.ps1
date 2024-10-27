
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential)]
    public struct PROCESS_BASIC_INFORMATION {
        public IntPtr Reserved1;
        public IntPtr PebBaseAddress;
        public IntPtr Reserved2_0;
        public IntPtr Reserved2_1;
        public IntPtr UniqueProcessId;
        public IntPtr Reserved3;
    }

    public class Ntdll {
        [DllImport("ntdll.dll", SetLastError = true)]
        public static extern int NtQueryInformationProcess(
            IntPtr ProcessHandle,
            int ProcessInformationClass,
            out PROCESS_BASIC_INFORMATION ProcessInformation,
            uint ProcessInformationLength,
            out uint ReturnLength
        );
    }
"@ -PassThru

function Get-ProcessInformation {
    $processInfo = New-Object PROCESS_BASIC_INFORMATION
    $returnLength = 0
    [Ntdll]::NtQueryInformationProcess([IntPtr]::Zero, 0, [ref]$processInfo, [uint32][System.Runtime.InteropServices.Marshal]::SizeOf([PROCESS_BASIC_INFORMATION]), [ref]$returnLength)
    $processInfo
}