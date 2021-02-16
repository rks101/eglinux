# eglinux
Easy and helpful Linux commands for beginners and intermediate users  

* [eglinux](#eglinux)
  * [ls -lrt](#ls--lrt)
  * [lsb_release](#lsb_release)
  * [Know processors](#know-processors)
  * [Know memory](#know-memory)
  * [Process Memory Layout](#process-memory-layout)
  * [List hardware](#list-hardware)
  * [Command completion](#command-completion)
  * [Installed packages](#installed-packages)
  * [Environment variables](#environment-variables)
  * [Debugging](#debugging)
  * [Getting help on-system](#getting-help-on-system)
  * [Simple web server](#simple-web-server)
  * [Reset mysql admin password](#Reset-mysql-admin-password)
  * [Remove old Linux kernel images](#remove-old-linux-kernel-images)


## ls -lrt
Everytime you open terminal or shell, the first command you should check out to list all files and directries (ls) in a long (l) and reverse (r) order of time (t) updated.  
```
ls -lrt
```

## lsb_release
What is OS major and minor numbers amd any code name associated with the release  
```
lsb_release -a  
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.1 LTS
Release:	20.04
Codename:	focal
```
TIMTOWTDI: you can use /etc/os-release 
```
$ cat /etc/os-release 
NAME="Ubuntu"
VERSION="20.04.2 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04.2 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
......
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal

```


What is my system name, kernel, OS, kernel version, date updated?  
```
uname -a  
Linux Latitude-3490 5.4.0-58-generic #64-Ubuntu SMP Wed Dec 9 08:16:25 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
```

## Know processors
How many processors do we have on the system? Details and processor flags?  
```
cat /proc/cpuinfo  
cat /proc/cpuinfo | grep "processor"  
```
Check the output. If you get 8 entries with processor numbered from 0 to 7, this suggests 8 logical cores.  

## Know memory
How much memory (RAM) do we have on the system? Installed, free, and other memory details?  
```
cat /proc/meminfo  
```
Check the output for MemTotal, MemFree, MemAvailable  


---- 

## Process Memory Layout 
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

## List hardware 
How can I list hardware details?  
```
lshw
lshw -short
```

It is nice to know about system hardware such as hard disk, graphics card, audio and network controllers (wired and wifi)  
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
## Command completion
Learn to use tab key for command completion or completing file / directory names. This can save time in typing.  

Hint: type ds and press tab to see command completion (e.g. dstat) if exists or to see matching options.  
Hint: type ls -lrt /home/rps/Do  and then press tab twice, you will get matching suggestions.  

----
## Installed packages
How do I find out installed software packages? 
```
sudo dpkg --get-selections
```
This is equivalent to rpm -qa in case of RHEL/Fedora/CentOS. 

----
## Environment variables
How to display and change environment variables? 

List all environment variables using printenv 
```
printenv
SHELL=/bin/bash
COLORTERM=truecolor
XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg
LANGUAGE=en_IN:en
PWD=/home/rps
LOGNAME=rps
......
HOME=/home/rps
USERNAME=rps
USER=rps                   <= check echo $USER
......
_=/usr/bin/printenv        <= check echo $_

```
List a special environment variable called PATH
```
echo $PATH
```
Change PATH variable to include Videos directory
```
$ echo $PATH
/home/rps/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
$ export PATH=$PATH:/home/rps/Videos
$ echo $PATH
/home/rps/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/rps/Videos

```

----
What is a path? How do we refer to it in commands?  

Path helps to navigate around the file system and files in Linux where almost everything is a file.  
In the hierarchical directory structure, we can refer path of a regular file (-) or directory (d) or symbolic link (l) using absolute or a relative path.  
Absolute path corresponds to a path beginning from / or root. e.g. /home/rps/example.desktop  
Relative path corresponds to a path relative to current directory (pwd) or any other directory. e.g. Downloads/package.deb or ../../home/rps/Downloads/package.deb  

----
## Debugging

For debugging issues, the following can help about processes and system resources.  

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
## Getting help on-system 

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
Also, you can explore info pages.  

----
## Simple web server 
One line webserver => a great and simplest way to show files from a directory  
```
$ python3 -m http.server 
Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
127.0.0.1 - - [03/Feb/2021 23:33:21] "GET / HTTP/1.1" 200 -
127.0.0.1 - - [03/Feb/2021 23:33:31] "GET /myvideos/ HTTP/1.1" 200 -
127.0.0.1 - - [03/Feb/2021 23:33:36] "GET /Downloads/ HTTP/1.1" 200 -
^C 
Keyboard interrupt received, exiting.

```
The webserver started above can be opened in a web browser: http://0.0.0.0:8000/  
This page can be opened before you close the server using Ctrl+C.  

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
## Reset mysql admin password
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

## Remove old Linux kernel images 
How do we remove old linux kernel images and headers?  

At times, one can find on the system some old linux-images / linux-headers / linux-modules that are occupying storage. If you want to remove these old linux kernel images and headers (5.0* / 5.3*), while you have upgraded to higher versions (5.4*):  

- first, query using uname -a and dpkg --list | egrep "linux-image|linux-headers|linux-modules|linux-image-generic" | awk '{print $2 " " $3}'  
- next, use apt purge linux-image-5.0* or apt purge linux-image-5.4.2*  
- Take precaution, you should not remove the current and the previous images/headers.  

```
$ uname -a
Linux Latitude-3490 5.4.0-65-generic #73-Ubuntu SMP Mon Jan 18 17:25:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

$ dpkg --list | egrep "linux-image|linux-headers|linux-modules|linux-image-generic" | awk '{print $2 " " $3}'
linux-headers-5.4.0-64 5.4.0-64.72
linux-headers-5.4.0-64-generic 5.4.0-64.72
linux-headers-5.4.0-65 5.4.0-65.73
linux-headers-5.4.0-65-generic 5.4.0-65.73
linux-headers-generic 5.4.0.65.68
linux-image-5.4.0-26-generic 5.4.0-26.30
linux-image-5.4.0-28-generic 5.4.0-28.32
linux-image-5.4.0-29-generic 5.4.0-29.33
linux-image-5.4.0-31-generic 5.4.0-31.35
linux-image-5.4.0-33-generic 5.4.0-33.37
linux-image-5.4.0-37-generic 5.4.0-37.41
linux-image-5.4.0-39-generic 5.4.0-39.43
linux-image-5.4.0-40-generic 5.4.0-40.44
linux-image-5.4.0-42-generic 5.4.0-42.46
linux-image-5.4.0-47-generic 5.4.0-47.51
linux-image-5.4.0-48-generic 5.4.0-48.52
linux-image-5.4.0-51-generic 5.4.0-51.56
linux-image-5.4.0-52-generic 5.4.0-52.57
linux-image-5.4.0-53-generic 5.4.0-53.59
linux-image-5.4.0-54-generic 5.4.0-54.60
linux-image-5.4.0-56-generic 5.4.0-56.62
linux-image-5.4.0-58-generic 5.4.0-58.64
linux-image-5.4.0-59-generic 5.4.0-59.65
linux-image-5.4.0-60-generic 5.4.0-60.67
linux-image-5.4.0-62-generic 5.4.0-62.70
linux-image-5.4.0-64-generic 5.4.0-64.72
linux-image-5.4.0-65-generic 5.4.0-65.73
linux-image-generic 5.4.0.65.68
linux-modules-5.0.0-23-generic 5.0.0-23.24~18.04.1
linux-modules-5.0.0-32-generic 5.0.0-32.34~18.04.2
linux-modules-5.0.0-36-generic 5.0.0-36.39~18.04.1
linux-modules-5.0.0-37-generic 5.0.0-37.40~18.04.1
linux-modules-5.3.0-26-generic 5.3.0-26.28~18.04.1
linux-modules-5.3.0-28-generic 5.3.0-28.30~18.04.1
linux-modules-5.3.0-40-generic 5.3.0-40.32~18.04.1
linux-modules-5.3.0-42-generic 5.3.0-42.34~18.04.1
linux-modules-5.3.0-46-generic 5.3.0-46.38~18.04.1
linux-modules-5.4.0-26-generic 5.4.0-26.30
linux-modules-5.4.0-28-generic 5.4.0-28.32
linux-modules-5.4.0-29-generic 5.4.0-29.33
linux-modules-5.4.0-31-generic 5.4.0-31.35
linux-modules-5.4.0-33-generic 5.4.0-33.37
linux-modules-5.4.0-37-generic 5.4.0-37.41
linux-modules-5.4.0-39-generic 5.4.0-39.43
linux-modules-5.4.0-40-generic 5.4.0-40.44
linux-modules-5.4.0-42-generic 5.4.0-42.46
linux-modules-5.4.0-47-generic 5.4.0-47.51
linux-modules-5.4.0-48-generic 5.4.0-48.52
linux-modules-5.4.0-51-generic 5.4.0-51.56
linux-modules-5.4.0-52-generic 5.4.0-52.57
linux-modules-5.4.0-53-generic 5.4.0-53.59
linux-modules-5.4.0-54-generic 5.4.0-54.60
linux-modules-5.4.0-56-generic 5.4.0-56.62
linux-modules-5.4.0-58-generic 5.4.0-58.64
linux-modules-5.4.0-59-generic 5.4.0-59.65
linux-modules-5.4.0-60-generic 5.4.0-60.67
linux-modules-5.4.0-62-generic 5.4.0-62.70
linux-modules-5.4.0-64-generic 5.4.0-64.72
linux-modules-5.4.0-65-generic 5.4.0-65.73
linux-modules-extra-5.0.0-23-generic 5.0.0-23.24~18.04.1
linux-modules-extra-5.0.0-32-generic 5.0.0-32.34~18.04.2
linux-modules-extra-5.0.0-36-generic 5.0.0-36.39~18.04.1
linux-modules-extra-5.0.0-37-generic 5.0.0-37.40~18.04.1
linux-modules-extra-5.3.0-26-generic 5.3.0-26.28~18.04.1
linux-modules-extra-5.3.0-28-generic 5.3.0-28.30~18.04.1
linux-modules-extra-5.3.0-40-generic 5.3.0-40.32~18.04.1
linux-modules-extra-5.3.0-42-generic 5.3.0-42.34~18.04.1
linux-modules-extra-5.3.0-46-generic 5.3.0-46.38~18.04.1
linux-modules-extra-5.4.0-26-generic 5.4.0-26.30
linux-modules-extra-5.4.0-28-generic 5.4.0-28.32
linux-modules-extra-5.4.0-29-generic 5.4.0-29.33
linux-modules-extra-5.4.0-31-generic 5.4.0-31.35
linux-modules-extra-5.4.0-33-generic 5.4.0-33.37
linux-modules-extra-5.4.0-37-generic 5.4.0-37.41
linux-modules-extra-5.4.0-39-generic 5.4.0-39.43
linux-modules-extra-5.4.0-40-generic 5.4.0-40.44
linux-modules-extra-5.4.0-42-generic 5.4.0-42.46
linux-modules-extra-5.4.0-47-generic 5.4.0-47.51
linux-modules-extra-5.4.0-48-generic 5.4.0-48.52
linux-modules-extra-5.4.0-51-generic 5.4.0-51.56
linux-modules-extra-5.4.0-52-generic 5.4.0-52.57
linux-modules-extra-5.4.0-53-generic 5.4.0-53.59
linux-modules-extra-5.4.0-54-generic 5.4.0-54.60
linux-modules-extra-5.4.0-56-generic 5.4.0-56.62
linux-modules-extra-5.4.0-58-generic 5.4.0-58.64
linux-modules-extra-5.4.0-59-generic 5.4.0-59.65
linux-modules-extra-5.4.0-60-generic 5.4.0-60.67
linux-modules-extra-5.4.0-62-generic 5.4.0-62.70
linux-modules-extra-5.4.0-64-generic 5.4.0-64.72
linux-modules-extra-5.4.0-65-generic 5.4.0-65.73

$ sudo apt purge linux-image-5.0*

Reading package lists... Done
Building dependency tree       
Reading state information... Done
Note, selecting 'linux-image-5.0.0-37-generic' for glob 'linux-image-5.0*'
Note, selecting 'linux-image-5.0.0-36-generic' for glob 'linux-image-5.0*'
Note, selecting 'linux-image-5.0.0-23-generic' for glob 'linux-image-5.0*'
Note, selecting 'linux-image-5.0.0-32-generic' for glob 'linux-image-5.0*'
The following packages will be REMOVED:
  linux-image-5.0.0-23-generic* linux-image-5.0.0-32-generic* linux-image-5.0.0-36-generic* 
  linux-image-5.0.0-37-generic*
0 upgraded, 0 newly installed, 4 to remove and 0 not upgraded.
After this operation, 0 B of additional disk space will be used.
Do you want to continue? [Y/n] Y
(Reading database ... 428921 files and directories currently installed.)
Purging configuration files for linux-image-5.0.0-23-generic (5.0.0-23.24~18.04.1) ...
Purging configuration files for linux-image-5.0.0-36-generic (5.0.0-36.39~18.04.1) ...
Purging configuration files for linux-image-5.0.0-37-generic (5.0.0-37.40~18.04.1) ...
Purging configuration files for linux-image-5.0.0-32-generic (5.0.0-32.34~18.04.2) ...

$ sudo apt purge linux-image-5.3*

Reading package lists... Done
Building dependency tree       
Reading state information... Done
Note, selecting 'linux-image-5.3.0-40-generic' for glob 'linux-image-5.3*'
Note, selecting 'linux-image-5.3.0-26-generic' for glob 'linux-image-5.3*'
Note, selecting 'linux-image-5.3.0-42-generic' for glob 'linux-image-5.3*'
Note, selecting 'linux-image-5.3.0-46-generic' for glob 'linux-image-5.3*'
Note, selecting 'linux-image-5.3.0-28-generic' for glob 'linux-image-5.3*'
The following packages will be REMOVED:
  linux-image-5.3.0-26-generic* linux-image-5.3.0-28-generic* linux-image-5.3.0-40-generic* 
  linux-image-5.3.0-42-generic* linux-image-5.3.0-46-generic*
0 upgraded, 0 newly installed, 5 to remove and 0 not upgraded.
After this operation, 0 B of additional disk space will be used.
Do you want to continue? [Y/n] Y
(Reading database ... 428921 files and directories currently installed.)
Purging configuration files for linux-image-5.3.0-46-generic (5.3.0-46.38~18.04.1) ...
Purging configuration files for linux-image-5.3.0-42-generic (5.3.0-42.34~18.04.1) ...
Purging configuration files for linux-image-5.3.0-26-generic (5.3.0-26.28~18.04.1) ...
Purging configuration files for linux-image-5.3.0-28-generic (5.3.0-28.30~18.04.1) ...
Purging configuration files for linux-image-5.3.0-40-generic (5.3.0-40.32~18.04.1) ...

```

