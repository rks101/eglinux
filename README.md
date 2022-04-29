# eglinux 
<!--[muscot](https://commons.wikimedia.org/wiki/File:Tux.png)-->
eglinux => pronounced as "easy Linux" compiles - easy and helpful Linux commands for beginners and intermediate users.   

Voluntary Disclosure: The output shown for commands or utilities mentioned below is compiled for illustration purpose only. You may not find all or same details in your lab/office/dungeon.   

   * [eglinux](#eglinux)
      * [`ls -lrt`](#ls--lrt)
      * [`lsb_release`](#lsb_release)
      * [Know processors](#know-processors)
      * [Know memory](#know-memory)
      * [Process Memory Layout using `proc`](#process-memory-layout)
      * [List hardware using `lshw`](#list-hardware)
      * [The One with File Permissions](#the-one-with-file-permissions) 
      * [Command completion](#command-completion)
      * [Installed packages](#installed-packages)
      * [Environment variables](#environment-variables)
      * [Debugging](#debugging)
      * [Getting help on-system](#getting-help-on-system)
      * [Simple web server](#simple-web-server)
      * [The One with mysql admin password](#the-one-with-mysql-admin-password)
      * [Remove old Linux kernel images](#remove-old-linux-kernel-images)
      * [Free space on Ubuntu system](#free-space-on-ubuntu-system)
      * [The One with Linus](#the-one-with-linus)


## ls -lrt
Everytime you open terminal or shell, the first command you should check out to list all files and directries (ls) in a long (l) and reverse (r) order of time (t) updated. Do compare this output with various other outputs from ls options.    
```
ls -lrt
```

## lsb_release
What is OS major and minor release numbers? and any code name associated with the release?   
```
lsb_release -a  
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.1 LTS
Release:	20.04
Codename:	focal
```
Note:- LSB is Linux Standard Base. If you are more interested, after this article you can refer to [what is LSB](https://wiki.linuxfoundation.org/lsb/start) and [LSB Specs](https://refspecs.linuxfoundation.org/lsb.shtml). To maintain the flow, continue reading.  

TIMTOWTDI (There Is More Than One Way To Do It): you can use /etc/os-release 
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

What is my system name, kernel, OS, kernel version, date last updated?  
```
uname -a  
Linux Latitude-3490 5.4.0-58-generic #64-Ubuntu SMP Wed Dec 9 08:16:25 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
```

## Know processors
How many processors do we have on the system? To know details and processor flags:   
```
cat /proc/cpuinfo  
cat /proc/cpuinfo | grep "processor"  
```
Check the output. If you get eight entries with processor numbered from 0 to 7, this suggests 8 logical cores.  

## Know memory
How much memory (RAM / main memmory / primary memory to run programs) do we have on the system? You can see installed, free, and other memory details:  
```
cat /proc/meminfo  
```
Check the output for MemTotal, MemFree, MemAvailable.  

Note: Why should you consider MemAvailable from 2014 onward? [Check this patch](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34e431b0ae398fc54ea69ff85ec700722c9da773) and [post 1](https://stackoverflow.com/questions/30869297/difference-between-memfree-and-memavailable) and [post 2](https://superuser.com/questions/980820/what-is-the-difference-between-memfree-and-memavailable-in-proc-meminfo). To maintain the flow, continue reading.   

Note:- It is good to learn about [types of RAM](https://www.techtarget.com/searchstorage/definition/DIMM), such as earlier SIMM, and DIMM, bufferred memory, Load Reduced or LR-DIMM (with iMB to isolate data and address), Small Outline or SO-DIMM (compact form factor for recent laptops/tablets), etc. A post on [which one to use](https://www.dasher.com/server-memory-rdimm-vs-lrdimm-and-when-to-use-them/) and [difference](https://www.faceofit.com/rdimm-vs-irdimm-vs-udimms/) can be helpful. To maintain the flow, continue reading.    

---- 

## Process Memory Layout 
This one is my favorite topic in OS lab. Helps to visualise virtual memory, process layout, proc interface, and shared libs/objects.     

Can I see the memory layout and the stack of a process? See my [presentation]() with more details.   
To see all files related to a process with PID = $$  
``` 
ls -lrt /proc/$$
```
Now, check process memory layout (TODO: add link from OS course file having exercises on proc):   
```
cat /proc/$$/maps 
```

and stack associated with process $$:  
```
cat /proc/$$/stack
```
Using the output of the above commands, convince yourself that you can visualise stack, heap, text segment of a process using virtual addresses and the output. Also, see /lib/x84_64-linux-gnu/lib\*  files and other shared libraries.  
In the above example, replace $$ with a process id you are interested in.  


What shared object / libraries are used by a program? 

```
$ ldd <program>
$ ldd /bin/bash
$ ldd /bin/ls
$ ldd /usr/bin/python3.8 
```

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

There is a GUI as well for hardware info.   

On Ubuntu to get hardinfo:  
```
sudo apt install hardinfo 
```
----
## The One with File Permissions   

A linux user is a regular user or a system user (without login) or superuser aka root.   

Notice the first column of /etc/passwd file is a linux user.   

```
$ cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
systemd-network:x:100:102:systemd Network Management,,,:/run/systemd/netif:/usr/sbin/nologin
syslog:x:102:106::/home/syslog:/usr/sbin/nologin
avahi:x:116:122:Avahi mDNS daemon,,,:/var/run/avahi-daemon:/usr/sbin/nologin
gdm:x:121:125:Gnome Display Manager:/var/lib/gdm3:/bin/false
rps:x:1000:1000:rps,,,:/home/rps:/bin/bash
mysql:x:122:129:MySQL Server,,,:/nonexistent:/bin/false
systemd-timesync:x:123:130:systemd Time Synchronization,,,:/run/systemd:/usr/sbin/nologin
tcpdump:x:125:133::/nonexistent:/usr/sbin/nologin
systemd-coredump:x:999:999:systemd Core Dumper:/:/usr/sbin/nologin
```

Linux user can belong to one or more groups. Group level rights can be defined for users inside it. User and group are two different things, they can have a same name. A user can belong to multiple groups for defined access rights.   

Notice /etc/group file, first column is a group name.   

```
$ cat /etc/group
root:x:0:
daemon:x:1:
bin:x:2:
sys:x:3:
adm:x:4:syslog,rps
tty:x:5:syslog
disk:x:6:
lp:x:7:
mail:x:8:
```

Memorise the first command we learnt, ls -lrt, now type this in any directory for files and see the output.   
First column shows file permission mode, column 3 and 4 show owner and group names respectively.   

File permission mode can be viewed as:   
=> first char is file type, - for regular file, d for directory, l for symbolic link   
=> next view 3 characters in pair - first three chars for user or owner who owns a file, next for group and last three for other than group users.   
=> these three chars pairs contain access permissions in order: r = read, w = write or x = execute   
=> there is a numeric weight associated with r, w, and x. r => 4, w => 2, and x = 1 and we can sum if any of r/w/x is present (see examples below)   
=> if a user is missing a certain access permission that respective character is displayed as - or numerically adds up to 0   

Using r - regular file can be opened in read-only mode, directory cantent can be listed (cd to directory is not allowed by r)   
Using w - regular file can be edited, deleted, renamed, modified and saved, directory can be created inside a directory, deleted, renamed, access can be modifed as well.   
Using x - regular file can be executed if it is a script, directory can be accessed, cd to directory is allowed by x   

Some examples of file permissions are listed below.   

-rwx------ : regular file, (400), only owner can read, write, execute this file.   
-rw-r--r-- : regualr file, (544), anyone can read, only owner can modify or delete.   
drwxr-xr-x : directory, (755), owner can read, write and access directory, group and other users can read contents and access it, cd is allowed   
-rwxr-xr-x : regular file, (755), only owner can modify or delete, however anyone can read or execute it   

Using chmod you can modify file permissions. You can grant (+) ore revoke (-) for one or more users.   
Grant r or w or x permission using +r or +w or +x    
Revoke r or w or x permission using -r or -w or -x    
Before + or -, specify groups without space.    

chmod +x : grant execute permission to all    
chmod g+w : grant write permission to same group users   
chmod go+r : grant read permission to group and other users    
chmod 777 : grant rwx to owner, group and non-group users, be very careful why such permission mode is being set    
chmod 744 : grant rwx to user and read to group and others    

Recall /bin/sh is a shell.    

```
$ ls -lrt /bin/sh
lrwxrwxrwx 1 root root 4 Mar 23 19:19 /bin/sh -> dash
```

Using buffer overflow, if a remote user can get a shell /bin/sh executing some shellcode, then what he can do - try to visualise using permissions of /bin/sh - specifically see owner and all permissions.   

----
## Command completion
Learn to use tab key for command completion or completing file / directory names. This can save time in typing.  

Hint: type ds and press tab to see command completion (e.g. dstat) if exists or to see matching options.  
Hint: type ls -lrt /home/rps/Do  and then press tab twice, you will get matching suggestions.  

Tip: in case command completion is not working on system, check you have installed bash-completion and bash-completion-extras  
A related [long story](https://unix.stackexchange.com/questions/264102/bash-completion-is-very-incomplete-on-centos-7).  

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
If you want newly added directory to be searched first in the path, add the new directory first and then append existing contents of path variable. Use which command to locate the first binary or built-in util being referenced.    

----
What is a path? How do we refer to it in commands?  

Path helps to navigate around the file system and files in Linux where almost everything is a file.  
In the hierarchical directory structure, we can refer path of a regular file (-) or directory (d) or symbolic link (l) using absolute or a relative path.  
Absolute path corresponds to a path beginning from / or root. e.g. /home/rps/example.desktop  
Relative path corresponds to a path relative to current directory (pwd) or any other directory. e.g. Downloads/package.deb or ../../home/rps/Downloads/package.deb 

----
## Debugging

For debugging issues, the following can help about processes and system resources.  

Use **top** command to display linux processes with PID, CPU and memory usage in real-time. Avoid this using for a long time on servers with active users.   
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

What if I do not know commands or their options and arguments?   
- To know about Linux built-ins and commands, there are plain text on-screen manuals.   
- There is a **man** I know from 2003 who can help, and he tells me the most from reliable sources.   
- Always ask **man**, using: 
```
man man 
man cd 
man uname 
man touch 
man timedatectl 
man execve 
man service 
man find 
man grep 
man info 
```
Also, you can explore **info** pages.  

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

Note:- In case you are struggling to connect to this webserver to access files from another system, check your wired/wireless network or vlan you are on.   

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
## The One with mysql admin password
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

Note on - **MySQL authentication** error   

There is an issue about authentication plugin while upgrading or migrating MySQL database (from 5.7) to 8.0.   
Error message on the screen is not very informative about it - ERROR 1698 - Access Denied for user 'root'@'localhost'.   

The default authentication type in mysql 8.0 is **caching_sha2_password** and this newer plugin may not load or is not available.   
One way to get around is alter database user to use earlier authentication type as mysql_native_password (as in mysql-5.7) or better migrate to cashing_sha2_password for future.    

Relevant posts on this auhentication type conundrum:    
[A Tale of Two Password Authentication plugins](https://dev.mysql.com/blog-archive/a-tale-of-two-password-authentication-plugins/)    
[change authentication methods](https://ostechnix.com/change-authentication-method-for-mysql-root-user-in-ubuntu/)    
[alter user with mysql_native_password](https://medium.com/@crmcmullen/how-to-run-mysql-8-0-with-native-password-authentication-502de5bac661)    

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
----

## Free space on Ubuntu system

Find thumbnail images and remove them. 
```
$ du -sh ~/.cache/thumbnails 
$ sudo rm -rf ~/.cache/thumbnails/* 
```

APT related cleanup of unused packages. 
```
$ sudo apt autoremove --purge
```

Remove old kernel files manually. Caution: Know what you are deleting! Do not delete current and previous kernel image/headers and  module files. 
```
$ sudo dpkg --list 'linux-*'
$ sudo apt remove linux-image-5.0*
$ sudo apt remove linux-headers-5.0*
$ sudo apt remove linux-modules-5.0*
$ sudo apt remove linux-modules-extra-5.0*
```

Find APT cache and clean it up. 

```
$ sudo du -sh /var/cache/apt
$ sudo apt clean
```

Clean journal log files. Caution: Know what you are deleting! 

```
$ journalctl --disk-usage
$ sudo journalctl --vacuum-time=7d   <= older than 7 days 
```

Clean up that stuff audio/video/movie files, duplicate photos on the system.  

Just in case you run out of space, check dmesg and try to clean up the last activity that caused it. It may be excessive logs generated.   

----

## The One with UNIX/Linux History 

One can say, in a very crude way:    
open-source OS is - free to download from online repo, free to use, or modify (no license cost) - free refers to freedom of choice! there may be a packaging or  shipping cost or a support cost.    
closed source OS is someone's proprietary binary source files and user cannot modify source, usually this comes with a license cost or cost is added with accompanying device being sold.   

Some closed-source early UNIX favours:   
BSD UNIX: Berkeley Software Distribution had three flavours or varients, such as freeBSD, openBSD, netBSD.    
SCO UNIX: was based on freeBSD, managed by Santa Cruz Operations, later sold to OpenServer maintainer.    
Solaris:   
AIX:   
HP-UX:    
Mac OS:   

Some open-source UNIX/linux favours/varients:   
Linux:    
Debian:   
Ubuntu:   
Fedora:    
Open SUSE:   
CentOS:    

Q. Does a mainframe or AS400 run Unix/Linux?   
A. Unix that ran or runs on Mainframe is called AIX (POSIX compliant). AS400 - specifically IBM iSeries or System i or IBM i run Linux with ease.   

Some reading material:   
[1](http://www.linfo.org/flavors.html)   
[2](https://www.lifewire.com/unix-flavors-list-4094248)   
[FreeBSD](https://en.wikipedia.org/wiki/FreeBSD)    

---- 

## The One with Linus

[The talk with not so visionary, not so people-person, a simple happy engineer](https://www.youtube.com/watch?v=o8NPllzkFhE) Linus Torvalds who changed the world at least twice with Linux and Git projects.   


----

## Thank you 

I am grateful, if you have reached this far after reading the content above.  
If you have learnt something new, that's awesome! Thank you!   
