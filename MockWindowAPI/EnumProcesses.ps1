Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Processes
{
    [DllImport("psapi.dll", SetLastError = true)]
    public static extern bool EnumProcesses(uint[] lpidProcess, int cb, out int lpcbNeeded);
}
"@

function Get-Processes {
    $processIds = New-Object uint[] 1024
    $cb = [System.Runtime.InteropServices.Marshal]::SizeOf([uint32]) * $processIds.Length
    $lpcbNeeded = 0
    
    $result = [Processes]::EnumProcesses($processIds, $cb, [ref]$lpcbNeeded)
    
    if (-not $result) {
        Write-Error "Failed to enumerate processes. Error: $([System.Runtime.InteropServices.Marshal]::GetLastWin32Error())"
        return
    }
    
    $numProcesses = $lpcbNeeded / [System.Runtime.InteropServices.Marshal]::SizeOf([uint32])
    $processIds[0..($numProcesses - 1)] | ForEach-Object { Write-Output "Process ID: $_" }
}