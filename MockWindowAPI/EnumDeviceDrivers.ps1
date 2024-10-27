Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class DeviceDrivers
{
    [DllImport("psapi.dll", SetLastError = true)]
    public static extern bool EnumDeviceDrivers(IntPtr[] lpImageBase, int cb, out int lpcbNeeded);
}
"@

function Get-DeviceDrivers {
    $drivers = New-Object IntPtr[] 1024
    $cb = [IntPtr]::Size * $drivers.Length
    $lpcbNeeded = 0
    $result = [DeviceDrivers]::EnumDeviceDrivers($drivers, $cb, [ref]$lpcbNeeded)
    if (-not $result) {
        Write-Error "Failed to enumerate device drivers. Error: $([System.Runtime.InteropServices.Marshal]::GetLastWin32Error())"
        return
    }
    $numDrivers = $lpcbNeeded / [IntPtr]::Size
    $drivers[0..($numDrivers - 1)] | ForEach-Object { Write-Output $_.ToString("X") }
}