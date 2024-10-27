# MockMalAPI
MockMalAPI is a PowerShell-based project aimed at simulating the behavior of misused Windows API functions as documented on MalAPI.io.
# List of Function available
| Function Name                   | Description |
|--------------------------------|-------------|
| CreateToolhelp32Snapshot       | Creates a snapshot of the specified processes, heaps, modules, and threads currently running in the system. |
| EnumDesktopWindows             | Enumerates all top-level windows associated with the desktop, providing a handle for each. |
| EnumDeviceDrivers              | Enumerates the loaded device drivers in the system and retrieves information about them. |
| EnumProcesses                  | Enumerates all the processes currently running on the system. |
| EnumProcessModules             | Enumerates all the modules loaded by a specified process. |
| EnumProcessModulesEx           | Extended version of EnumProcessModules that supports 64-bit systems. |
| EnumResourceTypesA             | Enumerates the types of resources in a specified module. |
| EnumResourceTypesExA           | Extended version of EnumResourceTypesA that allows specifying additional parameters like language ID. |
| EnumSystemLocalesA             | Enumerates system locales available on the computer. |
| EnumWindows                    | Enumerates all top-level windows on the screen, providing their handles. |
| FindFiles                      | Searches for files matching a specified pattern in a directory. |
| FindUrlCacheEntryA             | Finds the first entry in the URL cache. |
| GetAdaptersInfo                | Retrieves adapter information for network interfaces, including IP addresses and configuration. |
| GetComputerNameA               | Retrieves the NetBIOS name of the local computer. |
| GetCurrentHwProfileA           | Retrieves information about the current hardware profile of the system. |
| GetCurrentProcess              | Retrieves a pseudo handle for the current process. |
| GetCurrentProcessId            | Retrieves the process identifier of the calling process. |
| GetCurrentThread               | Retrieves a pseudo handle for the calling thread. |
| GetCurrentThreadId             | Retrieves the thread identifier of the calling thread. |
| GetDriveTypeA                  | Determines whether a disk drive is a removable, fixed, CD-ROM, RAM disk, or network drive. |
| GetFileAttributesA             | Retrieves attributes for a specified file or directory. |
| GetFileTime                    | Retrieves the creation, last access, and last write times for a specified file. |
| GetIpNetTable                  | Retrieves the IP-to-physical address mapping table (ARP table). |
| GetLogicalDrives               | Retrieves a bitmask representing the currently available disk drives. |
| GetLogicalProcessorInformation | Retrieves information about logical processors and caches in the system. |
| GetLogicalProcessorInformationEx | Extended version of GetLogicalProcessorInformation that provides detailed information about processor relationships. |
| GetModuleBaseNameA             | Retrieves the base name of a specified module for a given process. |
| GetNativeSystemInfo            | Retrieves information about the current system, such as architecture and number of processors. |
| GetProcessId                   | Retrieves the process identifier of a specified process handle. |
| GetProcessIdOfThread           | Retrieves the process identifier of the process associated with a specified thread. |
| GetSystemDefaultLangId         | Retrieves the language identifier for the system default language. |
| GetSystemDirectoryA            | Retrieves the path to the system directory. |
| GetSystemTime                  | Retrieves the current system time. |
| GetSystemTimeAsFileTime        | Retrieves the current system time as a file time structure. |
| GetThreadId                    | Retrieves the thread identifier of a specified thread handle. |
| GetThreadInformation           | Retrieves information about a specified thread. |
| GetThreadLocale                | Retrieves the current locale of the calling thread. |
| GetUserNameA                   | Retrieves the user name of the current thread's security context. |
| GetVersionExA                  | Retrieves version information about the operating system. |
| GetWindowsDirectoryA           | Retrieves the path of the Windows directory. |
| IsWoW64Process                 | Determines whether the specified process is running under WOW64, which allows 32-bit applications to run on 64-bit Windows. |
| LookupAccountNameA             | Retrieves the SID for a given account name. |
| LookupPrivilegeValueA          | Retrieves the locally unique identifier (LUID) for a privilege. |
| NetShareEnum                   | Enumerates network shares on a server. |
| NetShareGetInfo                | Retrieves information about a particular shared resource on a server. |
| NtQueryDirectoryFile           | Queries the directory file for detailed information about files. |
| NtQueryInformationProcess      | Retrieves information about a specified process. |
| NtQuerySystemEnvironmentValueEx | Retrieves information about a specified system environment value. |
| PathFileExistsA                | Determines whether a file or directory exists. |
| Process32                      | Enumerates the processes running on the system using Process32First and Process32Next. |
| ReadFile                       | Reads data from a specified file or input/output (I/O) device. |
| ReadProcessMemory              | Reads data from a specified area in the virtual memory of a given process. |
| RegEnumKeyA                    | Enumerates the subkeys of the specified open registry key. |
| RegQueryValueExA               | Retrieves the type and data of a specified value name associated with an open registry key. |
| RtlGetVersion                  | Retrieves version information about the operating system. |
| SearchPathA                    | Searches for a specified file in a specified path. |
| VirtualQueryEx                 | Retrieves information about a region of virtual memory in a specified process. |
| WNetAddConnection2A            | Makes a connection to a network resource with additional connection options. |
| WNetAddConnectionA             | Makes a connection to a network resource. |
| WNetCloseEnum                  | Ends a network resource enumeration. |
| WNetEnumResourceA              | Continues an enumeration of network resources. |

