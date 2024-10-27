Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential)]
    public struct THREAD_INFORMATION_CLASS {
        public int ThreadInformationClass;
        public IntPtr ThreadInformation;
        public uint ThreadInformationLength;
    }

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool GetThreadInformation(
            IntPtr hThread,
            int ThreadInformationClass,
            IntPtr ThreadInformation,
            uint ThreadInformationLength
        );
    }
"@ -PassThru

function Get-ThreadInformation {
    $infoClass = 0
    $infoBuffer = [IntPtr]::Zero
    [Kernel32]::GetThreadInformation([IntPtr]::Zero, $infoClass, $infoBuffer, 0)
}