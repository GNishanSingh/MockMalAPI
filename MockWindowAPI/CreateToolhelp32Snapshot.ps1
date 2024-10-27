Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Toolhelp32
{
    public const uint TH32CS_SNAPPROCESS = 0x00000002;
    public const uint TH32CS_SNAPTHREAD = 0x00000004;
    public const uint TH32CS_SNAPMODULE = 0x00000008;
    public const uint TH32CS_SNAPMODULE32 = 0x00000010;
    public static readonly IntPtr INVALID_HANDLE_VALUE = new IntPtr(-1);
    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern IntPtr CreateToolhelp32Snapshot(uint dwFlags, uint th32ProcessID);
}
"@

function Get-ProcessSnapshot {
    param (
        [uint32]$ProcessID = 0
    )
    $snapshotHandle = [Toolhelp32]::CreateToolhelp32Snapshot([Toolhelp32]::TH32CS_SNAPPROCESS, $ProcessID)
    if ($snapshotHandle -eq [Toolhelp32]::INVALID_HANDLE_VALUE) {
        Write-Error "Failed to create process snapshot. Error: $([System.Runtime.InteropServices.Marshal]::GetLastWin32Error())"
        return
    }
    Write-Output "Snapshot created successfully with handle: $snapshotHandle"
    [System.Runtime.InteropServices.Marshal]::FreeHGlobal($snapshotHandle)
}