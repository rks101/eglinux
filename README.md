# eglinux
Easy and helpful Linux commands for beginners and intermediate users  

Everytime you open terminal or shell, the first command you should check out to list all files and directries (ls) in a long (l) and reverse (r) order of time (t) updated.  
```
ls -lrt
```


What is OS major and minor numbers amd any code name associated with the release  
```
lsb_release -a  
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.1 LTS
Release:	20.04
Codename:	focal
```


What is my system name, kernel, OS, kernel version, date updated?  
```
uname -a  
Linux Latitude-3490 5.4.0-58-generic #64-Ubuntu SMP Wed Dec 9 08:16:25 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
```


How many processors do we have on the system? Details and processor flags?  
```
cat /proc/cpuinfo  
cat /proc/cpuinfo | grep "processor"  
```
Check the output. If you get 8 entries with processor numbered from 0 to 7, this suggests an 8 core cpu.  


How much memory (RAM) do we have on the system? Installed, free, and other memory details?  
```
cat /proc/meminfo  
```
Check the output for MemTotal, MemFree, MemAvailable  


---- 
Can I see the memory layout and the stack of a process?  
To see all files related to a process with PID = $$  
``` 
ls -lrt /proc/$$
```
Now, check process memory layout:  
```
cat /proc/$$/maps 
```

and stack associated with process $$:  
```
cat /proc/$$/stack
```
Using the output of the above commands, convince yourself that you can visualise stack, heap, text segment of a process using virtual addresses and the output. Also, see /lib/x84_64-linux-gnu/lib\*  files and other shared libraries.  
In the above example, replace $$ with a process id you are interested in.  

---- 
How can I list hardware details?  
```
lshw
lshw -short
```

It is nice to know about system hardware such as hard disk, audio and network controllers (wired and wifi)  
```
lshw | grep -A7 -i "disk"  <== Hard disk details  
lshw -short <== for graphics card, look for display  
lspci -v | grep -A7 -i "audio"  <== Audio device details  
lspci -v | grep -A7 -i "eternet"  <== Network Controller for Ethernet (LAN)  
lspci -v | grep -A7 -i "wireless"  <== Network Controller for wireless (Wi-Fi)  
```

There is a GUI as well for hardware info:  
On Ubuntu to get hardinfo:  
```
sudo apt install hardinfo 
```


----
How do I find out installed software packages? 
```
sudo dpkg --get-selections
```
This is equivalent to rpm -qa in case of RHEL/Fedora/CentOS. 

----
How to display and change environment variables? 

List all environment variables using printenv. 
List a variable called PATH
```
echo $PATH
```
Change path to include Videos directory
```
$ echo $PATH
/home/rps/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
$ export PATH=$PATH:/home/rps/Videos
$ echo $PATH
/home/rps/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/rps/Videos

```

----
Debugging - processes and system resources  

Use **top** command to display linux processes with PID, CPU and memory usage in real-time  
```
$ top

top - 10:34:56 up 6 days, 21:06,  1 user,  load average: 0.80, 0.51, 0.55  
Tasks: 333 total,   1 running, 323 sleeping,   8 stopped,   1 zombie  
%Cpu(s):  0.7 us,  0.4 sy,  0.0 ni, 98.2 id,  0.6 wa,  0.0 hi,  0.0 si,  0.0 st  
MiB Mem :  15908.0 total,   3389.9 free,   5168.0 used,   7350.0 buff/cache  
MiB Swap:  30518.0 total,  30518.0 free,      0.0 used.   9270.3 avail Mem  

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND  
   7648 msg       20   0 7303440 507100 143564 S   6.0   3.1 166:37.55 zoom  
   2142 msg       20   0 5153328 399196 130928 S   1.3   2.5 141:03.20 gnome-shell  
   3241 msg       20   0 1551784 368148 186284 S   1.0   2.3  55:48.93 chrome  
   3286 msg       20   0  390048 111048  68588 S   0.7   0.7  15:12.61 chrome  
 100726 mysql     20   0 2265400 399708  35948 S   0.7   2.5   1:17.47 mysqld  
 129414 msg       20   0   12336   4372   3408 R   0.7   0.0   0:00.05 top  
    883 root      20   0  484176  21492  17276 S   0.3   0.1   1:08.84 NetworkManager  
```

Use **dstat** - a tool for generating system resource statistics such as cpu usage, disk read/write, network data received/sent, etc. To exit type Ctrl+C.    
```
$ dstat
You did not select any stats, using -cdngy by default.
--total-cpu-usage-- -dsk/total- -net/total- ---paging-- ---system--
usr sys idl wai stl| read  writ| recv  send|  in   out | int   csw 
 27   8  64   0   0|5502B   24k|   0     0 |   0     0 | 649  1159 
  2   1  96   1   0|   0    60k| 226B  234B|   0     0 |2176  3796 
  3   1  96   0   0|   0     0 | 303B  405B|   0     0 |2150  3753 
  3   1  95   0   0|   0     0 |1266B 1246B|   0     0 |2272  3889 
  3   1  96   0   0|   0     0 | 984B  786B|   0     0 |2378  3952 ^C

```

----
How can I find out about a service or daemon running or not? 
```
service <service_or_daemon_name> status 
service mysql status 
service apache2 status 
```
See the output, if Active field shows "active (running)", it is running, good to go. 
If Active field shows failed, there was some problem to run the service, need to fix it. 


Where do I see for logs and errors? 
```
dmesg 
ls -lrt /var/log/ 
```
In /var/log/ directory, see the most recent logs, like dmesg, syslog, dpkg log, etc. to debug the problem.  

----
To know about Linux bulit-ins and commands, always ask man, using: 
```
man man 
man cd 
man uname 
man touch 
man timedatectl 
man execve 
man service 
```

----  
Cool compilers/interpreters:  
clang  
gcc  
g++  
java  
python  

To check if Java runtime environment (JRE) is installed: $ java --version  
To see if Java SDK is installed: $ javac  

---- 
Sometime(s), you may forget mysql admin password and you want to reset the password.  

Login into mysql using sudo and issue the below command: 
```
alter user 'root'@'localhost' identified with mysql_native_password by 'nopassisgoodpass';
```

**To backup mysql db**  
```
mysqldump --databases testdb --user=root --password > backupdb.sql
```

If required on the target system, set password using alter user command as above.  

**To restore mysql db**  
```
mysql -u root -p < backupdb.sql
```
---- 
