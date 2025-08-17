# eglinux 
<!--[muscot](https://commons.wikimedia.org/wiki/File:Tux.png)-->
eglinux => pronounced as "easy Linux" => compiles easy and helpful Linux commands and pointers for beginners and intermediate users.   

Disclaimer: The output below for commands or utilities is compiled for illustration purposes only. You may not find all the exact details in your lab/office.    

* [eglinux](#eglinux)
    * Part-1
      * [`ls -lrt`](#ls--lrt)
      * [`lsb_release`](#lsb_release)
      * [Getting help on-system](#getting-help-on-system)
      * [Know processors](#know-processors)
      * [Know memory](#know-memory)
      * [GB or GiB](#gb-or-gib)
      * [List hardware using `lshw`](#list-hardware)
      * [Environment Variables](#environment-variables)
      * [PATH](#path)   
      * [Command completion](#command-completion)
      * [Command history](#command-history)
      * [Know File System](#know-file-system)
      * [The One with File Permissions](#the-one-with-file-permissions) 
      * [`su` and `sudo`](#su-and-sudo)
      * [Password caching in `sudo`](#password-caching-in-sudo)
      * [Remote login using `ssh`](#remote-login-using-ssh)
      * [Transfer files using Secure Copy `scp`](#transfer-files-using-secure-copy-scp)
  * Part-2
      * [Processes](#processes)
      * [Process Memory Layout using `proc`](#process-memory-layout)
      * [Kernel Parameters](#kernel-parameters)
      * [Linux capabilities](#linux-capabilities)
      * [Scheduling jobs](#scheduling-jobs)
      * [`nohup`](#nohup)
      * [Shell Scripting](#shell-scripting)
      * [`xdg-open`](#xdg-open)
      * [Systemd versus init based Systems](#systemd-versus-init-based-systems)
      * [Windowing System for GUI](#windowing-system-for-gui) 
      * [Debugging](#debugging)
      * [Simple web server](#simple-web-server)
  * Part-3
      * [crt and key file](#crt-and-key-file) 
      * [The One with mysql admin password](#the-one-with-mysql-admin-password)
      * [Installed packages](#installed-packages)
      * [Remove old Linux kernel images](#remove-old-linux-kernel-images)
      * [Free space on Ubuntu system](#free-space-on-ubuntu-system)
      * [Advantage Linux](#advantage-linux)
      * [The One with Linus](#the-one-with-linus)
      * [Linux Software](#linux-software)
  * Part-4
      * [Linux Security](#linux-security)
      * [Linux Kernel](#linux-kernel)
      * [Virtualization](#virtualization)


## ls -lrt
Every time you open a terminal or shell, the first command you should check out is to list all files and directories (ls) in a long (l) and reverse (r) order of time (t) updated. Do compare this output with various other outputs from ls options. Also, this command helps to see permissions and who touched what files recently.    
```
ls -lrt
```

----

## lsb_release
What is OS major and minor release numbers? and any code name associated with the release?   
```
lsb_release -a  
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.1 LTS
Release:	20.04
Codename:	focal
```
Note:- LSB is Linux Standard Base. If you are more interested, after this article, you can refer to [what is LSB](https://wiki.linuxfoundation.org/lsb/start) and [LSB Specs](https://refspecs.linuxfoundation.org/lsb.shtml). To maintain the flow, continue reading.  

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

[Ubuntu release cycle](https://ubuntu.com/about/release-cycle) - Each April release in even years is LTS (e.g., 18.04, 20.04, 24.04), and supported for 5 to 10 years or more. Production-grade applications should be hosted on LTS releases.     

A Computer System contains:      
- Compute
- Memory
- Network
- (persistent) Storage
- These days all above four component/sub-systems are virtualized.

----

## Getting help on-system 

What if I do not know commands or their options and arguments?   
- Command has a name, options, and/or arguments.   
- There are plain text on-screen manuals about Linux built-ins and commands.   
- There is a **man** I know who can help, and he tells us the most from reliable sources.   
- (While I am not around,) Always ask **man**, using: 
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

Okay, try one of the coolest commands on bash script built-ins:   
```
man [ 
```
[Advanced]: ls -lrt /usr/bin/[ output will confirm it is a binary executable file.    
The source is in the coreutils package, src/lbracket.c and src/test.c    

----

## Know processors
How many processors do we have on the system? To know details and processor flags:   
```
cat /proc/cpuinfo  
cat /proc/cpuinfo | grep "processor"  
```
Could you check the output? If you get eight entries with processors numbered from 0 to 7, this suggests eight logical cores.  

----

## Know memory
How much memory (RAM / main memory / primary memory to run programs) do we have on the system? You can see installed, free, and other memory details:  
```
cat /proc/meminfo  
```
Check the output for MemTotal, MemFree, MemAvailable.  

Note: Why should you consider MemAvailable from 2014 onward? [Check this patch](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34e431b0ae398fc54ea69ff85ec700722c9da773) and [post 1](https://stackoverflow.com/questions/30869297/difference-between-memfree-and-memavailable) and [post 2](https://superuser.com/questions/980820/what-is-the-difference-between-memfree-and-memavailable-in-proc-meminfo). To maintain the flow, continue reading.   

Note:- It is good to learn about [types of RAM](https://www.techtarget.com/searchstorage/definition/DIMM), such as earlier SIMM, and DIMM, buffered memory, Load-Reduced or LR-DIMM (with iMB to isolate data and address), Small Outline or SO-DIMM (compact form factor for recent laptops/tablets), etc. A post on [which one to use](https://www.dasher.com/server-memory-rdimm-vs-lrdimm-and-when-to-use-them/) and [difference](https://www.faceofit.com/rdimm-vs-irdimm-vs-udimms/) can be helpful. To maintain the flow, continue reading.    

----

## GB or GiB    

GB and GiB are data storage units in terms of bytes.    

GB  - Gigabyte: is based on decimal system, 1 GB = 10^9 bytes (1,000,000,000 bytes or 1 billion bytes, 1 followed by 9 zeros)    
GiB - Gibibyte: is based on binary system, 1 GiB = 2^30 bytes (1,073,741,824 bytes).     

1 GiB is slightly larger than 1 GB (7.3%)     

1 TB  = 10^12 bytes or 1,000,000,000,000 bytes or 1 trillion bytes, 1 followed by 12 zeros     
1 TiB = 2^40 bytes  or 1,099,511,627,776 bytes     

1 TiB is larger than 1 TB (9.9%)     

Note:-    
1. International Electrotechnical Commission (IEC - https://iec.ch) standardized the use of prefixes like "kibi-", "mebi-", "gibi-", "tebi", etc., to represent binary multiples, reserving "kilo-", "mega-", "giga-", "tera-", etc., for decimal multiples.     
2. Certain OS or software utilities may display storage values slightly different or less as compared to vendor published values because of GB/GiB unit used. For TeraBytes, PetaBytes (and higher) the difference becomes significant because of growth of power of 2 versus power of 10.     

---- 

## List hardware 
How can I list hardware details?  
```

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

To know about peripheral interconnects/ports:    
```
lspci -vvv 
```

----

## Environment Variables    

How to display and change environment variables? Using printenv, we can display/print environment variables that may be helpful to set or display PATH, alias, user, and session details for scripting or debugging.    

```
$ printenv
SHELL=/bin/bash
SSH_AGENT_LAUNCHER=gnome-keyring
COLORTERM=truecolor
XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg
XDG_MENU_PREFIX=gnome-
LANGUAGE=en_IN:en
PWD=/wah/rps
LOGNAME=rps
XDG_SESSION_TYPE=x11
SYSTEMD_EXEC_PID=2798
HOME=/wah/rps
USERNAME=rps
LANG=en_IN
USER=rps                   <= check echo $USER
DISPLAY=:1
SHLVL=1
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/wah/scripts
GDMSESSION=ubuntu
_=/usr/bin/printenv        <= check echo $_

```

----

## PATH   

What is path? No one figured out this quite well. Jokes apart, in Linux, everything is a file (LIFE is FILE and FILE is LIFE), and we may need to refer files, to where files reside.    

* Path helps to navigate around the file system and files in Linux, where almost everything is a file.
* In the hierarchical directory structure, we can refer path of a regular file (-) or directory (d) or symbolic link (l) using an absolute or a relative path.
* An **absolute path** corresponds to a path beginning from / or root. e.g. /home/rps/example.desktop
* A **relative path** corresponds to a path relative to the current directory (pwd) or any other directory. e.g. Downloads/package.deb or ../../home/rps/Downloads/package.deb or ~/data/file.txt     

How do we refer to path in commands?    

List a special environment variable called PATH    
```
echo $PATH
```

Update PATH variable to include Videos directory   
```
$ echo $PATH
/home/rps/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
$ export PATH=$PATH:/home/rps/Videos
$ echo $PATH
/home/rps/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/rps/Videos
```

If you want a newly added directory to be searched first in the path, add the new directory first and then append the existing contents of the path variable. Use "which" command to locate the first binary or built-in util being referenced.    

For Java, classpath to locate classes and for libraries LD_LIBRRAY_PATH are other famous path variables used by developers.     

---- 

## Command completion
Learn to use the tab key for command completion or completing file/directory names. This can save time in typing.  

Hint: type ds and press the tab to see command completion (e.g., dstat) if it exists or to see matching options.  
Hint: type ls -lrt /home/rps/Do  and then press tab twice, you will get matching suggestions.  

Tip: in case command completion is not working on a system, check you have installed bash-completion and bash-completion-extras  
A related [long story](https://unix.stackexchange.com/questions/264102/bash-completion-is-very-incomplete-on-centos-7).  

Reference file: /usr/share/bash-completion/bash_completion    

**compgen** is a bash builtin to complete aliases, builtins, commands, bash keywords, and functions.     
```
compgen -a                      <== list all aliases 
compgen -b                      <== list all builtins 
compgen -c                      <== list all commands 
compgen -c ls                   <== list all coomands starting with ls 
compgen -k                      <== list all keywords 
compgen -A function             <== lits all functions 
compgen -abckA function > compgen_help.txt        <== list most of what compgen can complete
compgen -abckA function | grep -i --color ^ls     <== color, list most of compgen begining with ls
compgen -abckA function | grep -i --color ls$     <== color, list most of compgen ending with ls
```
Q. How does compgen get this powerful list of itens?     
Hint: complete 

----

## Command history    

To list existing history:    
```
history
```
To search history recursively:     
Use ctrl+r and type few characters to search history, and then use tab to get that command:      
```
(reverse-i-search)`ssh': ssh -i rps.pem ubuntu@10.10.120.120      <== ctrl+r and then typed ssh   
```
To see a few previous commands:      
Use arrow keys => Up for previous command and down to next in the history list.     

To repeat just immediate previous command
```
!!
```
To clear history from current terminal session or shell:    
```
history -c
```

Q. How do you hide a command from bash shell history? Suppose you did not want to reveal something :)    
A. try prefixing command with one or more spaces
```
  compgen -abckA function > compgen_help.txt       <== command with a space prefix won't appear in history. Check using up arrow key    
```

----

## Know File System 

Linux File System - ext4, btrfs, xfs, ZFS, etc. define how to store, retrieve, and manage files on the system.     

Use **fdisk -l** (output may contain loop devices, ignore them for now):  
```
$ sudo fdisk -l
...
Disk /dev/nvme0n1: 476.94 GiB, 512110190592 bytes, 1000215216 sectors
Disk model: BC711 NVMe SK hynix 512GB               
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 90AC9BEA-BE65-4C42-8C6D-4CE4C6349709

Device             Start        End   Sectors   Size Type
/dev/nvme0n1p1      2048     514047    512000   250M EFI System
/dev/nvme0n1p2   1562624    1824767    262144   128M Microsoft reserved
/dev/nvme0n1p3   1824768  483047423 481222656 229.5G Microsoft basic data
/dev/nvme0n1p4 995047424  997257215   2209792   1.1G Windows recovery environmen
/dev/nvme0n1p5 997261312 1000187903   2926592   1.4G Windows recovery environmen
/dev/nvme0n1p6 483047424  547047423  64000000  30.5G Linux swap
/dev/nvme0n1p7 547047424  995047423 448000000 213.6G Linux filesystem

Partition table entries are not in disk order.
...

```

**/etc/fstab** can show Linux partitions  
```
$  cat /etc/fstab 
# /etc/fstab: static file system information.
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/nvme0n1p7 during installation
UUID=d56a27d6-0a3c-40a1-b85f-b4fa53bff123 /               ext4    errors=remount-ro 0       1
# /boot/efi was on /dev/nvme0n1p1 during installation
UUID=4CF2-479A  /boot/efi       vfat    umask=0077      0       1
# swap was on /dev/nvme0n1p6 during installation
UUID=cceb039a-dbe7-4441-800c-a0548fe2fb45 none            swap    sw              0       0
```

**mount** or **df** can show file systems mounted. 
```
$ df -Th
Filesystem     Type      Size  Used Avail Use% Mounted on
tmpfs          tmpfs     1.6G  2.7M  1.6G   1% /run
/dev/nvme0n1p7 ext4      210G  116G   84G  58% /
tmpfs          tmpfs     7.6G  560M  7.0G   8% /dev/shm
tmpfs          tmpfs     5.0M  8.0K  5.0M   1% /run/lock
efivarfs       efivarfs  374K  259K  111K  71% /sys/firmware/efi/efivars
/dev/nvme0n1p1 vfat      246M  130M  117M  53% /boot/efi
tmpfs          tmpfs     1.6G  160K  1.6G   1% /run/user/1000
```

**lsblk** and exclude loop devices
```
$ lsblk -f | grep -v loop
NAME        FSTYPE   FSVER LABEL       UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
nvme0n1                                                                                    
├─nvme0n1p1 vfat     FAT32 ESP         4CF2-479A                             216.8M    53% /boot/efi
├─nvme0n1p2                                                                                
├─nvme0n1p3 ntfs           OS          B496F47996F12345                                    
├─nvme0n1p4 ntfs                       EA40D7DD40D78901                                    
├─nvme0n1p5 ntfs           DELLSUPPORT 1EFE4A7DFE412345                                    
├─nvme0n1p6 swap     1                 cceb039a-dbe7-4441-800c-a0548fe12345                [SWAP]
└─nvme0n1p7 ext4     1.0               d56a27d6-0a3c-40a1-b85f-b4fa53b67890   183.4G    55% /
```

References:      
https://www.fosslinux.com/126128/choosing-the-right-linux-file-system-your-ultimate-guide.htm     
https://www.geeksforgeeks.org/linux-file-system/    
https://www.baeldung.com/linux/find-system-type     

[File System Hierarchy Standard](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard)     

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

Linux users can belong to one or more groups. Group-level rights can be defined for users inside it. User and group are two different things, they can have a same name. A user can belong to multiple groups for defined access rights.   

Notice /etc/group file; the first column is a group name.   

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

Memorise the first command we learnt, ls -lrt, now type this in any directory for files and see the output. For a directory, use: ls -ld    

The first column shows file permission mode, and columns 3 and 4 show owner and group names, respectively.   

File permission mode can be viewed as:   
=> first char is file type, - for a regular file, d for a directory, l for a symbolic link, c for a character device (/dev/null), b for a block device (/dev/loop1)   
=> Next, view 3 characters in pairs - the first three chars for the user or owner who owns a file, the next 3 chars for the group, and the last three for other than group users.   
=> These three chars pairs contain access permissions in order: r = read, w = write or x = execute   
=> There is a numeric weight associated with r, w, and x. r => 4, w => 2, and x = 1 and we can sum if any of r/w/x is present (see examples below)   
=> If a user is missing a certain access permission, that respective character is displayed as - or numerically adds up to 0   
=> These numeric values essentially come from the octal representation of r, w, x permissions.    
```
rwx : 111 or 7    
rw- : 110 or 6    
r-x : 101 or 5    
r-- : 100 or 4    
-wx : 011 or 3    
-w- : 010 or 2    
--x : 001 or 1    
--- : 000 or 0    
```

Using r - regular file can be opened in read-only mode, and directory content can be listed (cd to the directory is not allowed by r)   
Using w - regular file can be edited, deleted, renamed, modified and saved, directory can be created inside a directory, deleted, renamed, access can be modifed as well.   
Using x - regular file can be executed if it is a script, the directory can be accessed, cd to the directory is allowed by x   

Some examples of file permissions are listed below.   

```
-rwx------ : regular file, (700), only owner can read, write, execute this file.   
-rw-r--r-- : regular file, (544), anyone can read, only owner can modify or delete.   
drwxr-xr-x : directory, (755), owner can read, write and access directory, group and other users can read contents and access it, cd is allowed   
-rwxr-xr-x : regular file, (755), only owner can modify or delete, however, anyone can read or execute it   
```

Using chmod you can modify file permissions. You can grant (+) or revoke (-) for one or more users.   
Grant r or w or x permission using +r or +w or +x    
Revoke r or w or x permission using -r or -w or -x    
Before + or -, specify groups without space.    

chmod +x : grant execute permission to all    
chmod g+w : grant write permission to same group users   
chmod go+r : grant read permission to group and other users, NOTE: Do not use numeric perms as we do not know other perms    
chmod 777 : grant rwx to owner, group, and non-group users, NOTE: Be very careful why such permission mode is being set    
chmod 744 : grant rwx to user and read to group and others    

Recall /bin/sh is a shell.    

```
$ ls -lrt /bin/sh
lrwxrwxrwx 1 root root 4 Mar 23 19:19 /bin/sh -> dash
```

Using buffer overflow, if a remote user can get a shell /bin/sh executing some [shellcode](https://cocomelonc.github.io/tutorial/2021/10/09/linux-shellcoding-1.html), then what he can do - try to visualize using permissions of /bin/sh - specifically see the owner and all permissions.   

**Changing default permissions using umask**     
* umask is used to set default permissions for new files or directories to be created.
* umask digits specify what permissions to be revoked from new files or directories.
* Maximum permissions for a file are 666 and for a directory 777.
* Now using a umask of 022, default permissions for a file are 644 (-rw-r--r--) and for a directory 755 (drwxr-xr-x).
* Similarly, umask 002 will grant files 664 (-rw-rw-r--) and to directories 775 (drwxrwxr-x) permissions.
* type umask on bash prompt to get current umask value, ignore leading zeros except rightmost 3 digits
* with umask in four digits, leading digit 4, 2, 1 have special meaning. 4xxx SUID bit set, 2xxx SGID bit set, 1xxx sticky bit set (they are different)
* umask can be set in /etc/profile for all users or in ~/.bashrc for a user by adding one line
```
umask 022
```

----

Let us discuss two interesting questions using ps, ls, and permissions.    

Q1. If a program is owned by a root or another user, how a non-root user can run it?       Hint: setUserId() bit.     

A. Follow the commands below and understand the output.   
```
$ ps -eo euser,ruser,suser,fuser,f,comm,label                   <== check a few effective user and real user entries in the listing   
EUSER    RUSER    SUSER    FUSER    F COMMAND         LABEL
root     root     root     root     4 systemd         unconfined
........ 
root     rps      root     root     4 fusermount3     unconfined
.......

$ which fusermount3                                            <== get path of fusermount3   
/usr/bin/fusermount3

$ ls -lrt /usr/bin/fusermount3                                 <== ask ls for permissions on fusermount3  
-rwsr-xr-x 1 root root 35200 Dec 23  2020 /usr/bin/fusermount3    <== notice  s  after -rw, this is SUID bit.   

```
If SUID bit is set for a program/executable while running the program, effective user id gets updated to the user id of owner of the program while it was run by a real user.   

Now, check the SUID bit for passwd :)    

```
$ ls -lrt /usr/bin/passwd
-rwsr-xr-x 1 root root 59976 Nov 24 17:35 /usr/bin/passwd
```
That's why a non-root user can change password on linux, even if passwd is owned by root.    

Note: There are other such programs as well, check using find / -perm /4000    


Q2. Can a user see (read) or delete files created by other users under /tmp directory?         Hint: sticky bit. 

A. Try to understand the output of the commands below:
```
$ ls -ld /tmp
drwxrwxrwt 23 root root 4096 Nov 24 12:19 /tmp                  <== notice  t  instead of x or - this t is for sticky bit 

$ ls -ld /run/lock
drwxrwxrwt 4 root root 100 May 11 18:02 /run/lock
```
If the sticky bit is set for a directory, all files inside this directory can be deleted or moved by the owner of the files or the guru (root).    

See if there are other such directories like tmp using find / -perm /1000 

A Redhat article on [Linux permissions: SUID, SGID and sticky bits](https://www.redhat.com/sysadmin/suid-sgid-sticky-bit).    

----

## Remote login using ssh    

To login to a server or virtual machine remotely from your own Linux system, you can use ssh:    
```
ssh remote_username@remote_server_ip_or_name
```
SSH using pem file:    
```
ssh -i filename.pem remote_username@remote_server_ip_or_name   
```
SSH ignores a private key file (.pem file) if it is accessible by others.   
You should change the permissions of the pem file to remove access for other users (600 or 400) to remove the error: Permissions 0664 for 'filename.pem' are too open.   
```
chmod 400 filename.pem  
```

----

## Transfer files using Secure Copy scp   

Using Secure Copy or SCP, we can transfer files to and from local to remote systems. Underneath, scp uses SSH for auth and encryption.    

```
scp SOURCE DESTINATION    

scp  path-of-local-file-or-dir  user@remote-system:/path-to-remote-file-or-dir    

scp  user@remote-system:/path-of-remote-file-dir  path-of-local-file-or-dir    
```
----

## su and sudo    

su = substitute user, su <user> starts another shell with permissions of <user> specified.      
sudo = sudo verifies the password of the user who executed sudo for any privileged command.     

Q. Do I really need to have a root password set on Linux? And then, how do I manage things without sharing it with others?     
A. On Ubuntu (and Debian-based systems), you can live without a root password and manage most things using sudo. Instead of sharing the root password with every user (in the lab or office) for admin tasks such as installations and running privileged utilities, sudo is a better alternative. This may not apply to Red-Hat-like systems.      


Q. Is my root password set?    
A. `sudo -i` can be used to acquire root environment (privileged administrator). On Ubuntu and other Debian-based systems, the root password may not be set or may be locked.    
To check if the root password is set:    
```
rps@eg:~$ sudo -i                 <== get me root environment, if user rps is allowed/configured to do so      
root@eg:~# passwd -S              <== know password status: **P** = usable Password is set, **NP** = No Password is set, **L** = password is Locked (cannot login).     
root NP 2022-12-08 0 99999 7 -1   <== No Password is set for root; better keep it this way on a standalone/personal system     
root@eg:~# exit
logout

```
Try `passwd -l root` to lock the password or `passwd -d root` to delete the password. Check entries in /etc/passwd and /etc/shadow around this.    


Q. Should I use "su" or "su -" as administrator?     
A. Always use "su -" for a clean substitution to indented user identity.    
"su -" substitutes the root/target user and creates a clean shell without environment variables set by the previous user. It's a complete user substitution.    
"su" existing shell environment is more or less retained and substitutes the user. It's like mimicking a new user environment.    
After su or "su -", you can check `pwd` or `ls -lrt ~/`  and exit after any such operations.    

**Tip**:     
On Ubuntu, you can live without a root password and manage most of the things using sudo. Instead of sharing the root password with every user (in the lab or office) for admin tasks such as installations and running privileged utilities, sudo is a better alternative.      
** Always ask man => man passwd, man shadow, man sudo, man sudoers, man su, man crypt before making changes**    
Double-check as a root for any recursive operation.     
This behavior can vary across Linux distributions and versions over the years.    

Related posts:    
[su or sudo](https://askubuntu.com/questions/70534/what-are-the-differences-between-su-sudo-s-sudo-i-sudo-su)    
[su or su -](https://unix.stackexchange.com/questions/7013/why-do-we-use-su-and-not-just-su)    

----

## Password caching in sudo   

Often, we type the password for commands that require sudo. And then, the same or similar command does not require the password. This suggests that there is some caching of the sudo password or a time limit before the password for sudo is asked again.    

There is one timeout period per user. The start timestamp of the timeout is stored in /var/lib/sudo/ts or /var/run/sudo/ts directory.    
In Ubuntu, it may be 15 minutes. [Referenced discussion](https://unix.stackexchange.com/questions/457995/when-does-it-start-to-count-the-time-limit-set-for-password-caching-in-sudo) and [here is how you can change it](https://www.maketecheasier.com/change-the-sudo-password-timeout-in-ubuntu/).    

One way to check if a sudo password is required is to use sudo -nv, and no output suggests you do not need to enter the password for sudo:   
```
$ sudo -nv
sudo: a password is required
```

----

PART-2    

## Processes   

Use ps command with flags -aef or -aux and grep for user or other strings.    

ps -aux shows USER running the process, PID of the process, %CPU used, %MEM used, status of the process, timestamp of starting the process, and command used to start the process.    

```
ps
ps -aef 
ps -aux
ps -aux | grep $USER 
```

----

## Process Memory Layout 
This one is my favorite topic in OS lab. It helps to visualize virtual memory, process layout, proc interface, and shared libs/objects.     

Can I see the memory layout and the stack of a process? See [presentation]() for more details.   
To see all files related to a process with PID = $$  
``` 
ls -lrt /proc/$$
```
Now, check process memory layout (TODO: add link from OS course file having exercises on proc):   
```
cat /proc/$$/maps 
```

And stack associated with process $$:  
```
cat /proc/$$/stack
```
Using the output of the above commands, convince yourself that you can visualise stack, heap, text segment of a process using virtual addresses and the output. Also, see /lib/x84_64-linux-gnu/lib\*  files and other shared libraries.  
In the above example, replace $$ with a process id you are interested in.  

Ok, next you should try out:   
```
cat /proc/self/maps
```
Here is a link to [understand the output](https://www.baeldung.com/linux/proc-id-maps) almost line by line.   


What shared objects/libraries are used by a program? 

```
$ ldd <program>
$ ldd /bin/bash
$ ldd /bin/ls
$ ldd /usr/bin/python3.8 
```

Do you know where and how to know more about /proc?  

One of the best ways to understand virtual memory and process memory layout: [Cheese on /proc](https://www.kernel.org/doc/Documentation/filesystems/proc.txt)   

[procmap](https://github.com/kaiwan/procmap)     

---- 

## Kernel Parameters    

Like printenv for the current session, we can set or display kernel parameters for the currently booted kernel. You would like to know what values you set before you set them :)    

```
$ cat /proc/cmdline 
BOOT_IMAGE=/boot/vmlinuz-6.2.0-39-generic root=UUID=d56a27d6-0a3c-40a1-b85f-b4fa53bff998 ro quiet splash vt.handoff=7
```

```
$ sysctl -a
abi.vsyscall32 = 1
debug.exception-trace = 1
debug.kprobes-optimization = 1
...
dev.scsi.logging_level = 0
...

...
user.max_net_namespaces = 61251
user.max_pid_namespaces = 61251
...
vm.overcommit_memory = 0
vm.overcommit_ratio = 50
...
vm.swappiness = 60
vm.unprivileged_userfaultfd = 0
vm.user_reserve_kbytes = 131072
vm.vfs_cache_pressure = 100
vm.watermark_boost_factor = 15000
vm.watermark_scale_factor = 10
vm.zone_reclaim_mode = 0

```
----

## Overcommit memory    

Know more about vm.overcommit_memory and vm.overcommit_ratio at [serverfault](https://serverfault.com/questions/606185/how-does-vm-overcommit-memory-work)     

----

## Linux Capabilities   

Unprivileged or non-root processes can be enabled or disabled for certain tasks or to access some resources. They are pretty much permissions for a process.    

You can check capabilities for a process using    
```
$ getpcaps PID   
```

When asked the man (man capabilities), got this reply :)     
```
  For  the purpose of performing permission checks, traditional UNIX implementations distinguish two categories of processes:   
  privileged processes (whose effective user ID is 0, referred to as superuser or root), and unprivileged processes (whose
  effective UID is nonzero).  Privileged processes bypass all kernel permission checks,  while  unprivileged processes are
  subject to full permission checking based on the process's credentials (usually: effective UID, effective GID, and
  supplementary group list).   
   
  Starting  with  Linux  2.2, Linux divides the privileges traditionally associated with superusers into distinct units,
  known as capabilities, which can be independently enabled and disabled.  Capabilities are a per-thread attribute.   
```

----

## Scheduling Jobs 

Cron jobs come to the rescue when scheduling jobs, taking backups, or running scripts at a defined frequency.     

Relevant file: /etc/crontab is a system-wide configuration file to schedule hourly, day of the month, monthly, and weekly jobs to be run by a user and scripts to invoke.    

To make an entry, you should know the columns in the crontab file. The first five columns define job frequency, followed by user-name and command-to-be-executed    

```
$ cat /etc/crontab 
# /etc/crontab: system-wide crontab

SHELL=/bin/sh
# You can also override PATH, but by default, newer versions inherit it from the environment
#PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name command to be executed
17 *	* * *	root	cd / && run-parts --report /etc/cron.hourly
25 6	* * *	root	test -x /usr/sbin/anacron || { cd / && run-parts --report /etc/cron.daily; }
47 6	* * 7	root	test -x /usr/sbin/anacron || { cd / && run-parts --report /etc/cron.weekly; }
52 6	1 * *	root	test -x /usr/sbin/anacron || { cd / && run-parts --report /etc/cron.monthly; }
#
0,10,20,30,40,50 *    * * *	rps	cd /home/rps/lsav && touch a.out            <== every 0,10,20,30,40,50th minute cd /home/rps/lsav and record timestamp or touch a.out   
00 7,13,19    * * *	root	cd /home/eg/backup && ./run_backup.sh             <== every day 7:00 am, 1:00 pm, 7:00 pm, go to /home/eg/backup directory and execute script run_backup.sh          
```

Note: /etc/crontab is a global system-wide cron job scheduler. It contains a user option in the entry. Remember syntax as:    
Min Hr DoM Mon DoW user command     
00 00 01 01 * root { cd / && echo "Happy New Year!" > greetings.txt }     

Note: There is another option to schedule jobs using crontab -e, and that option is for per user, by default for logged-in users. There is no user option present when editing using crontab -e. It can be run for a user rps using -u flag =>  crontab -e -u rps     

Also refer: [Cron periodic config](https://docs.freebsd.org/en/books/handbook/config/#cron-periodic)     

----

## nohup   

When running a command on the terminal, upon closing the terminal or due to disconnecting the remote session (ssh), the command stops.   
Suppose the command was executed interactively, now the exit status may be unknown or incomplete.    

We can use nohup (no hang up) to tell the OS not to trap the SIGHUP signal to stop such interactive command execution.    

Run a bash script to backup resources:   
```
nohup bash backup.sh    
```
Run system update that can longer and may remain unattended   
```
nohup sudo apt upgrade   
```

----

## Shell Scripting    

Shell Scripting offers a nice and robust way to automate system administration and daily tasks on Linux for both sysadmins and normal Linux users.     

[Bash Scripting](https://linuxsimply.com/cheat-sheets/bash-scripting/)     
Check [Bash options](https://devhints.io/bash)    
Try [Bash one-liners](https://onceupon.github.io/Bash-Oneliner/) and [more](https://www.bashoneliners.com/oneliners/newest/) to see the expressiveness of bash scripting    
[Bash cheatsheet](https://github.com/LeCoupa/awesome-cheatsheets/blob/master/languages/bash.sh)     

[Practice simple commands from RHCSA](https://github.com/soficx/rhcsa)     

Note: Some options may vary from shell to shell and across versions installed and distributions. Do not worry; explore different options.     

----

## xdg-open 

You may have come across xdg-open message when starting or joining a conference call/meeting from a browser link to a specific meeting application. It can be visible when you click a link on website menu and that menu does not have a actual target link.    

From man-page of xdg-open:   
xdg-open is a linux command to open a file or URL in the user's preferred application. xdg-open supports file, ftp, http and https URLs.   

e.g. open a web page    
```
$ xdg-open 'http://www.freedesktop.org/'
$ Gtk-Message: 11:56:17.079: Not loading module "atk-bridge": The functionality is provided by GTK natively. Please try to not load it.
Opening in existing browser session.
```
TODO: add image of browser pop-up showing xdg-open message   

----

## Systemd versus init based systems     

[Systemd-based versus init-based Linux systems](https://itsfoss.com/systemd-init/)     

[Systemd-free Linux Distributions](https://itsfoss.com/systemd-free-distros/)     

Systemd brought parallelization of processes in the booting process and configuration files-driven service management.    

```
rps@eg:~$ systemctl get-default                 <== default target to boot into 
graphical.target

rps@eg:~$ systemctl get-default --version       <== also tells what the target has been booted into with 
systemd 255 (255.4-1ubuntu8.5)
+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified
```

Check systemctl start <cmd>.target and systemctl isolate <cmd>.target under man systemctl :)     

----

## Windowing System for GUI   

Xorg   
Wayland (default on Ubuntu 22.04 LTS)   

Zoom app has an interesting bug for screen sharing in Linux systems (desktop/laptop image) using the default Wayland windowing system. Only Whiteboard sharing is enabled and there is no option to share desktop/laptop screens. It appears Zoom has decided not to fix this bug.    

To enable screen sharing on Linux Desktop/Laptop with Zoom, disable Wayland in Graphical Display Manager (GDM) config and switch to Xorg/X11 windowing system.   

```
$ sudo vi /etc/gdm3/custom.conf    <== edit gdm custom.conf using editor   
# Uncomment the line below to force the login screen to use Xorg   
#WaylandEnable=false               <== Uncomment this and restart the system   
```

Now, after this workaround, Zoom will show Desktop sharing alongside Whiteboard sharing.    

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
Interesting: Try pressing any arrow key while top is on.   


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

## crt and key file   
For SSL/TLS certificate setup on a HTTP server, it requires a certificate and a private file.   
[Public key certificate and private key file](https://www.baeldung.com/linux/crt-key-files)   

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

## Installed packages
How do I find out installed software packages? 
```
sudo dpkg --get-selections
```
This is equivalent to rpm -qa in case of RHEL/Fedora/CentOS. 

----

## Remove old Linux kernel images 
How do we remove old Linux kernel images and headers?  

At times, one can find some old Linux images / Linux headers / Linux modules that are occupying storage on the system. If you want to remove these old Linux kernel images and headers (5.0* / 5.3*), while you have upgraded to higher versions (5.4*):  

- first, query using uname -a and dpkg --list | egrep "linux-image|linux-headers|linux-modules|linux-image-generic" | awk '{print $2 " " $3}'  
- next, use apt purge linux-image-5.0* or apt purge linux-image-5.4.2*  
- Take precaution, you should not remove the current and the immediate previous images/headers.  

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
...
linux-image-5.4.0-64-generic 5.4.0-64.72
linux-image-5.4.0-65-generic 5.4.0-65.73
linux-image-generic 5.4.0.65.68
linux-modules-5.0.0-23-generic 5.0.0-23.24~18.04.1
linux-modules-5.0.0-32-generic 5.0.0-32.34~18.04.2
...
linux-modules-5.4.0-64-generic 5.4.0-64.72
linux-modules-5.4.0-65-generic 5.4.0-65.73
linux-modules-extra-5.0.0-23-generic 5.0.0-23.24~18.04.1
linux-modules-extra-5.0.0-32-generic 5.0.0-32.34~18.04.2
...
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
$ sudo journalctl --vacuum-time=14d   <= older than 14 days 
```

Clean up the audio/video/movie files and duplicate photos on the system.  

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
AIX: IBM Unix    
HP-UX: HP Unix     
[BSD](https://en.wikipedia.org/wiki/Berkeley_Software_Distribution)    
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

## Advantage Linux 

I have been using Linux as primary desktop/laptop OS since 2003, well before I owned my first desktop. I can always count on community support, forums, and there are so many instances, I could get help on online forums, web pages. At times, I wondered what gets them going? who pays their bills? what I could do this going?   

----

## The One with Linus

[The talk with not so visionary, not so people-person, a simple happy engineer](https://www.youtube.com/watch?v=o8NPllzkFhE) Linus Torvalds who changed the world at least twice with Linux and Git. He started both the projects as a hobby and to solve the problems he was facing. On mailing lists, he speaks his mind, if he does not agree with something - he logs it, registers it.    

---- 

## Linux software

[Linux Software](https://github.com/luong-komorebi/Awesome-Linux-Software)    

[Writing mathematical equations in Libre Office Writer](https://www.ubuntubuzz.com/2016/09/libreoffice-writer-equation-editor-writing-mathematical-formulas.html)     

---- 

PART-4     

## Linux Security    

* Unlike Windows, Linux was designed from the ground up as a multiuser operating system. Therefore, user-level security provisions tend to be a bit better on a Linux system.   
* Linux offers a better separation between administrative users and unprivileged users. This makes it a bit harder for intruders, and it also makes it a bit harder for a user to accidentally infect a Linux machine with something nasty.
* Linux is much more resistant to viruses and malware infections than Windows is. Certain Linux distributions come with built-in mechanisms, such as SELinux in Red Hat and its free-of-charge clones, and AppArmor in Ubuntu and SUSE, that help prevent intruders from taking control of a system.
* Linux is free and open source software. This allows anyone who has the skill to audit Linux code to hunt for bugs or backdoors.

Yet even with those advantages, Linux is just like everything else that has been created by mankind. That is, it is not perfect.   

[LinEnum - Linux Enumeration and Privilege Escalation/Exploration Script](https://github.com/rebootuser/LinEnum)    

[Linux privilege escalation and exploration](https://sushant747.gitbooks.io/total-oscp-guide/content/privilege_escalation_-_linux.html)    

----

## Linux Kernel   

[Linux Kernel Home](https://www.kernel.org/)    
[Core API Documentation](https://www.kernel.org/doc/html/latest/core-api/index.html)    
Examples for logging [printk](https://www.kernel.org/doc/html/latest/core-api/printk-basics.html)    

## Virtualization    


[Virtualization and QEMU](https://docs.saferwall.com/blog/virtualization-internals-part-4-qemu/)    

