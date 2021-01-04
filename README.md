# eglinux
Easy and helpful Linux commands for beginners and intermediate users  

Everytime you open terminal or shell, the first command you should check out to list all files and directries (ls) in a long (l) and reverse (r) order of time (t) updated.  
**ls -lrt**  
```
ls -lrt
```


What is OS major and minor numbers amd any code name associated with the release  
**lsb_release -a**  
Output for me is:  
```
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.1 LTS
Release:	20.04
Codename:	focal
```


What is my system name, kernel, OS, kernel version, date updated?  
**uname -a**  
Outout can be:  
```
Linux Latitude-3490 5.4.0-58-generic #64-Ubuntu SMP Wed Dec 9 08:16:25 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
```


How many processors do we have on the system? Details and processor flags?  
**cat /proc/cpuinfo**  
**cat /proc/cpuinfo | grep "processor"**  check the output. If you get 8 entries with processor numbered from 0 to 7, this suggests an 8 core cpu.  

How much memory (RAM) do we have on the system? Installed, free, and other memory details?  
**cat /proc/meminfo**  check the output for MemTotal, MemFree, MemAvailable  


Can I see the stack of a process?  



Can I see the process memory layout of a process?  


