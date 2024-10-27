Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Ansi)]
    public struct INTERNET_CACHE_ENTRY_INFO {
        public uint dwStructSize;
        public IntPtr lpszSourceUrlName;
        public IntPtr lpszLocalFileName;
        public uint CacheEntryType;
        public uint dwUseCount;
        public uint dwHitRate;
        public uint dwSizeLow;
        public uint dwSizeHigh;
        public System.Runtime.InteropServices.ComTypes.FILETIME LastModifiedTime;
        public System.Runtime.InteropServices.ComTypes.FILETIME ExpireTime;
        public System.Runtime.InteropServices.ComTypes.FILETIME LastAccessTime;
        public System.Runtime.InteropServices.ComTypes.FILETIME LastSyncTime;
        public IntPtr lpHeaderInfo;
        public uint dwHeaderInfoSize;
        public IntPtr lpszFileExtension;
        public uint dwExemptDelta;
    }

    public class WinInet {
        [DllImport("wininet.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern IntPtr FindFirstUrlCacheEntryA(
            string lpszUrlSearchPattern,
            IntPtr lpFirstCacheEntryInfo,
            ref uint lpdwFirstCacheEntryInfoBufferSize
        );

        [DllImport("wininet.dll", CharSet = CharSet.Ansi, SetLastError = true)]
        public static extern bool FindNextUrlCacheEntryA(
            IntPtr hEnumHandle,
            IntPtr lpNextCacheEntryInfo,
            ref uint lpdwNextCacheEntryInfoBufferSize
        );
    }
"@ -PassThru

function Get-FirstUrlCacheEntry {
    $bufferSize = 0
    $hEntry = [WinInet]::FindFirstUrlCacheEntryA([IntPtr]::Zero, [IntPtr]::Zero, [ref]$bufferSize)
    if ($hEntry -eq [IntPtr]::Zero) {
        Write-Error "No cache entry found or error occurred."
        return
    }

    $buffer = [System.Runtime.InteropServices.Marshal]::AllocHGlobal($bufferSize)
    [WinInet]::FindNextUrlCacheEntryA($hEntry, $buffer, [ref]$bufferSize)
    [System.Runtime.InteropServices.Marshal]::FreeHGlobal($buffer)
}