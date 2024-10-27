Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential)]
    public struct SYSTEMTIME {
        public ushort Year;
        public ushort Month;
        public ushort DayOfWeek;
        public ushort Day;
        public ushort Hour;
        public ushort Minute;
        public ushort Second;
        public ushort Milliseconds;
    }

    public class Kernel32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern void GetSystemTime(out SYSTEMTIME lpSystemTime);
    }
"@ -PassThru

function Get-SystemTime {
    $time = New-Object SYSTEMTIME
    [Kernel32]::GetSystemTime([ref]$time)
    Write-Output "Current System Time: $($time.Year)-$($time.Month)-$($time.Day) $($time.Hour):$($time.Minute):$($time.Second)"
}