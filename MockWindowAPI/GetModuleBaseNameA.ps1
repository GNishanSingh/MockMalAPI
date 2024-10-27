Add-Type -TypeDefinition @"
    using System;
    using System.Text;
    using System.Runtime.InteropServices;

    public class PsApi {
        [DllImport("psapi.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern uint GetModuleBaseNameA(IntPtr hProcess, IntPtr hModule, StringBuilder lpBaseName, uint nSize);
    }
"@ -PassThru

function Get-ModuleBaseName {
    $buffer = New-Object System.Text.StringBuilder 260
    [PsApi]::GetModuleBaseNameA([IntPtr]::Zero, [IntPtr]::Zero, $buffer, $buffer.Capacity)
}