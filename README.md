# eglinux 
<!--[muscot](https://commons.wikimedia.org/wiki/File:Tux.png)-->
eglinux => pronounced as "easy Linux" => compiles easy and helpful Linux commands and pointers for beginners and intermediate users. Efforts have been made to keep the commands and utilities as generic as possible.    

Disclaimer: The output shown below for commands or utilities is compiled for education and illustration purposes only. You may not find all the exact details in your lab, office, apartment, or campus.    

* [eglinux](#eglinux)
  * Part-1
      * [`ls -lrt`](#ls--lrt)
      * [`lsb_release`](#lsb_release)
      * [Getting help on-system](#getting-help-on-system)
      * [Know processors](#know-processors)
      * [Know memory](#know-memory)
      * [GB or GiB](#gb-or-gib)
      * [List hardware using `lshw`](#list-hardware)
      * [Environment variables](#environment-variables)
      * [PATH](#path)
      * [Pathnames](#pathnames)
      * [Navigating directories](#navigating-directories) 
      * [Locating binaries](#locating-binaries)
      * [Command completion](#command-completion)
      * [Command history](#command-history)
      * [Know File System](#know-file-system)
      * [Mount points](#mount-points)
      * [Disk Usage](#disk-usage)
      * [The One with File Permissions](#the-one-with-file-permissions) 
      * [`su` and `sudo`](#su-and-sudo)
      * [Password caching in `sudo`](#password-caching-in-sudo)
      * [Remote login using `ssh`](#remote-login-using-ssh)
      * [Transfer files using Secure Copy `scp`](#transfer-files-using-secure-copy-scp)
      * [Simple web server](#simple-web-server)
  * Part-2
      * [Processes](#processes)
      * [Process Memory Layout using `proc`](#process-memory-layout)
      * [Process termination](#process-termination)
      * [Kernel parameters](#kernel-parameters)
      * [Linux capabilities](#linux-capabilities)
      * [Scheduling jobs](#scheduling-jobs)
      * [`nohup`](#nohup)
      * [vi editor](#vi-editor)
      * [Input Output redirection](#input-output-redirection)
      * [View file content](#view-file-content) 
      * [`xargs`](#xargs)
      * [File compression](#file-compression) 
      * [Shell Scripting](#shell-scripting)
      * [regex](#regex)
      * [`xdg-open`](#xdg-open)
      * [Debugging](#debugging)
      * [File conversion](#file-conversion) 
  * Part-3
      * [Windowing System for GUI](#windowing-system-for-gui) 
      * [Systemd versus init based Systems](#systemd-versus-init-based-systems)
      * [`hostnamectl`](#hostnamectl)
      * [`networkctl`](#networkctl)
      * [`perf`](#perf)
      * [Installed packages](#installed-packages)
      * [Remove old Linux kernel images](#remove-old-linux-kernel-images)
      * [Free space on Ubuntu system](#free-space-on-ubuntu-system)
      * [User account management](#user-account-management) 
      * [The One with mysql admin password](#the-one-with-mysql-admin-password)
      * [Linux software](#linux-software)
      * [Linux toolchain](#linux-toolchain) 
  * Part-4
      * [Monitoring Performance](#monitoring-performance)
      * [Audit System Logs](#audit-system-logs) 
      * [Linux for Networking](#linux-for-networking)
      * [Linux for Security](#linux-for-security)
      * [crt and key file](#crt-and-key-file) 
      * [Linux Kernel](#linux-kernel)
      * [Virtualization](#virtualization)
  * Part-5
      * [The One with UNIX/Linux History](#the-one-with-unix/linux-history)
      * [Advantage Linux](#advantage-linux)
      * [The One with Linus](#the-one-with-linus)
      * [LWN](#lwn)


PART-1

## ls -lrt

Every time you open a terminal or shell, the first command you should check out is to list all files and directories (ls) in a long (l) and reverse (r) order of time (t) updated. Do compare this output with various other outputs from the `ls` options. Also, this command helps to see permissions and who touched what files recently.    
```
ls -lrt
```

To list hidden files: use `ls -alrt`   

Q. Do you notice colors in the output of ls? What are all these colors?   
A. For now, try this out using dircolors.   
```
$ dircolors --print-ls-colors
```

----

## lsb_release

What are the OS major and minor release numbers? And any code name associated with the release?   
```
$ lsb_release -a  
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.1 LTS
Release:	20.04
Codename:	focal
```
Note:- LSB is Linux Standard Base. If you are more interested, after this article, you can refer to [what is LSB](https://wiki.linuxfoundation.org/lsb/start) and [LSB Specs](https://refspecs.linuxfoundation.org/lsb.shtml). To maintain the flow, continue reading.  

TIMTOWTDI (There Is More Than One Way To Do It): You can use /etc/os-release 
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

Q. What is my system name, kernel, OS, kernel version, and date last updated?   
A. Ask `uname` (Unix Name) for operating system name, hostname, kernel version, processor type (x86_64), hardware platform type (x86_64), etc.     
```
$ uname -a  
Linux Latitude-3490 5.4.0-58-generic #64-Ubuntu SMP Wed Dec 9 08:16:25 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
```

[Ubuntu release cycle](https://ubuntu.com/about/release-cycle) - Each April release in even years is LTS (e.g., 18.04, 20.04, 24.04), and supported for 5 to 10 years or more. Production-grade applications should be hosted on LTS releases.     

A Computer System contains:      
- Compute
- Memory
- Network
- (persistent) Storage
- These days, all four components or sub-systems are virtualized or can be virtualized.
Unless you are working with a physical laptop/desktop/server (which is mostly right in front of you), it is very likely that you are using virtual compute, memory, network interfaces, and persistent storage that are virtualized or allocated from a larger pool of resources.    

----

## Getting help on-system 

What do I do if I do not know commands or their options and arguments?   
- Remember: Command has got a name, options, and/or arguments.   
- There are plain-text on-screen manuals about Linux built-ins and commands.   
- There is a **man** I know who can help, and he tells us from the most reliable sources.   
- These on-screen manuals or man pages are the closest to what one can get as cursor-sensitive help on the system!   
- (While I am not around,) Always ask **man**, using man followed by command, built-in, or keyword:  
```
man man
man ls 
man lsb_release 
man uname 
man touch 
man timedatectl 
man execve 
man service 
man find 
man grep 
man info 
man 7 glob     <== using man page section, there are 8 of them   
```

Okay, try one of the coolest commands on bash script built-ins:   
```
man [ 
```
[Advanced]: ls -lrt /usr/bin/[ output will confirm that it is a binary executable file.    
The source is located in the coreutils package, specifically in src/lbracket.c and src/test.c    

About man page sections, the text below is verbatim copied from the man page of man command:    
```
DESCRIPTION
       man  is  the system's manual pager.  Each page argument given to man is
       normally the name of a program, utility or function.  The  manual  page
       associated with each of these arguments is then found and displayed.  A
       section,  if  provided, will direct man to look only in that section of
       the manual.  The default action is to search in all  of  the  available
       sections following a pre-defined order (see DEFAULTS), and to show only
       the first page found, even if page exists in several sections.

       The table below shows the section numbers of the manual followed by the
       types of pages they contain.

       1   Executable programs or shell commands
       2   System calls (functions provided by the kernel)
       3   Library calls (functions within program libraries)
       4   Special files (usually found in /dev)
       5   File formats and conventions, e.g. /etc/passwd
       6   Games
       7   Miscellaneous  (including  macro  packages  and  conventions), e.g.
           man(7), groff(7), man-pages(7)
       8   System administration commands (usually only for root)
       9   Kernel routines [Non standard]

       A manual page consists of several sections.

       Conventional section names include NAME, SYNOPSIS,  CONFIGURATION,  DE‐
       SCRIPTION,  OPTIONS,  EXIT STATUS,  RETURN VALUE,  ERRORS, ENVIRONMENT,
       FILES,  VERSIONS,  STANDARDS,  NOTES,  BUGS,  EXAMPLE,   AUTHORS,   and
       SEE ALSO.
```

Also, you should explore **info** pages. Info pages are another trove of information about the Linux system. An example of permissions is given in the "The One with File Permissions" section.    
```
$ info
```
Next, locate a section. A chapter-wise menu will open; read through it. After a few pages, you will surely remember how to locate pages and help.   

Very handy key strokes:   
H - Help (it's a toggle; to close the pop-up menu as well)    
TAB - next hyperlink    
RET (Enter) - go to a node/page    
u - one level up    
t - top of the current menu    
d - main menu for info    
p - previous node/page in navigation    
n - next node/page in navigation   
Up/Down keys, Pg Up/Down keys, Pg Scroll work.    

Try these:   
```
info coreutils 
info find 
info date 
```

----

## Know processors

How many processors does the system have? To know details and processor flags:   
```
cat /proc/cpuinfo  
cat /proc/cpuinfo | grep "processor"  
```
Could you check the output? If you get eight entries with processors numbered from 0 to 7, this suggests eight logical cores.  

[Advanced]: Could you tell me more about CPU architecture, please?    
There you go with lscpu    
```
$ lscpu
Architecture:             x86_64                              <== 64-bit 
  CPU op-mode(s):         32-bit, 64-bit                      <== can work in 32-bit or 64-bit modes 
  Address sizes:          39 bits physical, 48 bits virtual 
  Byte Order:             Little Endian                       <== Intel in Little Endian 
CPU(s):                   8                                   <== number of CPUs 
  On-line CPU(s) list:    0-7
Vendor ID:                GenuineIntel
  Model name:             11th Gen Intel(R) Core(TM) i5-1135G7 @ 2.40GHz    <== CPU model 
    CPU family:           6
    Model:                140
    Thread(s) per core:   2
    Core(s) per socket:   4
    Socket(s):            1
    Stepping:             1
    CPU(s) scaling MHz:   26%
    CPU max MHz:          4200.0000
    CPU min MHz:          400.0000
    BogoMIPS:             2764.80
    Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscal
                          l nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_f
                          req pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_d
                          eadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l2 cdp_l2 ssbd ibrs ibpb stibp ibrs_enha
                          nced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid rdt_a avx512f avx512dq rdsee
                          d adx smap avx512ifma clflushopt clwb intel_pt avx512cd sha_ni avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves split_lock_det
                          ect user_shstk dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp hwp_pkg_req vnmi avx512vbmi umip pku ospke avx512
                          _vbmi2 gfni vaes vpclmulqdq avx512_vnni avx512_bitalg avx512_vpopcntdq rdpid movdiri movdir64b fsrm avx512_vp2intersect md_cle
                          ar ibt flush_l1d arch_capabilities
Virtualization features:  
  Virtualization:         VT-x                             <== Virtualization flag 
Caches (sum of all):      
  L1d:                    192 KiB (4 instances)            <== L1 data cache 
  L1i:                    128 KiB (4 instances)            <== L1 instruction cache 
  L2:                     5 MiB (4 instances)              <== L2 cache present 
  L3:                     8 MiB (1 instance)               <== L3 cache present 
NUMA:                     
  NUMA node(s):           1
  NUMA node0 CPU(s):      0-7
Vulnerabilities:                                           <== Vulnerabilities with Mitigation, as possible 
  Gather data sampling:   Mitigation; Microcode
  Itlb multihit:          Not affected
  L1tf:                   Not affected
  Mds:                    Not affected
  Meltdown:               Not affected
  Mmio stale data:        Not affected
  Reg file data sampling: Not affected
  Retbleed:               Not affected
  Spec rstack overflow:   Not affected
  Spec store bypass:      Mitigation; Speculative Store Bypass disabled via prctl
  Spectre v1:             Mitigation; usercopy/swapgs barriers and __user pointer sanitization
  Spectre v2:             Mitigation; Enhanced / Automatic IBRS; IBPB conditional; RSB filling; PBRSB-eIBRS SW sequence; BHI SW loop, KVM SW loop
  Srbds:                  Not affected
  Tsx async abort:        Not affected
```

----

## Know memory

How much memory (RAM / main memory / primary memory to run programs) does the system have? You can see installed, free, and other memory details:  
```
cat /proc/meminfo  
```
Check the output for MemTotal, MemFree, and MemAvailable.  

Note: Why should you consider MemAvailable from 2014 onward? [Check this patch](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34e431b0ae398fc54ea69ff85ec700722c9da773) and [post 1](https://stackoverflow.com/questions/30869297/difference-between-memfree-and-memavailable) and [post 2](https://superuser.com/questions/980820/what-is-the-difference-between-memfree-and-memavailable-in-proc-meminfo). To maintain the flow, continue reading.   

Note:- It is good to learn about [types of RAM](https://www.techtarget.com/searchstorage/definition/DIMM), such as earlier SIMM, and DIMM, buffered memory, Load-Reduced or LR-DIMM (with iMB to isolate data and address), Small Outline or SO-DIMM (compact form factor for recent laptops/tablets), etc. A post on [which one to use](https://www.dasher.com/server-memory-rdimm-vs-lrdimm-and-when-to-use-them/) and [difference](https://www.faceofit.com/rdimm-vs-irdimm-vs-udimms/) can be helpful. To maintain the flow, continue reading.    

[Advanced] Can we know the main memory (RAM) address ranges?   
There you go with lsmem   
```
$ lsmem 
RANGE                                  SIZE  STATE REMOVABLE  BLOCK
0x0000000000000000-0x000000004fffffff  1.3G online       yes    0-9
0x0000000060000000-0x0000000067ffffff  128M online       yes     12
0x0000000100000000-0x000000048fffffff 14.3G online       yes 32-145

Memory block size:       128M
Total online memory:    15.6G
Total offline memory:      0B
```

----

## GB or GiB    

GB and GiB are data storage units in terms of bytes.    

GB  - Gigabyte: is based on the decimal system, 1 GB = 10^9 bytes (1,000,000,000 bytes or 1 billion bytes, 1 followed by 9 zeros)    
GiB - Gibibyte: is based on the binary system, 1 GiB = 2^30 bytes (1,073,741,824 bytes).     

1 GiB is slightly larger than 1 GB (7.3%)     

1 TB  = 10^12 bytes or 1,000,000,000,000 bytes or 1 trillion bytes, 1 followed by 12 zeros     
1 TiB = 2^40 bytes  or 1,099,511,627,776 bytes     

1 TiB is larger than 1 TB (9.9%)     

A PiB (pebibyte) is approximately 12.6% larger than a PB (petabyte) (1 PiB ≈ 1.126 PB)    

Note:-    
1. International Electrotechnical Commission (IEC - https://iec.ch) standardized the use of prefixes like "kibi-", "mebi-", "gibi-", "tebi-", "pebi-", etc., to represent binary multiples, reserving "kilo-", "mega-", "giga-", "tera-", "peta-", etc., for decimal multiples.     
2. Certain OS or software utilities may display storage values slightly different or less than vendor published values because of the GB/GiB unit used. For TeraBytes, PetaBytes (and higher), the difference becomes significant because of the growth of the power of 2 versus the power of 10.     
3. One can read the man page of the top command. There is no need to memorise the large numbers.   

---- 

## List hardware 

How can I list hardware details?  
```
lshw -short
```

It is nice to know about system hardware such as hard disk, graphics card, audio, and network controllers (wired and wifi)  
```
lshw | grep -A7 -i "disk"          <== Hard disk details  
lshw -short                        <== for graphics card, look for display  
lspci -v | grep -A7 -i "audio"     <== Audio device details  
lspci -v | grep -A7 -i "ethernet"  <== Network Controller for Ethernet (LAN)  
lspci -v | grep -A7 -i "wireless"  <== Network Controller for wireless (Wi-Fi)
lspci -v | grep -A7 -i "graphics"  <== Graphics card or GPU 
lspci -v | grep "  VGA"            <== Graphics card or GPU 
lshw -C display                    <== Graphics card or GPU 
```

There is also a GUI for hardware information.   

On Ubuntu, to get hardinfo:  
```
sudo apt install hardinfo 
```

To know about peripheral interconnects/ports:    
```
lspci -vvv 
```

Tell me about all that is USB:   
```
$ lsusb -vt
/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/1p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
/:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/4p, 10000M
    ID 1d6b:0003 Linux Foundation 3.0 root hub
/:  Bus 003.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/12p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
    |__ Port 006: Dev 002, If 0, Class=Video, Driver=uvcvideo, 480M
        ID 1bcf:28cc Sunplus Innovation Technology Inc. 
    |__ Port 006: Dev 002, If 1, Class=Video, Driver=uvcvideo, 480M
        ID 1bcf:28cc Sunplus Innovation Technology Inc. 
    |__ Port 008: Dev 003, If 0, Class=Application Specific Interface, Driver=[none], 480M
        ID 0a5c:5843 Broadcom Corp. 
    |__ Port 010: Dev 004, If 0, Class=Wireless, Driver=btusb, 12M
        ID 8087:0026 Intel Corp. AX201 Bluetooth
    |__ Port 010: Dev 004, If 1, Class=Wireless, Driver=btusb, 12M
        ID 8087:0026 Intel Corp. AX201 Bluetooth
/:  Bus 004.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/4p, 10000M
    ID 1d6b:0003 Linux Foundation 3.0 root hub
```

----

## Environment variables    

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

What is a path? No one figured this out quite so well. Jokes apart, in Linux, everything is a file, and we may need to refer to files and where they reside.    

> In Linux, everything is a file (LIFE is FILE and FILE is LIFE).    

* Path helps to navigate around the file system and files in Linux, where almost everything is a file.
* In the hierarchical directory structure, we can refer to the path of a regular file (-), a directory (d), or a symbolic link (l) using an absolute or a relative path.
* An **absolute path** corresponds to a path beginning from / or root. e.g. /home/rps/example.desktop
* A **relative path** corresponds to a path relative to the current directory (pwd) or any other directory. e.g. Downloads/package.deb or ../../home/rps/Downloads/package.deb or ~/data/file.txt     

How do we refer to a path in commands?    

List a special environment variable called PATH, which contains a list of directories separated by a colon (:)     
```
echo $PATH
```

Update the PATH variable to include the Videos directory   
```
$ echo $PATH                            <== List existing PATH 
/home/rps/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

$ export PATH=$PATH:/home/rps/Videos    <== appending dir will put additions in the end, pre-pending will put additions first 

$ echo $PATH                            <== check after export 
/home/rps/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/rps/Videos
```

Order of directories in the PATH variable matters! If any command or utility is present in more than one directory in the PATH, the first one in the PATH listing will be picked up.    

To have a newly added directory searched first in the path, add the new directory first and then append the existing contents of the path variable. Use the `which` command to locate the first binary or built-in utility being referenced.    
e.g. To have /home/rps/lsav searched first in the path, use 
```
export PATH=/home/rps/lsav:$PATH
```

For Java, the CLASSPATH is used to locate classes, and LD_LIBRARY_PATH is another famous path variable used by developers for libraries.   

Q. How can I list out all directories in the PATH variable on separate lines?    
A. Okay, echo/print PATH and replace or translate ':' to a newline character.   
```
$ echo $PATH | tr ':' '\n' 
```
----

## Pathnames 

Read globbing pathnames using `man 7 glob`    

Familiarize with wildcard matching, character classes, ranges, and complement for exclusion and ranges. With regex, this will be a lot clearer.   

To know the basename of a file, or the filename without the directory prefix and extension suffix:    
```
       basename /usr/bin/sort
              -> "sort"
       basename include/stdio.h .h
              -> "stdio"
       basename -s .h include/stdio.h
              -> "stdio"
       basename -a any/str1 any/str2
              -> "str1" followed by "str2"
```
---- 

## Navigating directories   

Once we understand PATH, let us discuss how to navigate file system directories using commands such as cd, cp, mkdir, rm, and others.    

**cd**    
`pwd` - show the present or current working directory as a fully qualified path.    
`cd` - change directory to some directory; Successful cd will add or update OLDPWD environment variable.    
`cd -` - takes you to the previous directory.   
cd without any argument, or `cd ~` takes you to the user's home directory.    
`cd ..` - takes you one level up in the directory tree or to the parent directory of the current directory.   
cd ../../ - takes you two levels up and so on.   
cd ~/../rps/Downloads/qtemp - takes you to the directory relative to the home directory.   

Open a shell or new terminal and try these commands and see the output:   
```
printenv  
pwd  
cd abc  
printenv  
echo $OLDPWD  
cd -  
pwd  
echo $OLDPWD
cd /home/rps/lsav/qtemp
pwd  
cd ../  
pwd
cd ~/../rps/Downloads/qtemp
pwd 
cd
pwd 
```

**cp**   
`cp SOURCE TARGET` - copy source file or directory to target file or directory.    
`cp -r` - recursive or deep copy a directory including all its sub-directories in it.    
`cp -p` - copy and create a new file with the existing timestamp (last modified).    

**touch**    
touch myfile - create a file named myfile if it does not exist, and update the last modified timestamp if it already exists.    
You can create files using Linux-native editors, such as vi, or other text editors.   

**mkdir**    
mkdir mydir - create a new directory mydir if it does not exist.    
mkdir -p mydir - create a new directory if it does not exist, if it exists, keep quiet, show no error/warning. This is extensively used in scripts.    

**rm**    
`rm xfile` - remove xfile, a regular file, link, or an empty directory.   
`rm -r qtemp` - recursively delete the qtemp directory with content, including sub-directories in it.    
`rm -rf qtemp` - recursively delete the qtemp directory, including sub-directories in it, do not prompt yes/no/why, nothing, just do it.    

Note: Develop a habit or best practice of never using rm -rf routinely or as a privileged user. Even as a non-root user, be absolutely certain what you are deleting recursively. Remember that the previously executed sudo command has a finite caching time in the current shell. There is no going back after you hit the Enter key. Remember that there is no recycle bin or trash bin for files/directories deleted from the command line.    

**mv**   
`mv source destination` - move source file or directory to destination file or directory.    
`mv qtemp data` - rename qtemp to data.     
`mv ~/Downloads/convertFile.py ~/.scripts/convertFiles.py` - move file from Downloads directory to .scripts directory.    

----

## Locating binaries    

No challenge in admitting, at some point in time, we struggle to locate stuff.    
There are multiple ways to locate commands and binaries and determine a short description or which one is in use.    

`which`             <== which can be used to locate a command or all binaries with -a 
```
which which
which ls
which bash
which locate
which [
which -a which
```

`locate` or 'plocate`    <== locate files by name 
```
locate locate
locate which
locate bash_completion
```

`whereis`           <== is used to locate a binary, its source, and man page files for a command
```
whereis which
whereis bash
whereis [
whereis whereis
whereis bash_completion 
```

`whatis`           <== one line description from man page 
```
whatis whatis
whatis which
whatis whereis
whatis [
```

Q. which compgen, whatis compgen, whereis compgen - none of them help. Why?    
A. Recall what compgen is.    

----

## Command completion

Learn to use the tab key for command completion or completing file/directory names. This can save time in typing.  

Hint: type ds and press the tab to see command completion (e.g., dstat) if it exists or to see matching options.  
Hint: type ls -lrt /home/rps/Do  and then press tab twice, you will get matching suggestions.  

Tip: In case command completion is not working on a system, check that you have installed bash-completion and bash-completion-extras. A related [long story](https://unix.stackexchange.com/questions/264102/bash-completion-is-very-incomplete-on-centos-7).    

Reference file: /usr/share/bash-completion/bash_completion    

**compgen** is a bash builtin to complete aliases, builtins, commands, bash keywords, and functions.     
```
compgen -a                      <== list all aliases 
compgen -b                      <== list all builtins 
compgen -c                      <== list all commands 
compgen -c ls                   <== list all commands starting with ls 
compgen -k                      <== list all keywords 
compgen -A function             <== lists all functions 
compgen -abckA function > compgen_help.txt        <== list most of what compgen can complete
compgen -abckA function | grep -i --color ^ls     <== color, list most of compgen begining with ls
compgen -abckA function | grep -i --color ls$     <== color, list most of compgen ending with ls
```

Q. How does compgen get this powerful list of items?     
Hint: complete, bash_completion     

----

## Command history    

To list existing history:    
```
history
```
To search history recursively:     
Use Ctrl+r and type a few characters to search history, and then use tab to get that command:      
```
(reverse-i-search)`ssh': ssh -i rps.pem ubuntu@10.10.120.120      <== ctrl+r and then typed ssh   
```
To see a few previous commands:      
Use arrow keys => Up for previous command and down to next in the history list.     

To repeat the immediately previous command
```
!!
```
To execute the last command that began with ssh 
```
!ssh
```
To clear the history from the current terminal session or shell:    
```
history -c
```

Q. How do you hide a command from the bash shell history? Suppose you did not want to reveal something :)    
A. Try prefixing the command with one or more spaces
```
  compgen -abckA function > compgen_help.txt       <== command with one or more spaces as prefix won't appear in history. Check using the up arrow key    
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
/dev/nvme0n1p4 995047424  997257215   2209792   1.1G Windows recovery environment
/dev/nvme0n1p5 997261312 1000187903   2926592   1.4G Windows recovery environment
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

A simple `mount` command without options will show a lot of content.    

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

## Mount points   

In Unix or Linux, a mount point is a directory on a file system that is linked to another file system; logically, it is not a symlink. **proc** is a pseudo-filesystem (logical) acting as an interface to kernel data structures, and it is mounted (or made available) on **/proc** directory. Another example is HDD partition /dev/sda1 or SSD partition /dev/nvme0n1p7 mounted on / as ext3 or ext4 filesystem.    

```
$ mount | grep "ext" 
/dev/sda1      on / type ext4 (rw,relatime,errors=remount-ro)  <== HDD partition /dev/sda1 or something like that 
or 
/dev/nvme0n1p7 on / type ext4 (rw,relatime,errors=remount-ro)  <== SSD partition /dev/nvm0n1p7 or something like that 
```

Mount points are used to make the data on one logical filesystem, partition, or physical storage drive easily available in a directory structure to read or write. Think of data from an external device (physical) such as a CD-ROM, DVD, USB drive, another HDD/SSD/SCSI drive, phone, tablet, etc., to be available under /mnt/media directory.   

----

## Disk Usage   

We often want to know free space on disk, used space, etc.    

`df` - file system disk space used, available   
```
$ df -hk /
Filesystem     1K-blocks      Used Available Use% Mounted on
/dev/nvme0n1p7 219374600 116553980  91604236  56% /
```

```
$ df -ahT | grep -v "loop" | grep -v "snap"      <== exclude loop devices and snaps 
df: /run/user/1000/doc: Operation not permitted
Filesystem     Type             Size  Used Avail Use% Mounted on
sysfs          sysfs               0     0     0    - /sys
proc           proc                0     0     0    - /proc
udev           devtmpfs         7.5G     0  7.5G   0% /dev
devpts         devpts              0     0     0    - /dev/pts
tmpfs          tmpfs            1.6G  2.7M  1.6G   1% /run
/dev/nvme0n1p7 ext4             210G  112G   88G  56% /
securityfs     securityfs          0     0     0    - /sys/kernel/security
tmpfs          tmpfs            7.6G  290M  7.3G   4% /dev/shm
tmpfs          tmpfs            5.0M  8.0K  5.0M   1% /run/lock
cgroup2        cgroup2             0     0     0    - /sys/fs/cgroup
pstore         pstore              0     0     0    - /sys/fs/pstore
efivarfs       efivarfs         374K  219K  151K  60% /sys/firmware/efi/efivars
bpf            bpf                 0     0     0    - /sys/fs/bpf
systemd-1      -                   -     -     -    - /proc/sys/fs/binfmt_misc
mqueue         mqueue              0     0     0    - /dev/mqueue
hugetlbfs      hugetlbfs           0     0     0    - /dev/hugepages
debugfs        debugfs             0     0     0    - /sys/kernel/debug
tracefs        tracefs             0     0     0    - /sys/kernel/tracing
fusectl        fusectl             0     0     0    - /sys/fs/fuse/connections
configfs       configfs            0     0     0    - /sys/kernel/config
/dev/nvme0n1p1 vfat             246M  225M   22M  92% /boot/efi
binfmt_misc    binfmt_misc         0     0     0    - /proc/sys/fs/binfmt_misc
tmpfs          tmpfs            1.6G  176K  1.6G   1% /run/user/1000
gvfsd-fuse     fuse.gvfsd-fuse     0     0     0    - /run/user/1000/gvfs
```

Note the file system types we have on the system.   


`du` - estimated file system used    
```
$ du -hs ~/Downloads/
64G	/home/rps/Downloads/
```

```
du -ahkc ~/Downloads/tmp
....
7220	/home/rps/Downloads/tmp
7220	total
```

**ncdu** (NCurses Disk Usage) is a curses-based version of the well-known 'du' command, and provides a fast and colorful way to see what directories are using your disk space. You can issue ncdu in any directory. Use <Enter> on a directory to see further details and <back arrow key> to return.    

In the example below, /home/rps has a Downloads directory taking up a huge amount of space in GBs, and further, the Downloads directory has some stuff.    
```
ncdu 1.19 ~ Use the arrow keys to navigate, press ? for help
--- /home/rps --------------------------------------------------------------
   64.3 GiB [#####################] /Downloads
   14.0 GiB [####                 ] /VirtualBox VMs
    3.7 GiB [#                    ] /Android
    3.2 GiB [#                    ] /.local
    3.0 GiB [                     ] /snap
    2.8 GiB [                     ] /.android
    2.4 GiB [                     ] /.cache
    2.0 GiB [                     ] /.gradle
    1.6 GiB [                     ] /.config
  594.9 MiB [                     ] /.pub-cache
  494.6 MiB [                     ] /.vscode
  405.4 MiB [                     ] /StudioProjects
  346.9 MiB [                     ] /.jdks
  155.7 MiB [                     ] /.zoom
  106.9 MiB [                     ] /my_project_env
```

```
--- /home/rps/Downloads ----------------------------------------------------
                                    /..
   55.3 GiB [#####################] /kali-linux-2023.1-virtualbox-amd64
  854.1 MiB [                     ] /research
  831.9 MiB [                     ] /Xampp3
  282.3 MiB [                     ] /service
  241.4 MiB [                     ] /sw
   88.4 MiB [                     ] /github
```

----

## The One with File Permissions   

A Linux user is a regular user, a system user (without login), or a superuser, aka root.   

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

Linux users can belong to one or more groups. Group-level rights can be defined for users inside it. User and group are two different things; they can have the same name. A user can belong to multiple groups for defined access rights.   

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

Recall the first command we learnt, ls -lrt, now type this in any directory for files and see the output. For a directory, use: ls -ld    

The first column shows file permission mode, and columns 3 and 4 show owner and group names, respectively.   

File permission mode can be viewed as:   
=> first char is file type, - for a regular file, d for a directory, l for a symbolic link, c for a character device (/dev/null), b for a block device (/dev/loop1)   
=> Next, view 3 characters in pairs - the first three chars for the user or owner who owns a file, the next 3 chars for the group, and the last three for other than group users.   
=> These three chars pairs contain access permissions in order: r = read, w = write or x = execute   
=> There is a numeric weight associated with r, w, and x. r => 4, w => 2, and x = 1 and we can sum if any of r/w/x is present (see examples below)   
=> If a user is missing a certain access permission, that respective character is displayed as - or numerically adds up to 0   
=> These numeric values essentially come from the octal representation of r, w, and x permissions.    
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

The following are some examples of file permissions.   

```
-rwx------ : regular file, (700), only the owner can read, write, and execute this file.   
-rw-r--r-- : regular file, (544), anyone can read, only the owner can modify or delete.   
drwxr-xr-x : directory, (755), owner can read, write, and access the directory, group and other users can read the contents and access it, cd is allowed   
-rwxr-xr-x : regular file, (755), only the owner can modify or delete; however, anyone can read or execute it   
```

Using chmod, you can modify file permissions. You can grant (+) or revoke (-) for one or more users.   
Grant r or w or x permission using +r or +w or +x    
Revoke r or w or x permission using -r or -w or -x    
Before + or -, specify groups without a space.    

chmod +x : grant execute permission to all    
chmod g+w : grant write permission to the same group of users   
chmod go+r : grant read permission to group and other users, NOTE: Do not use numeric perms as we do not know other perms    
chmod 777 : grant rwx to owner, group, and non-group users. NOTE: Be very careful about why such a permission mode is being set    
chmod 744 : grant rwx to the user, read to the group, and others    

Note:-    
- Three most important files related to permissions: /etc/passwd, /etc/group, /etc/shadow
- Three most important commands related to permissions: chmod (change permissions), chown (change ownership), chgrp (change group)
- File Permissions are one way to implement and visualize Discretionary Access Control (DAC) on Linux.   

**An unsolicited advice**: Read `info` pages on permissions (chapter 27). You will love them :)   

$ info   ==> Next, go to *File Permissions and press Enter. You will see Chapter 27 with a Menu. Go to each text link and hit Enter to read further.    
```
* Menu:

* Mode Structure::              Structure of file mode bits.
* Symbolic Modes::              Mnemonic representation of file mode bits.
* Numeric Modes::               File mode bits as octal numbers.
* Operator Numeric Modes::      ANDing, ORing, and setting modes octally.
* Directory Setuid and Setgid:: Set-user-ID and set-group-ID on directories.
```
From Mode Structure   
```
The “set-user-ID bit” (“setuid bit”).
     On execution, set the process’s effective user ID to that of the
     file.  For directories on a few systems, give files created in the
     directory the same owner as the directory, no matter who creates
     them, and set the set-user-ID bit of newly-created subdirectories.

The “set-group-ID bit” (“setgid bit”).
     On execution, set the process’s effective group ID to that of the
     file.  For directories on most systems, give files created in the
     directory the same group as the directory, no matter what group the
     user who creates them is in, and set the set-group-ID bit of
     newly-created subdirectories.

The “restricted deletion flag” or “sticky bit”.
     Prevent unprivileged users from removing or renaming a file in a
     directory unless they own the file or the directory; this is
     commonly found on world-writable directories like ‘/tmp’.  For
     regular files on some older systems, save the program’s text image
     on the swap device so it will load more quickly when run, so that
     the image is “sticky”.
```
From Numeric Modes:    
```
Here is how the bits are arranged, starting with the
highest valued bit:

     Value in  Corresponding
     Mode      Mode Bit

               Special mode bits:
     4000      Set user ID
     2000      Set group ID
     1000      Restricted deletion flag or sticky bit

               The file's owner:
      400      Read
      200      Write
      100      Execute/search

               Other users in the file's group:
       40      Read
       20      Write
       10      Execute/search

               Other users not in the file's group:
        4      Read
        2      Write
        1      Execute/search
```

[A file management reading](https://computing.stat.berkeley.edu/tutorial-using-bash/file-management.html)    

Recall /bin/sh is a shell.    

```
$ ls -lrt /bin/sh
lrwxrwxrwx 1 root root 4 Mar 23 19:19 /bin/sh -> dash
```

Using buffer overflow, if a remote user can get a shell /bin/sh executing some [shellcode](https://cocomelonc.github.io/tutorial/2021/10/09/linux-shellcoding-1.html), then what he can do - try to visualize using permissions of /bin/sh - specifically see the owner and all permissions.   

**Changing default permissions using `umask`**     
* umask is used to set default permissions for new files or directories to be created.
* umask digits specify what permissions are to be revoked from new files or directories.
* Maximum permissions for a file are 666 and for a directory 777.
* Now using a umask of 022, default permissions for a file are 644 (-rw-r--r--) and for a directory 755 (drwxr-xr-x).
* Similarly, umask 002 will grant files 664 (-rw-rw-r--) and to directories 775 (drwxrwxr-x) permissions.
* Type `umask` on bash prompt to get current umask value, ignore leading zeros except rightmost 3 digits
* With umask in four digits, leading digits 4, 2, 1 have special meaning. 4xxx SUID bit set, 2xxx SGID bit set, 1xxx sticky bit set (they are different)
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
If the SUID bit is set for a program/executable while running the program, the effective user ID gets updated to the user ID of the owner of the program while it was run by a real user.   

Now, check the SUID bit for passwd :)    

```
$ ls -lrt /usr/bin/passwd
-rwsr-xr-x 1 root root 59976 Nov 24 17:35 /usr/bin/passwd
```
That's why a non-root user can change a password on Linux, even if passwd is owned by root.    

Note: There are other such programs as well, check using find / -perm /4000  or find /usr -perm -4000   

```
$ find /usr -perm -4000 
/usr/bin/pkexec
/usr/bin/chsh
/usr/bin/passwd
/usr/bin/umount
/usr/bin/chfn
/usr/bin/at
/usr/bin/newgrp
/usr/bin/su
/usr/bin/sudo
/usr/bin/fusermount3
/usr/bin/gpasswd
/usr/bin/mount
/usr/share/code/chrome-sandbox
/usr/lib/polkit-1/polkit-agent-helper-1
/usr/lib/virtualbox/VBoxHeadless
/usr/lib/virtualbox/VBoxSDL
/usr/lib/virtualbox/VBoxNetDHCP
/usr/lib/virtualbox/VBoxNetNAT
/usr/lib/virtualbox/VBoxNetAdpCtl
/usr/lib/virtualbox/VirtualBoxVM
/usr/lib/xorg/Xorg.wrap
/usr/lib/dbus-1.0/dbus-daemon-launch-helper
/usr/lib/openssh/ssh-keysign
/usr/sbin/pppd
```

Q2. Can a user see (read) or delete files created by other users under the /tmp directory?         Hint: sticky bit. 

A. Try to understand the output of the commands below:
```
$ ls -ld /tmp
drwxrwxrwt 23 root root 4096 Nov 24 12:19 /tmp                  <== notice  t  instead of x or - this t is for sticky bit 

$ ls -ld /run/lock
drwxrwxrwt 4 root root 100 May 11 18:02 /run/lock
```
If the sticky bit is set for a directory, all files inside this directory can be deleted or moved by the owner of the files or the guru (root).    

See if there are other such directories like tmp using find / -perm /1000 

```
$ find / -perm /1000 2> /dev/null             <== 2> /dev/null keeps the output quiet and error message free 
/dev/shm
/dev/shm/snap.discord
/dev/mqueue
/var/metrics
/var/crash
/var/lib/BrlAPI
/var/lib/samba/usershares
/var/spool/cron/crontabs
/var/spool/cron/atjobs
/var/spool/cron/atspool
/var/snap/cups/****/tmp
/var/tmp
/usr/share/ppd/custom
/run/lock
/snap/core**/****/run/lock
/snap/core**/****/tmp
/tmp
/tmp/.ICE-unix
/tmp/.font-unix
/tmp/.XIM-unix
/tmp/.X11-unix
/sys/fs/bpf
```

A Red Hat article on [Linux permissions: SUID, SGID and sticky bits](https://www.redhat.com/sysadmin/suid-sgid-sticky-bit).    

Q. Is there a way to avoid accidental file overwrite?    
A. There you go with chattr +a filename and check using lsattr. chattr +a sets the file attribute to append only, no write/overwrite.   
Try protecting your system config files, which do not get auto-updated, using chattr.    

----

## su and sudo    

su = substitute user, su <user> starts another shell with permissions of <user> specified.      
sudo = superuser do, sudo verifies the password of the user who executed sudo for any privileged command.     

Q. Do I really need to have a root password set on Linux? And then, how do I manage things without sharing it with others?     
A. On Ubuntu (and Debian-based systems), you can live without a root password and manage most things using sudo. Instead of sharing the root password with every user (in the lab or office) for admin tasks such as installations and running privileged utilities, sudo is a better alternative. This may not apply to Red-Hat-like systems.      


Q. Is my root password set?    
A. `sudo -i` can be used to acquire the root environment (privileged administrator). On Ubuntu and other Debian-based systems, the root password may not be set or may be locked.    
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
A. Always use "su -" for a clean substitution to the intended user identity.    
"su -" substitutes the root/target user and creates a clean shell without environment variables set by the previous user. It's a complete user substitution.    
"su" existing shell environment is more or less retained and substitutes the user. It's like mimicking a new user environment.    
After su or "su -", you can check `pwd` or `ls -lrt ~/`  and exit after any such operations.    

**Tip**:     
On Ubuntu, you can live without a root password and manage most things using sudo. Instead of sharing the root password with every user (in the lab or office) for admin tasks such as installations and running privileged utilities, sudo is a better alternative.      
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

## Remote login using ssh    

One can log in to a Linux system using   
- local login on a desktop/laptop/server using a username and password. Most convenient :) 
- local login using a bootable USB drive for install/repair.
- remote login using a GUI on VM/server using a username and password. This is rare. 
- remote login using a console/terminal on VM/server. Most preferred.

To log in to a server or virtual machine remotely from your own Linux system, you can use ssh:    
```
ssh remote_username@remote_server_ip_or_name
```
SSH using pem file:    
```
ssh -i filename.pem remote_username@remote_server_ip_or_name   
```

SSH ignores a private key file (.pem file) if it is accessible to others. You should change the permissions of the pem file to remove access for other users (600 or 400) to remove the error: Permissions 0664 for 'filename.pem' are too open.   
```
chmod 400 filename.pem  
```

----

## Transfer files using Secure Copy scp   

Using Secure Copy or SCP, we can transfer files to and from local to remote systems. Underneath, scp uses SSH for authentication and encryption.    

```
scp SOURCE DESTINATION    

scp  path-of-local-file-or-dir  user@remote-system:/path-to-remote-file-or-dir    

scp  user@remote-system:/path-of-remote-file-dir  path-of-local-file-or-dir    
```

While writing to the target location, make sure you do not have a file with the same name. It may get overwritten.   

----

## Simple web server 

One-line web server => the simplest way to show files from a directory   

```
$ python3 -m http.server 
Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
127.0.0.1 - - [03/Feb/2021 23:33:21] "GET / HTTP/1.1" 200 -
127.0.0.1 - - [03/Feb/2021 23:33:31] "GET /myvideos/ HTTP/1.1" 200 -
127.0.0.1 - - [03/Feb/2021 23:33:36] "GET /Downloads/ HTTP/1.1" 200 -
^C 
Keyboard interrupt received, exiting.

```
The web server started above can be opened in a web browser: http://0.0.0.0:8000/  
This page can be opened before you close the server using Ctrl+C.  

Note:- In case you are struggling to connect to this web server to access files from another system, check your wired/wireless network or the VLAN you are on.   

----

PART-2    

## Processes   

Use the `ps` command with options -aef or -aux and grep for user or other strings.    

ps -aux shows the USER running the process, the PID of the process, the %CPU used, the %MEM used, the status of the process, the timestamp of starting the process, and the command used to start the process.    

```
ps
ps -aef 
ps -aux
ps -aux | grep $USER 
```

Take a closer look at the ps output, notice the process ID (PID) and parent process ID (PPID).    
PID 0 (swapper) is not listed under the ps output. You see PPID 1 (init/systemd) and 2 (kthreadd) a lot more often.    
```
$ ps -aef 
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  0 Oct30 ?        00:00:40 /sbin/init splash
root           2       0  0 Oct30 ?        00:00:00 [kthreadd]
root           3       2  0 Oct30 ?        00:00:00 [pool_workqueue_release]
systemd+    1054       1  0 Oct30 ?        00:00:56 /usr/lib/systemd/systemd-oomd
root           4       2  0 Oct30 ?        00:00:00 [kworker/R-rcu_g]
root           5       2  0 Oct30 ?        00:00:00 [kworker/R-rcu_p]
root           6       2  0 Oct30 ?        00:00:00 [kworker/R-slub_]
root           7       2  0 Oct30 ?        00:00:00 [kworker/R-netns]
root           9       2  0 Oct30 ?        00:00:00 [kworker/0:0H-events_highpri]
root          12       2  0 Oct30 ?        00:00:00 [kworker/R-mm_pe]
..............
systemd+    1055       1  0 Oct30 ?        00:00:28 /usr/lib/systemd/systemd-resolved
root        1056       1  0 Oct30 ?        00:00:01 /sbin/auditd
systemd+    1059       1  0 Oct30 ?        00:00:00 /usr/lib/systemd/systemd-timesyncd
root        1283       1  0 Oct30 ?        00:00:05 /usr/libexec/accounts-daemon
avahi       1295       1  0 Oct30 ?        00:00:06 avahi-daemon: running [eg.local]
root        1296       1  0 Oct30 ?        00:00:00 /usr/sbin/cron -f -P
```

PID 0 is known as the swapper (also referred to by the nicknames sched and idle). It is not a normal user-mode process; it is rather part of the kernel.    

[Advanced] Using bpftrace, we can see that swapper exists, in fact, one per logical CPU.    
```
$ sudo bpftrace -e 'kfunc:hrtimer_wakeup { printf("%s:%d\n",curtask->comm,curtask->pid); }'
[sudo] password for rps: 
Attaching 1 probe...
swapper/2:0
swapper/0:0
swapper/7:0
swapper/6:0
swapper/5:0
swapper/3:0
swapper/2:0
swapper/6:0
```
See the [referenced post](https://medium.com/@boutnaru/the-linux-process-journey-pid-0-swapper-7868d1131316).    

The `top` command:    
- For a real-time view of a running Linux system, use the `top` command. It is interactive, and the output gets updated dynamically.   
- To get this view from the top at any instant, using `top -bn1`, and this is helpful in quiet scripts.    
- To sort output from the top (by %MEM, %CPU, TIME+) using -o and the required sort option.     

```
$ top -bn1 -o %MEM | head -n 15                       <== Find memory hungry processes 

top - 10:04:04 up 7 days, 17:07,  1 user,  load average: 1.79, 0.90, 0.58
Tasks: 382 total,   1 running, 381 sleeping,   0 stopped,   0 zombie
%Cpu(s):  1.1 us,  1.1 sy,  0.0 ni, 97.8 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st 
MiB Mem :  15395.3 total,   1763.7 free,   7009.4 used,   7635.7 buff/cache     
MiB Swap:  31250.0 total,  31168.0 free,     82.0 used.   8385.9 avail Mem 

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
  66308 rps       20   0 1408.4g 866944 150488 S   0.0   5.5  24:36.72 chrome      <== 
   6520 rps       20   0   33.0g 579860 317184 S   0.0   3.7  91:25.91 chrome      <== 
   5285 rps       20   0 2484732 537208  53760 S   0.0   3.4   1:55.39 xdg-des+    <== 
 102794 rps       20   0 1414.9g 460224 143296 S   0.0   2.9   5:24.43 chrome
 100520 rps       20   0 1408.4g 446384 156256 S   0.0   2.8   8:53.99 chrome
  38034 rps       20   0 1408.4g 411792 155632 S   0.0   2.6  13:46.40 chrome
  27310 rps       20   0 1408.5g 400288 164524 S   0.0   2.5  40:17.65 chrome
   4657 rps       20   0 4880596 349860  76108 S   0.0   2.2  70:46.71 gnome-s+
```

```
$ top -bn1 -o %CPU | head -n 15                       <== Find CPU hungry processes

top - 10:06:29 up 7 days, 17:09,  1 user,  load average: 0.40, 0.70, 0.55
Tasks: 379 total,   1 running, 378 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  1.2 sy,  0.0 ni, 98.8 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st 
MiB Mem :  15395.3 total,   1743.1 free,   7029.3 used,   7619.6 buff/cache     
MiB Swap:  31250.0 total,  31168.0 free,     82.0 used.   8365.9 avail Mem 

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
  38118 rps       20   0 1408.4g 182600 125344 S  10.0   1.2  15:32.72 chrome     <==
 192799 rps       20   0   14496   5632   3584 R  10.0   0.0   0:00.01 top        <== top itself can hog CPU 
      1 root      20   0   25104  16040   9460 S   0.0   0.1   0:19.79 systemd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.28 kthreadd
      3 root      20   0       0      0      0 S   0.0   0.0   0:00.00 pool_wo+
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker+
      5 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker+
      6 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker+
```
Tip: top itself can hog CPU time; that's why you should avoid using top on production Linux systems, same as WRKACTJOB on iSeries.    

```
$ top -bn1 -o TIME+ | head -n 15                       <== Find CPU Time consumed processes since last reboot 

top - 10:04:14 up 7 days, 17:07,  1 user,  load average: 1.51, 0.87, 0.58
Tasks: 382 total,   1 running, 381 sleeping,   0 stopped,   0 zombie
%Cpu(s):  2.4 us,  1.2 sy,  0.0 ni, 96.4 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st 
MiB Mem :  15395.3 total,   1780.1 free,   6993.0 used,   7635.6 buff/cache     
MiB Swap:  31250.0 total,  31168.0 free,     82.0 used.   8402.3 avail Mem 

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
   6520 rps       20   0   33.0g 579452 317184 S   0.0   3.7  91:25.93 chrome       <== 
   6568 rps       20   0   33.2g 232116 108576 S   0.0   1.5  88:09.67 chrome       <== 
   4657 rps       20   0 4880580 349860  76108 S   0.0   2.2  70:46.85 gnome-s+     <== 
   4469 rps       20   0  751420  78640  23176 S   0.0   0.5  47:04.41 Xorg
  27310 rps       20   0 1408.5g 400288 164524 S   0.0   2.5  40:17.66 chrome
  66308 rps       20   0 1408.4g 866944 150488 S   0.0   5.5  24:36.72 chrome
  38118 rps       20   0 1408.4g 182600 125344 S  10.0   1.2  15:28.51 chrome
    330 root     -51   0       0      0      0 S   0.0   0.0  15:21.82 irq/182+
```

----

## Process Memory Layout 
This one is my favorite topic in the OS lab. Because a) it helps to visualize virtual memory, process layout, proc interface, and shared libs/objects, b) it gets interesting every time you learn something new.     

Can I see the memory layout and the stack of a process? See [presentation]() for more details.   
To see all files related to a process with PID = $$  
``` 
ls -lrt /proc/$$
```
Now, check process memory layout (TODO: add link from OS course file having exercises on proc):   
```
cat /proc/$$/maps 
```

And the stack associated with process $$:  
```
cat /proc/$$/stack
```
Using the output of the above commands, convince yourself that you can visualise the stack, heap, and text segment of a process using virtual addresses and the output. Also, see /lib/x84_64-linux-gnu/lib\*  files and other shared libraries.  
In the above example, replace $$ with a process ID you are interested in.  

Ok, next you should try out:   
```
cat /proc/self/maps
```
Here is a link to [understand the output](https://www.baeldung.com/linux/proc-id-maps), almost line by line.   


What shared objects/libraries are used by a program? 

```
$ ldd <program>
$ ldd /bin/bash
$ ldd /bin/ls
$ ldd /usr/bin/python3.8 
```

Q. In the process memory layout seen using maps, code, heap, stack, and shared libraries, all these memory regions are fine. What are these two vdso and vsyscall memory regions?     
A. [vdso and vsyscall](https://www.baeldung.com/linux/vdso-vsyscall-memory-regions)     

Q. Where and how to learn more about /proc?   

A. One of the best ways to understand virtual memory and process memory layout: [Cheese on /proc](https://www.kernel.org/doc/Documentation/filesystems/proc.txt)   

[procmap](https://github.com/kaiwan/procmap)     

---- 

## Process Termination 

The command `kill` can be used to send a signal, including terminating a process (TERM).     

```
$ kill -9 pid     <== kill will send a signal SIGKILL (9) to pid     
```
-9, -SIGKILL, -KILL serve the same purpose.    

```
$ kill -9 -1      <== This will kill the init process, if it can,
                  <== and thereby terminate your session as well. 
```

To list all signals that kill can send:   
```
$ kill -l
 1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL	 5) SIGTRAP
 6) SIGABRT	 7) SIGBUS	 8) SIGFPE	 9) SIGKILL	10) SIGUSR1
11) SIGSEGV	12) SIGUSR2	13) SIGPIPE	14) SIGALRM	15) SIGTERM
16) SIGSTKFLT	17) SIGCHLD	18) SIGCONT	19) SIGSTOP	20) SIGTSTP
21) SIGTTIN	22) SIGTTOU	23) SIGURG	24) SIGXCPU	25) SIGXFSZ
26) SIGVTALRM	27) SIGPROF	28) SIGWINCH	29) SIGIO	30) SIGPWR
31) SIGSYS	34) SIGRTMIN	35) SIGRTMIN+1	36) SIGRTMIN+2	37) SIGRTMIN+3
38) SIGRTMIN+4	39) SIGRTMIN+5	40) SIGRTMIN+6	41) SIGRTMIN+7	42) SIGRTMIN+8
43) SIGRTMIN+9	44) SIGRTMIN+10	45) SIGRTMIN+11	46) SIGRTMIN+12	47) SIGRTMIN+13
48) SIGRTMIN+14	49) SIGRTMIN+15	50) SIGRTMAX-14	51) SIGRTMAX-13	52) SIGRTMAX-12
53) SIGRTMAX-11	54) SIGRTMAX-10	55) SIGRTMAX-9	56) SIGRTMAX-8	57) SIGRTMAX-7
58) SIGRTMAX-6	59) SIGRTMAX-5	60) SIGRTMAX-4	61) SIGRTMAX-3	62) SIGRTMAX-2
63) SIGRTMAX-1	64) SIGRTMAX	
```

Q. What are the signals that cannot be caught, blocked, or ignored in user space?   
A. SIGKILL and SIGSTOP. Because the kernel is configured to do it.    
[Related post](https://stackoverflow.com/questions/35569659/the-signals-sigkill-and-sigstop-cannot-be-caught-blocked-or-ignored-why)    

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

**Overcommit memory**    

Know more about vm.overcommit_memory and vm.overcommit_ratio at [serverfault](https://serverfault.com/questions/606185/how-does-vm-overcommit-memory-work)     

----

## Linux Capabilities   

Unprivileged or non-root processes can be enabled or disabled for certain tasks or to access some resources. They are pretty much permissions for a process.    

You can check the capabilities for a process using    
```
$ getpcaps PID   
```

When asked, the man (man capabilities), got this reply :)     
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

## Scheduling jobs 

Cron jobs come to the rescue when scheduling jobs, taking backups, or running scripts at a defined frequency.     

Relevant file: /etc/crontab is a system-wide configuration file used to schedule minute-ly, hourly, daily, monthly, and weekly jobs to be run by a user and scripts to execute.    

To make an entry, you should be familiar with the columns in the crontab file. The first five columns define job frequency, followed by the user name and the command to be executed.    

```
$ cat /etc/crontab 
# /etc/crontab: system-wide crontab          <== This is for system-wide cron jobs 

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
0,10,20,30,40,50 *    * * *	rps	cd /home/rps/lsav && touch a.out            <== every 0,10,20,30,40,50th minute, update timestamp of /home/rps/lsav/a.out, initially create it, if it does not exist.    
00 7,13,19    * * *	root	cd /home/eg/backup && ./run_backup.sh             <== every day 7:00 am, 1:00 pm, 7:00 pm, execute script /home/eg/backup/run_backup.sh to take backup      
```

Note: /etc/crontab is a global system-wide cron job scheduler. It contains a user option in the entry. Remember syntax as:    
Min Hr DoM Mth DoW user command     
00 00 01 01 * root { cd / && echo "Happy New Year!" > greetings.txt }     

Note: There is another option to schedule jobs using `crontab -e`, which is available by default for logged-in users. There is no user edit option present when editing using `crontab -e`. It can be run for a user rps using the -u flag =>  crontab -e -u rps     

Also refer: [Cron periodic config](https://docs.freebsd.org/en/books/handbook/config/#cron-periodic)     

----

## nohup   

When running a command in the terminal, it stops upon closing the terminal or disconnecting the remote session (SSH).   

Suppose the command was executed interactively (update, upgrade); now the exit status may be unknown or incomplete.    

We can use nohup (no hang up) to instruct the OS not to trap the SIGHUP signal, thereby preventing it from stopping interactive command execution.    

Run a bash script to back up resources:   
```
nohup bash backup.sh    
```
Run a system update that can run longer, uninterrupted, and may remain unattended   
```
nohup sudo apt upgrade   
```

----

## vi editor    

The vi editor has two modes: command mode (for navigating and issuing commands) and insert mode (for editing files in a buffer). Press i (to in-place insert) or a (to append) to enter insert mode. Use the Escape key to switch from Insert to Command mode.     

In insert/edit mode:    
- vi filename.txt, then use i to insert at any place in the buffer, and a to append next to the current place of the cursor    

In command mode:     
- :w to save, :wq to save and exit, :q! to exit without save    
- search using **/** followed by searchstring, then use ctrl+f to go forward (page down) and ctrl+b to go backward (like page up).     
- :1 go to first line, G (shift+ **g**) go to the last line, :n to go to nth line in the buffer.    
- :%s/SRC/TGT/g to search SRC and replace all occurrences with TGT    
- :%s/SRC/TGT/gc to search SRC and confirm to replace an occurrence of SRC with TGT    
- nYY - copy/yank n lines from the current line    
- p - paste after the current line    
- P (shift + p) to paste above the current line     
- nDD - delete n lines from the current line   
- . (dot) to repeat the immediate previous command     
- cw to change a word, this takes you into insert mode   

Q. How to copy a block of text and paste it elsewhere? Refer to the block copy in the vi editor.     

Q. How to remove ^M (a single control character) in a file at the end of each line? When files are transmitted across operating systems, this may happen.    
A. In command mode inside the vi/vim editor, :%s/^M//g          <== To type ^M there, ctrl+v followed by ctrl+m or any other such character. This is cool.   

[vim adventures game](https://vim-adventures.com/)     

[Little history and an opinion on vi](https://medium.com/@eddiec76/i-have-opinions-3a2c0af1e1ad)     

----

## Input Output redirection     

Gyan: There are three file descriptors or streams: standard input (0), standard output (1), standard error (2)     

Generally, everything we type goes into stdin or input comes from the keyboard, and both the output and errors are displayed on the console/terminal.    
```
$ ls -lrt /dev/std* 
lrwxrwxrwx 1 root root 15 Aug  1 15:25 /dev/stdout -> /proc/self/fd/1 
lrwxrwxrwx 1 root root 15 Aug  1 15:25 /dev/stdin -> /proc/self/fd/0  
lrwxrwxrwx 1 root root 15 Aug  1 15:25 /dev/stderr -> /proc/self/fd/2 
```

We can redirect output or input as below (using double quotes because of markup side-effect):    

- ">"  redirect output     
- ">>"  append to redirected output     

- "2>" redirect error     
- "2>>" append to redirected error (not required)    

- "<" redirect input    <== Tip: for large files, use cat instead of <    
- "<<" used in "here document" by cat command: `cat << END`  (get anything till you type the delimiter END)     

- "2>&1" redirects both stdout and stderr    

When desired to suppress the noise of output, stdout and stderr can be merged:     
```
locate canary > output.txt 2>&1          <== locate command may generate a lot of permission errors, and this redirection makes it quiet. 
```
Scripts use an even quieter way:    
```
command_goes_here > output.txt 2>&1 /dev/null       <== /dev/null eats everything; super cool and quiet. Always test it once and then go quiet.    
```

Note:- Using input/output redirection 2>&1 informs bash to have standard error (file descriptor 2) redirected to the same place to which standard output (file descriptor 1) is being sent (that is, to the terminal or a file).   

Caution: stdout and stderr can both be redirected or piped using 2>&1; however, there is a difference in usage.    
```
command > file.txt 2>&1         <== works fine, you can use /dev/null in the end    
command 2>&1 | another_command  <== works fine   
command 2>&1 > file.txt         <== this does not work, hence take caution   
```

Caution: Output redirection can permanently delete content. Therefore, be cautious when using '>' to redirect output. Now, what about this command? cat file.txt > file.txt.  As a best practice, you should not attempt to read from and redirect to the same file, even if it is syntactically possible.   

Tip: Storage is almost full (due to content or excessive logging after an error), and even rm is not working. Now, how to empty a large file when rm is not working?    
```
>large_file.tar    
```
This will empty large_file.tar; please note that you should know the path of the large file. This option is more handy than any type of cat, echo, or rm, and a less bulky operation.   

----

## View file content

When dealing with large files or logs, it may be necessary to view specific portions of the files.    

```
cat - cacatenate or display file content    
cat file1 file2 file3        <== view multiple files, content is appended one after the other    
cat -n program.c             <== view file with all lines numbered    
cat -ns program.c            <== view file with all lines numbered, remove multiple empty lines     
cat -bn program.c            <== view file with all non-empty lines numbered     
cat file1 file2 >> newfile   <== merge two files into a new file using output redirection    
                             <== true for text or normal files, not for images, PDFs, audio, or video files    
```

`cat filename` outputs everything on the screen (which can be too much for large files).    

Tip: What about `tac filename` ?   

`more`     <== show file contents on the terminal, can search and navigate forward (ctrl+f) and backward (ctrl+b)    
`less`     <== show file contents, does not echo on terminal, faster to load for large files    
```
           <== use /pattern to search a pattern, Page Up/Down, or spacebar to move in the file,   
           <== view multiple files, use :n to next file and :p to go to the previous file     
           <== use v to open file in default editor nano/vim, exit from editor will take you back to the less session     
           <== use q to come out of the less session.    
```
           
`tail`     <== show last part/lines of a file, default 10 lines from the end    
`tail -n +15 file`  <== show file content from line number 10 to the end.   
`tail -f`  <== show last part/lines of a file that is getting updated, like logs, e.g., tail -f /var/log/syslog     
`head`     <== show starting lines of a file, default 10 lines from the start     

Q. How can one view (show on the terminal) lines 91 to 95? Hint: Use head and tail commands.    
A. 
```
head -95 id_name.txt | tail +91 
```
or
```
tail +91 id_name.txt | head -5
``` 

----

## xargs 

`xargs` reads items from the standard input or output from other commands, delimited by blanks or newlines, and executes the command (default is echo).   

```
seq 1 10 | xargs  
```

xargs is often used with find.   

```
$ sudo find /var/log/ -type f -name "*.log" | xargs grep -l "Network"
grep: /var/log/boot.log: Permission denied
grep: /var/log/osquery/osqueryd.results.log: Permission denied
/var/log/dist-upgrade/apt-term.log
grep: /var/log/ntopng/ntopng.log: Permission denied
/var/log/teamviewer15/TeamViewer15_Logfile.log
/var/log/teamviewer15/TeamViewer15_Logfile_OLD.log
```

Repetition with seq   
```
seq 5 | xargs -I {} curl -s https://mywebsite.ac.in 

seq 3 | xargs -I {} xdg-open https://mywebsite.ac.in
```
[A few more ways to use seq](https://www.howtogeek.com/practical-ways-to-use-the-linux-seq-command/)    

----

## File compression     

zip, unzip, gzip, gunzip - create and extract zip archives   
tar - a generic compression utility for multiple compression formats (.tar, .tar.gz or .tgz, .tar.bz2, etc.)   

```
zip -r archive.zip archive         <== compress and create a package   
unzip archive.zip                  <== list (-lv) and extract the compressed file created by zip  

gzip                               <== compress files using LZ compression  
gunzip                             <== list (-lv) and extract the compressed file created by zip, gzip 

zcat -l compressed_file.tar        <== shows compressed, uncompressed size, and compression ratio 

tar -cvf logs.tar logs             <== create tar ball (file) 
tar -tvf logs.tar                  <== list (-tv) contents of tar ball (file) 
tar -xvf logs.tar                  <== extract tar ball (file)  

tar -zcvf logs.tar.gz logs         <== create tar ball in .tar.gz format or .tgz 
tar -ztvf logs.tar.gz              <== list (-tv) contents of tar ball in .tar.gz format
tar -zxvf logs.tar.gz              <== extract tar ball in .tar.gz format

tar -jcvf logs.tar.bz2 logs        <== create tar ball in .tar.bz2 format (bzip2 compression) 
tar -jtvf logs.tar.bz2             <== list (-tv) contents of tar ball in .tar.bz2 format
tar -jxvf logs.tar.bz2             <== extract tar ball in .tar.bz2 format

tar -Jcvf logs.tar.xz logs        <== create tar ball in .tar.xz format (LZMA compression)   
tar -Jtvf logs.tar.xz             <== list (-tv) contents of tar ball in .tar.xz format
tar -Jxvf logs.tar.xz             <== extract tar ball in .tar.xz format

xz -z logs.xz logs               <== xz is a general utility to compress, list, and decompress archives
xz -l logs.xz                    <== list contents of .xz file 
xz -dk logs.xz                   <== decompress .xz file 
```
v - verbose output    
f - force command    
The options above may change, though it gets easier to remember them this way.    

Note:- Linux kernel (kernel.org) uses .tar.xz format   

----

## Shell Scripting    
[bash page](bash/README.md)    

Executing a bash script:    
```
./checkDate.sh        <== execute a script in a child process or sub-shell 
. ./checkDate.sh      <== execute a script in the current shell itself, affects variables set
. ~/.bashrc.sh        <== same as above, gets variable set in the current shell from the script 
source checkDate.sh   <== same as above 
bash -v checkDate.sh  <== creates a child process/sub-shell, displays commands before running it, then executes and outputs 
bash -x checkDate.sh  <== creates a child process/sub-shell, displays commands after processing, and expands variables 
```

b/w  here are some good scripts to learn from:     
/usr/share/bash-completion/bash_completion     

----

## regex     

Regular expressions can be used with bash:    
- on the command line using "grep -E " or egrep 
- inside a bash script using conditional expressions [[ ]] and =~ for match
- grep inside if conditions using: if grep -E "regex_pattern" "variable_value" ; then _____ fi 
- using sed '/pattern/action' 
- using awk    

[Regular Expressions](https://computing.stat.berkeley.edu/tutorial-using-bash/regex.html)    
[regex with grep](https://www.cyberciti.biz/faq/grep-regular-expressions/)    

Do not miss:    
man regex    
info 8.5 Regular Expressions   
```
* Menu:

* findutils-default regular expression syntax::
* gnu-awk regular expression syntax::
* grep regular expression syntax::
* awk regular expression syntax::
* egrep regular expression syntax::
* posix-extended regular expression syntax::
```

----

## xdg-open 

You may have come across the xdg-open message when starting or joining a conference call/meeting from a browser link to a specific meeting application. It can be visible when you click a link on the website menu and that menu does not have an actual target link.    

From the man page of xdg-open:   
xdg-open is a Linux command to open a file or URL in the user's preferred application. xdg-open supports file, ftp, http, and https URLs.   

e.g. open a web page    
```
$ xdg-open 'http://www.freedesktop.org/'
$ Gtk-Message: 11:56:17.079: Not loading module "atk-bridge": The functionality is provided by GTK natively. Please try not to load it.
Opening in existing browser session.
```
TODO: add image of browser pop-up showing xdg-open message   

----

## Debugging

For debugging issues, the following can help with processes and system resources.  

Use the **top** command to display Linux processes with PID, CPU, and memory usage in real-time. Avoid using this for a long time on servers with active users.   
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
Interesting: Try pressing any arrow key while the top is on.   

Use **dstat** - a tool for generating system resource statistics such as cpu usage, disk read/write, network data received/sent, etc. To exit, type Ctrl+C.    
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
How can I find out whether a service or daemon is running or not? 
```
service <service_or_daemon_name> status 
service mysql status 
service apache2 status 
```
See the output; if the Active field shows "active (running)", it is running, good to go. 
If the Active field shows failed, there was a problem running the service, and it needs to be fixed. 


Where do I see the logs and errors? 
```
dmesg 
ls -lrt /var/log/ 
```
In /var/log/ directory, see the most recent logs, like dmesg, syslog, dpkg log, etc., to debug the problem.  

----

## File conversion 

### File format conversion   
Image file format conversion can be done using convert (ImageMagick).    

### Resizing image files:   
Identify and resize an image file by pixel resolution or % reduction using convert    

```
$ identify T1_sig.jpeg 
T1_sig.jpeg JPEG 1600x574 1600x574+0+0 8-bit sRGB 45273B 0.000u 0:00.000

$ convert -resize 25% T1_sig.jpeg T1_sig_25p.jpeg                 <== reduce to 25% (this is different from by 25%)  

$ identify T1_sig_25p.jpeg 
T1_sig_25p.jpeg JPEG 400x144 400x144+0+0 8-bit sRGB 3737B 0.000u 0:00.000
```

### Resizing PDF files    
Use pdfinfo to know the PDF file attributes.    

For PDFs, Ghost Script provides one of the best compression outputs using the ebook (150 dpi) setting    
```
$ gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=JUGGLED_Text_screen.pdf JUGGLED_Text.pdf
```
or screen (72 dpi) that is even smaller    
```
$ gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=JUGGLED_Text_screen.pdf JUGGLED_Text.pdf
```

See below, a 17.9 MB PDF file is converted to 1.5 MB PDF file.    
```
$ pdfinfo CanvasLMSOverview.pdf 
Title:           WORD ONLY_Canvas LMS Overview_K-12_US.docx-ENG
Author:          Sally Langford
Creator:         Word
Producer:        macOS Version 14.4.1 (Build 23E224) Quartz PDFContext
CreationDate:    Thu Apr  4 09:55:21 2024 IST
ModDate:         Thu Apr  4 09:55:21 2024 IST
Custom Metadata: no
Metadata Stream: no
Tagged:          no
UserProperties:  no
Suspects:        no
Form:            none
JavaScript:      no
Pages:           51
Encrypted:       no
Page size:       595 x 842 pts (A4)           <== 51 A4 pages
Page rot:        0
File size:       17902878 bytes               <== 17.9 MB 
Optimized:       no
PDF version:     1.4

$ gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=CanvasLMSOverview_screen.pdf CanvasLMSOverview.pdf 

$ pdfinfo CanvasLMSOverview_screen.pdf 
Title:           WORD ONLY_Canvas LMS Overview_K-12_US.docx-ENG
Author:          Sally Langford
Creator:         Word
Producer:        GPL Ghostscript 10.02.1                 <== gs created 
CreationDate:    Sat Mar 30 19:52:09 2025 IST
ModDate:         Sat Mar 30 19:52:09 2025 IST
Custom Metadata: no
Metadata Stream: yes
Tagged:          no
UserProperties:  no
Suspects:        no
Form:            none
JavaScript:      no
Pages:           51
Encrypted:       no
Page size:       595 x 842 pts (A4)
Page rot:        0
File size:       1524977 bytes                     <== 1.5 MB
Optimized:       no
PDF version:     1.4
```

----


PART-3

## Windowing System for GUI   

X11 or X is a Window System for Unix/Linux distributions. While Linux came essentially as a kernel in 1991, it remained a terminal-based OS for time, for graphics or GUI on servers/desktops, X developed at MIT in the 80s remains the default choice. The last updated protocol version 11 of X gives it the name X11. Due to missing encryption between client and X server, [Wayland](https://wayland.freedesktop.org/architecture.html) has appeared as an alternative window system (default on Ubuntu 22.04 LTS). Here is a [nice reading on X11](https://www.baeldung.com/linux/x11) and [GUI in linux](https://www.baeldung.com/linux/gui).    

**Switching between X11 and Wayland**   
The Zoom app has an interesting bug for screen sharing in Linux systems (desktop/laptop) using the default Wayland windowing system. Only Whiteboard sharing is enabled, and there is no option to share desktop/laptop screens. It appears Zoom may have decided not to fix this bug.    

To enable screen sharing on Linux Desktop/Laptop with Zoom, disable Wayland in the Graphical Display Manager (GDM) config and switch to Xorg/X11 windowing system.   

```
$ sudo vi /etc/gdm3/custom.conf    <== edit gdm custom.conf using editor   
# Uncomment the line below to force the login screen to use Xorg   
#WaylandEnable=false               <== Uncomment this and restart the system   
```

Now, after this workaround, Zoom will show Desktop sharing alongside Whiteboard sharing.    

TODO: add QT (not fully FOSS) and GTK (FOSS)    

Links for further reading [x.org](https://x.org/wiki/), compiz, unity, GNOME, wayland     

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

## `hostnamectl`

Display and change hostname (hostnamectl hostname mylaptop):   

```
$ hostnamectl 
 Static hostname: eg
       Icon name: computer-laptop
         Chassis: laptop 💻
      Machine ID: a1bf123456789ba8ba123456b1bc12f1qwerty
         Boot ID: d12c1edcc12e1ee1bba1daa123ba1d1cqwerty
Operating System: Ubuntu 24.04.1 LTS              
          Kernel: Linux 6.8.0-40-generic
    Architecture: x86-64
 Hardware Vendor: Dell Inc.
  Hardware Model: Latitude 54321
Firmware Version: 1.40.0
   Firmware Date: Tue 2024-09-09
    Firmware Age: 6month 3w
```
----

## `networkctl`    

Use `networkctl` to query and print the status of network links/interfaces.    

```
$ networkctl status wlp0s20f1
systemd-networkd is not running, output might be incomplete.
Failed to query link bit rates: Unit dbus-org.freedesktop.network1.service not found.
Failed to query link DHCP leases: Unit dbus-org.freedesktop.network1.service not found.
● 3: wlp0s20f1
                   Link File: /usr/lib/systemd/network/99-default.link
                Network File: n/a
                       State: n/a (unmanaged)
                Online state: unknown
                        Type: wlan
                        Path: pci-0000:00:14.3
                      Driver: iwlwifi
                      Vendor: Intel Corporation
                       Model: Wi-Fi 6 AX201
            Hardware Address: 50:84:92:44:55:66 (Intel Corporate)
                         MTU: 1500 (min: 256, max: 2304)
                       QDisc: noqueue
IPv6 Address Generation Mode: none
          Wi-Fi access point: LMN_PQR (11:a1:aa:01:aa:01)
    Number of Queues (Tx/Rx): 1/1
                     Address: 172.16.8.254
                              fe80::437c:dd6a:b7f2:7850
                     Gateway: 172.18.0.1
```

----

## `perf`   

Use perf to see how much CPU every function is using.  
```
$ sudo perf top 
```

Use perf to gather statistics on CPU context switches, page faults, L1/TLB cache misses, etc.   

```
$ sudo perf stat -ddd ls -R /              <== May take some time to complete, you can ctrl+c to stop midway 
...............
 Performance counter stats for 'ls -R /':

          3,807.22 msec task-clock                       #    0.740 CPUs utilized             
            19,023      context-switches                 #    4.997 K/sec                     
                37      cpu-migrations                   #    9.718 /sec                      
             1,456      page-faults                      #  382.431 /sec                      
    5,71,75,96,616      cycles                           #    1.502 GHz                         (33.56%)
    9,86,70,16,940      instructions                     #    1.73  insn per cycle              (39.97%)
    1,81,89,19,207      branches                         #  477.755 M/sec                       (46.54%)
       1,91,59,643      branch-misses                    #    1.05% of all branches             (53.02%)
                        TopdownL1                 #      1.1 %  tma_backend_bound      
                                                  #     79.5 %  tma_bad_speculation    
                                                  #      8.8 %  tma_frontend_bound     
                                                  #     10.5 %  tma_retiring             (59.82%)
    2,30,88,08,972      L1-dcache-loads                  #  606.429 M/sec                       (66.12%)
       7,27,03,595      L1-dcache-load-misses            #    3.15% of all L1-dcache accesses   (66.21%)
         65,14,803      LLC-loads                        #    1.711 M/sec                       (66.06%)
         13,95,991      LLC-load-misses                  #   21.43% of all LL-cache accesses    (66.44%)
   <not supported>      L1-icache-loads                                                       
      18,78,34,314      L1-icache-load-misses                                                   (27.09%)
    2,32,04,99,082      dTLB-loads                       #  609.500 M/sec                       (27.20%)
          1,45,988      dTLB-load-misses                 #    0.01% of all dTLB cache accesses  (27.11%)
   <not supported>      iTLB-loads                                                            
         22,68,399      iTLB-load-misses                                                        (26.98%)
   <not supported>      L1-dcache-prefetches                                                  
   <not supported>      L1-dcache-prefetch-misses                                             

       5.148173075 seconds time elapsed

       1.242195000 seconds user
       2.590174000 seconds sys
```

```
$ sudo perf stat -ddd ls -R /home 
/home:
..........
 Performance counter stats for 'ls -R /home':

            806.22 msec task-clock                       #    0.993 CPUs utilized             
                 4      context-switches                 #    4.961 /sec                      
                 0      cpu-migrations                   #    0.000 /sec                      
             1,451      page-faults                      #    1.800 K/sec                     
    1,30,21,25,732      cycles                           #    1.615 GHz                         (32.98%)
    2,35,44,93,820      instructions                     #    1.81  insn per cycle              (39.67%)
      45,08,16,552      branches                         #  559.172 M/sec                       (46.36%)
         52,40,721      branch-misses                    #    1.16% of all branches             (53.05%)
                        TopdownL1                 #      6.1 %  tma_backend_bound      
                                                  #     54.7 %  tma_bad_speculation    
                                                  #     13.5 %  tma_frontend_bound     
                                                  #     25.7 %  tma_retiring             (59.76%)
      54,78,89,499      L1-dcache-loads                  #  679.577 M/sec                       (66.70%)
       1,19,18,231      L1-dcache-load-misses            #    2.18% of all L1-dcache accesses   (66.82%)
         18,32,683      LLC-loads                        #    2.273 M/sec                       (66.95%)
          2,40,908      LLC-load-misses                  #   13.15% of all LL-cache accesses    (67.02%)
   <not supported>      L1-icache-loads                                                       
       3,26,98,168      L1-icache-load-misses                                                   (26.72%)
      57,37,25,470      dTLB-loads                       #  711.623 M/sec                       (26.60%)
            27,241      dTLB-load-misses                 #    0.00% of all dTLB cache accesses  (26.48%)
   <not supported>      iTLB-loads                                                            
          7,34,089      iTLB-load-misses                                                        (26.30%)
   <not supported>      L1-dcache-prefetches                                                  
   <not supported>      L1-dcache-prefetch-misses                                             

       0.811706247 seconds time elapsed

       0.340501000 seconds user
       0.466687000 seconds sys
```

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
```

```
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
```

```
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

APT-related cleanup of unused packages. 
```
$ sudo apt autoremove --purge
```

Remove old kernel files manually. Caution: Know what you are deleting! Do not delete the current and previous kernel image/headers and  module files. 
```
$ sudo dpkg --list 'linux-*'
$ sudo apt remove linux-image-5.0*
$ sudo apt remove linux-headers-5.0*
$ sudo apt remove linux-modules-5.0*
$ sudo apt remove linux-modules-extra-5.0*
```

Find the APT cache and clean it up. 
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

## User account management 

To add a new user: `useradd`   

To delete an existing user: `userdel`   

To modify an existing user: `usermod`   

To disable login for a user:  set user login shell to nologin :)    
```
usermod user_name -s /sbin/nologin           <== message to user "This account is currently not available."
                                             <== check: man nologin   
```   
To lock or unlock a user account:    
```
usermod -L username                          <== check /etc/shadow, the second column will show a ! sign 
usermod -U username 
```

To view the user account password settings:   
```
$ sudo chage --list user_name
[sudo] password for user_name: 
Last password change					: Dec 01, 2022
Password expires					: never
Password inactive					: never
Account expires						: never
Minimum number of days between password change		: 0
Maximum number of days between password change		: 99999
Number of days of warning before password expires	: 7
```

To set a user's password to expire on a date:    
```
sudo chage -E 2025-12-31 user_name
```

----

## The One with mysql admin password

Sometimes, you may forget your MySQL admin password, and you want to reset it.  

Log in to mysql using sudo and issue the following command: 
```
alter user 'root'@'localhost' identified with mysql_native_password by 'nopassisgoodpass';
```

**To backup mysql db**  
```
mysqldump --databases testdb --user=root --password > backupdb.sql
```

If required on the target system, set the password using the alter user command as above.  

**To restore mysql db**  
```
mysql -u root -p < backupdb.sql
```

Note on - **MySQL authentication** error   

There is an issue with the authentication plugin while upgrading or migrating the MySQL database (from 5.7) to 8.0.   
The error message on the screen is not very informative about it - ERROR 1698 - Access Denied for user 'root'@'localhost'.   

The default authentication type in MySQL 8.0 is **caching_sha2_password**, and this newer plugin may not load or is not available.   
One way to get around is to alter the database user to use an earlier authentication type, such as mysql_native_password (as in mysql-5.7), or better, migrate to caching_sha2_password for the future.    

Relevant posts on this authentication type conundrum:    
- [A Tale of Two Password Authentication plugins](https://dev.mysql.com/blog-archive/a-tale-of-two-password-authentication-plugins/)    
- [change authentication methods](https://ostechnix.com/change-authentication-method-for-mysql-root-user-in-ubuntu/)    
- [alter user with mysql_native_password](https://medium.com/@crmcmullen/how-to-run-mysql-8-0-with-native-password-authentication-502de5bac661)    

---- 

## Linux software

[Linux Software](https://github.com/luong-komorebi/Awesome-Linux-Software)    

[Writing mathematical equations in Libre Office Writer](https://www.ubuntubuzz.com/2016/09/libreoffice-writer-equation-editor-writing-mathematical-formulas.html)     

---- 

## Linux toolchain   

Cool compilers/interpreters:  

<table>
 <tr><td>clang</td><td>Front end for LLVM, for C/C++/Objective C/C++</td></tr>
 <tr><td>gcc</td><td>Front end for GCC, for C/C++ on Linux</td></tr>
 <tr><td>g++</td><td>Front end for GCC, for C++ on Linux</td></tr>
 <tr><td>java</td><td>Java interpreter from Sun/Oracle/IBM</td></tr>
 <tr><td>python3</td><td>Python for quick prototypes and Data Science/ML libraries</td></tr>
 <tr><td>Haskell</td> <td><a href="https://www.haskell.org/ghc/">GHC</a>), <a href="https://downloads.haskell.org/ghc/latest/docs/users_guide/ghci.html">GHCi</a>)</td></tr>
</table>

To check if Java runtime environment (JRE) is installed: $ java --version   
To see if Java SDK is installed: $ javac   

For functional programming, start with Scheme and then consider Haskell.    

For web development: check the LAMP (Linux, Apache, MySQL, PHP) stack with HTML5 and Tailwind or MEAN/MERN/MEVN with Node.js or TypeScript.    
TODO: add bootcamp link.    

For GUI: check GTK (fully FOSS) and QT (not fully FOSS).    
TODO: add prototype link, LDAPViewer.    

The choice of the toolchain can be based on the need, stability, toolchain maintainers, and availability of manpower.    

----

PART-4     

## Monitoring Performance   

`nload`   


`iptraf` - IP Network Statistics Utility   

```
$ sudo iptraf

iptraf-ng 1.2.1

                                    ┌─────────────────────────────────┐
                                    │ IP traffic monitor              │
                                    │ General interface statistics    │
                                    │ Detailed interface statistics   │
                                    │ Statistical breakdowns...       │
                                    │ LAN station monitor             │
                                    │─────────────────────────────────│
                                    │ Filters...                      │
                                    │─────────────────────────────────│
                                    │ Configure...                    │
                                    │─────────────────────────────────│
                                    │ About...                        │
                                    │─────────────────────────────────│
                                    │ Exit                            │
                                    └─────────────────────────────────┘

 Displays current IP traffic information
 Up/Down-Move selector  Enter-execute
```

----

## Audit System Logs 

AuditD can be used to generate audit summary of system logs.   

```
$ sudo aureport 

Summary Report
======================
Range of time in logs: 29/03/25 17:40:20.860 - 29/03/25 17:40:36.317
Selected time for report: 29/03/25 17:40:20 - 29/03/25 17:40:36.317
Number of changes in configuration: 3
Number of changes to accounts, groups, or roles: 0
Number of logins: 0
Number of failed logins: 0
Number of authentications: 0
Number of failed authentications: 0
Number of users: 2
Number of terminals: 4
Number of host names: 1
Number of executables: 3
Number of commands: 2
Number of files: 0
Number of AVC's: 0
Number of MAC events: 0
Number of failed syscalls: 0
Number of anomaly events: 0
Number of responses to anomaly events: 0
Number of crypto events: 0
Number of integrity events: 0
Number of virt events: 0
Number of keys: 0
Number of process IDs: 5
Number of events: 12
```
[Sample audit rules](https://github.com/Neo23x0/auditd/blob/master/audit.rules)    

---- 

## Linux for Networking 

[egnet](https://github.com/rks101/egnet)  

----

## Linux for Security    

* Unlike Windows, Linux was designed from the ground up as a multiuser operating system. Therefore, user-level security provisions tend to be a bit better on a Linux system.   
* Linux offers a better separation between administrative users and unprivileged users. This makes it a bit harder for intruders, and it also makes it a bit harder for a user to accidentally infect a Linux machine with something nasty.
* Linux is much more resistant to viruses and malware infections than Windows is. Certain Linux distributions come with built-in mechanisms, such as SELinux in Red Hat and its free-of-charge clones, and AppArmor in Ubuntu and SUSE, that help prevent intruders from taking control of a system.
* Linux is free and open source software. This allows anyone who has the skill to audit Linux code to hunt for bugs or backdoors.

Yet even with those advantages, Linux is just like everything else that has been created by mankind. That is, it is not perfect.   

[LinEnum - Linux Enumeration and Privilege Escalation/Exploration Script](https://github.com/rebootuser/LinEnum)    

[Linux privilege escalation and exploration](https://sushant747.gitbooks.io/total-oscp-guide/content/privilege_escalation_-_linux.html)    

----

## crt and key file   

For SSL/TLS certificate setup on an HTTP server, it requires a certificate and a private key.   
[Public key certificate and private key file](https://www.baeldung.com/linux/crt-key-files)   

---- 

## Linux Kernel   

[Linux Kernel Home](https://www.kernel.org/) for stable kernel releases.    

[Core API Documentation](https://www.kernel.org/doc/html/latest/core-api/index.html)    

Examples for logging [printk](https://www.kernel.org/doc/html/latest/core-api/printk-basics.html)    

[Kernel release cycle]()    

----

## Virtualization    

[Virtualization and QEMU](https://docs.saferwall.com/blog/virtualization-internals-part-4-qemu/)    

----

PART-5

## The One with UNIX/Linux History 

One can say, in a very broad way:    
- An open-source OS is free to download from an online repo, free to use, or modify (no license cost). Free refers to freedom of choice! There may be a packaging or shipping cost or a support cost.    
- A closed-source OS is someone's proprietary binary source files, and the user cannot modify the source. Usually, this comes with a license cost or a cost is added with the accompanying device being sold.   

Some closed-source early UNIX favours:   
BSD UNIX: Berkeley Software Distribution had three flavours or variants, such as [FreeBSD](https://en.wikipedia.org/wiki/FreeBSD), OpenBSD, and NetBSD.    
SCO UNIX: was based on FreeBSD, managed by Santa Cruz Operations, and later sold to the OpenServer maintainer.    
Solaris: Unix from Sun Microsystems.    
AIX: IBM Unix    
HP-UX: HP Unix    
[BSD](https://en.wikipedia.org/wiki/Berkeley_Software_Distribution)    
Mac OS:   

Some open-source UNIX/Linux favours/variants:   
Linux:    
Debian:   
Ubuntu:   
Fedora:    
Open SUSE:   
CentOS:    

Q. Does a mainframe or AS400 run Unix/Linux?   
A. Unix that runs on a Mainframe is called AIX (POSIX-compliant). AS400 - specifically IBM iSeries or System i or IBM i runs Linux with ease.   

Some reading material: [1](http://www.linfo.org/flavors.html) and [2](https://www.lifewire.com/unix-flavors-list-4094248)   

---- 

## Advantage Linux 

I have been using Linux as a primary desktop/laptop OS for over 20 years, well before getting my first desktop. One can always count on community support, forums, and there are so many instances where you can get help on online forums and web pages. Ever wondered what gets them going? Who pays their bills? What could you do to get this going?   

----

## The One with Linus

[The talk with not so visionary, not so people-person, a simple, happy engineer](https://www.youtube.com/watch?v=o8NPllzkFhE) Linus Torvalds, who changed the world at least twice with Linux and Git. He started both projects as a hobby and to solve the problems he was facing. On mailing lists, he speaks his mind.    

---- 

## LWN 

[Linux Weekly News](https://lwn.net/)    

----
