Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Ansi)]
    public struct WIN32_FIND_DATA {
        public uint dwFileAttributes;
        public System.Runtime.InteropServices.ComTypes.FILETIME ftCreationTime;
        public System.Runtime.InteropServices.ComTypes.FILETIME ftLastAccessTime;
        public System.Runtime.InteropServices.ComTypes.FILETIME ftLastWriteTime;
        public uint nFileSizeHigh;
        public uint nFileSizeLow;
        public uint dwReserved0;
        public uint dwReserved1;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 260)]
        public string cFileName;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 14)]
        public string cAlternateFileName;
    }

    public class Kernel32 {
        [DllImport("kernel32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern IntPtr FindFirstFileA(
            string lpFileName,
            out WIN32_FIND_DATA lpFindFileData
        );

        [DllImport("kernel32.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern bool FindNextFileA(
            IntPtr hFindFile,
            out WIN32_FIND_DATA lpFindFileData
        );

        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool FindClose(IntPtr hFindFile);
    }
"@ -PassThru

function Get-AllFiles {
    param (
        [string]$FilePath
    )

    $findData = New-Object WIN32_FIND_DATA
    $hFindFile = [Kernel32]::FindFirstFileA($FilePath, [ref]$findData)

    if ($hFindFile -eq [IntPtr]::Zero) {
        Write-Error "No files found or invalid path."
        return
    }

    Write-Output "Files matching '$FilePath':"
    Write-Output "File Name: $($findData.cFileName)"
    Write-Output "File Attributes: $($findData.dwFileAttributes)"
    
    while ([Kernel32]::FindNextFileA($hFindFile, [ref]$findData)) {
        Write-Output "File Name: $($findData.cFileName)"
        Write-Output "File Attributes: $($findData.dwFileAttributes)"
    }

    [Kernel32]::FindClose($hFindFile)
}