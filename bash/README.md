# Shell Scripting    
Shell scripting provides a convenient way to automate system administration, software development, and routine tasks on Unix-like operating systems. Bash is one of the most widely used Unix shells and scripting languages.   

* [bash](#bash)
  * [Intro](#intro)
  * [`echo`](#echo)
  * [Using quotes for string literals](#using-quotes-for-string-literals) 
  * [Comamnd Substitution](#command-substitution)
  * [Reading input](#reading-input)
  * [Bash builtin](#bash-builtin)
  * [Test expressions](#test-expressions)
  * [Conditions](#conditions)
  * [Loops](#loops)
  * [Case](#case)
  * [Help](#help)
  * [bash one liners](#bash-one-liners)
  * [Escape Sequence and Control Characters](#escape-sequence-and-control-characters)

## Intro 

For a Bash script, use a Bash shebang such as #!/usr/bin/env bash. This asks env to locate bash using the user's PATH.   
```
#!/usr/bin/env bash

echo "Hello! bash"
````

To grant executable permissions to a script:   
```
chmod a+x script.sh
or  
chmod 755 script.sh   # 755 is a common explicit permission setting, but is not equivalent to a+x in all cases.
```

To run or execute a bash script:     
```
./script.sh        <== execute a script in a child process or sub-shell 
bash script.sh     <== same as above 
. ./script.sh      <== execute a script in the current shell itself, affects variables set
. ~/.bashrc.sh     <== same as above, imports variables set in the current shell from the script 
source script.sh   <== same as above, imports variables set     

bash -v script.sh  <== creates a child process/sub-shell, displays commands before running it, then executes and send output 
bash -x script.sh  <== creates a child process/sub-shell, displays commands after processing it, and expands variables 
```

Test the following:    
- which -a bash      <== all binaries of bash in the current PATH 
- echo $SHELL        <== SHELL environment variable, can be edited 
- cat /etc/shells    <== To find valid shells 

```
$ echo $SHELL
/bin/bash

$ which -a bash 
/usr/bin/bash        <== make sure you use desired bash in your script 
/bin/bash

$ cat /etc/shells 
# /etc/shells: valid login shells
/bin/sh
/usr/bin/sh     <== shell interpreter 
/bin/bash
/usr/bin/bash   <== shell interpreter in the bash script 
/bin/rbash
/usr/bin/rbash
/usr/bin/dash
/usr/bin/screen
```

----

## echo  

To print something: 
```
echo -e "Starting script to print diagnostic information...\n"    
```

Note:     
"-e" flag allows escape sequence \n characters.    
"-n" flag omits the trailing newline character, that is, continue printing.    

[bash grammar](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_10_02) for what characters need to be escaped or require quoting.   

----

## Using quotes for string literals   

While declaring and assigning value to string variables, often single quotes ('something') or double quotes ("something") are used. In bash scripting, using double quotes is safer.    
- Double quotes (" "): support variable expansion, i.e., any variable's value is also expanded in the string literal. e.g., "image$count" will be replaced with "image" followed by the value of $count.    
- Single quotes (' '): no variable expansion is done, i.e., 'string$count' stays as string$count.    

----

## Command Substitution   

Command substitution is accomplished using back-tick \`command\`:   
```
PWD=`pwd`
echo -e "PWD = $PWD \n"
```

Tip: Replace backtick syntax with $() for command substitution.    
```
PWD=$(pwd)
echo -e "PWD = $PWD \n"
```

----

## Reading input   

To read a value from stdin (standard input stream):
```
read var_name
```
To read a value with a message: 
```
read -p "Enter a number: " var_name 
```
To read a value without echoing it on the screen, like a password or passphrase: 
```
read -p "Enter password: " -s pass
```

----

## Bash builtin  

Bash built-in variables    
- `$0` : filename of the script being executed 
- `$1`, `$2`, `$3`, ... : 1st, 2nd, 3rd, ... argument of the script being executed
- `$#` : the number of arguments of the scripts
- `$?` : return status of the last command executed  
- `$$` : PID of current bash
- `$!` : PID of the last backgrounded command
- `$@` : command line arguments as an array
- `$*` : command line arguments as a string 
- `$-` : current shell options and flags (himBH)  

Bash built-in    
- compgen      <== good to list commands   
- cd 

Read `man bash` and `compgen` for builtins.    

Wild cards:   
- \*  :  any number of characters     
- ?  :  any one character    
-  \[]  : constrain search to defined characters    
- \[^ \]  : constrain search to exclude characters, not this will not work in a regex    

---- 

## Test expressions   

Okay, try one of the coolest commands on bash script built-ins:
```
man [
```
[Advanced]: ls -lrt /usr/bin/[ output will confirm it is a binary executable file.
The source is in the coreutils package, src/lbracket.c and src/test.c

[Bash Conditional Expressions](https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html)     
- [[ expression  ]] compound command    
- [ expression ] test command    
- (( expression )) evaluate and substitute the expression    


Check sample scripts added for more syntactic sugar.    

----

## Conditions    

Check [Shell Conditional Expressions](https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html)    
[Shell Arithmetic](https://www.gnu.org/software/bash/manual/html_node/Shell-Arithmetic.html)    

Sample conditions:    
```
# If no arguments are supplied to the script,
# send an error message and exit with an error code 
if [[ $# -eq 0 ]]; then
        echo "Insufficient arguments, quitting..."
        exit 255 
fi
```

With modern syntax, if conditional construct can be written as below:    
```
# If no arguments are supplied to the script,
# send an error message and exit with an error code 
if [[ $# -eq 0 ]]
  then
    echo "Insufficient arguments, quitting..."
    exit 255 
  fi
```

if conditional construct with an else part:   
```
# Check if the first argument to the script is a valid IFSC
# IFSC format is 4 alphabet letters (capitals), followed by a zero, and followed by 6 letters or digits
# input IFSC as argument
ifsc=$1

# create a regex pattern to match 
regexIFSC="^[A-Z]{4}0[A-Z0-9]{6}$";

if [[ $ifsc =~ $regexIFSC ]]; then
        echo "IFSC is valid"
else
        echo "IFSC is NOT valid"
fi
```

An else-if ladder   
```
if [ $# -eq 3 ]; then
        echo -e "Three arguments.\n"
elif [ $# -eq 2 ]; then
        echo -e "Two arguments.\n"
elif [ $# -eq 1 ]; then
        echo -e "One arguments.\n"
else 
        echo -e "number of arguments = $#"
fi
```

----

## Loops    

Repetitions or iterations can be managed with a loop construct.    

A `while` loop can be written as below:   
```
how_many=5
i=0
# read in a while loop
while [ $i -lt "$how_many" ]; do
        i=$((i + 1))
        #echo "enter number $i: "
        read -p "Enter number $i : " x
        echo $x 
done
```

A `for` loop can be written as below:   
```
for i in {a..t}; do
        filename="$i.txt" 
        echo $filename
done
```

```
for i in {5..50..5}; do
    echo "Welcome $i"
done 
```

----

## Case    

```
echo -n "Enter the name of an animal (cat, dog, horse, kangaroo, man, pypy) : "
read ANIMAL
echo -n "The $ANIMAL has "
case $ANIMAL in
        horse | dog | cat)
                echo -n "four"
        ;;
        man | kangaroo )
                echo -n "two"
        ;;
        *)
                echo -n "an unknown number of"
        ;;
esac
echo " legs."
```

---- 

## Help   

[Coding Convention](https://github.com/testssl/testssl.sh/blob/3.3dev/Coding_Convention.md) can help to write clean code.   

[Bash Scripting](https://linuxsimply.com/cheat-sheets/bash-scripting/)     

Check [Bash options](https://devhints.io/bash)    

Note: In shell scripting, some options may vary from one shell type to another and across versions installed and Linux distributions. Do not worry; practice and explore different options.    

[Bash cheatsheet](https://github.com/LeCoupa/awesome-cheatsheets/blob/master/languages/bash.sh)     

[Practice simple commands from RHCSA](https://github.com/soficx/rhcsa)     

----

## Sample scripts 

Under the bash directory, locate and play with a few sample scripts.    

---- 

## bash one liners    
Try [Bash one-liners](https://onceupon.github.io/Bash-Oneliner/) and [more](https://www.bashoneliners.com/oneliners/newest/) to see the expressiveness of bash scripting    

----

## Escape Sequence and Control Characters 

**Escape Sequences-1** - non-printable while spaces    
\a - alert bell sound    
\b - backspace (shift to right)    
\t - horizontal tab    
\n - newline    
\v - vertical tab    
\f - form feed (advance the feed)    
\r - carriage return (bring cursor to column1 or beginning of the line)     
e.g. 
```
$ echo -e "\aEureka!" 
Eureka!                     <== with alert bell sound 
$ echo -e "Okay\b\bEureka!" 
OkEureka!                   <== backspaces (shift) to right 
$ echo -e "\nEureka! \n" 
                            <== new line 
Eureka! 

$echo -e "\nEureka! \rJoe" 

Joeeka!                     <== carriage return like type writer
$ echo -e "\nEureka! \r\fJoe" 

Eureka! 
Joe                          <== (advance) form feed
$ echo -e "\n\t\tEureka! \n" 

		Eureka!              <== horizontal tab  

```

Print terminal characteristics:   <== Note control characters displayed    
```
$ stty -a
speed 38400 baud; rows 31; columns 132; line = 0;
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>; eol2 = <undef>; swtch = <undef>; start = ^Q; stop = ^S;
susp = ^Z; rprnt = ^R; werase = ^W; lnext = ^V; discard = ^O; min = 1; time = 0;
-parenb -parodd -cmspar cs8 -hupcl -cstopb cread -clocal -crtscts
-ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl -ixoff -tandem ixon -ixany -imaxbel iutf8
opost -olcuc -ocrnl onlcr -onocr -onlret -ofdel nl0 cr0 tab0 bs0 vt0 ff0
isig icanon iexten echo echoe echok -echonl -noflsh -tostop -echoprt echoctl echoke -flusho -extproc
```

Print all Bash keybindings:    
```
$ bind -p 

"\C-g": abort
"\C-x\C-g": abort
"\e\C-g": abort
"\C-j": accept-line
"\C-m": accept-line
# alias-expand-line (not bound)
# arrow-key-prefix (not bound)
# backward-byte (not bound)
"\C-b": backward-char
"\eOD": backward-char
"\e[D": backward-char
"\C-h": backward-delete-char
"\C-?": backward-delete-char
"\C-x\C-?": backward-kill-line
"\e\C-h": backward-kill-word
"\e\C-?": backward-kill-word
"\e\e[D": backward-word
"\e[1;3D": backward-word
"\e[1;5D": backward-word
"\e[5D": backward-word
"\eb": backward-word
# bash-vi-complete (not bound)
"\e<": beginning-of-history
"\C-a": beginning-of-line
"\eOH": beginning-of-line
"\e[1~": beginning-of-line
"\e[H": beginning-of-line
"\e[200~": bracketed-paste-begin
"\C-xe": call-last-kbd-macro
"\ec": capitalize-word
"\C-]": character-search
"\e\C-]": character-search-backward
"\e\C-l": clear-display
"\C-l": clear-screen
"\C-i": complete
"\e\e": complete
"\e!": complete-command
"\e/": complete-filename
"\e@": complete-hostname
"\e{": complete-into-braces
"\e~": complete-username
"\e$": complete-variable
# copy-backward-word (not bound)
# copy-forward-word (not bound)
# copy-region-as-kill (not bound)
# dabbrev-expand (not bound)
"\C-d": delete-char
"\e[3~": delete-char
# delete-char-or-list (not bound)
"\e\\": delete-horizontal-space
"\e-": digit-argument
"\e0": digit-argument
"\e1": digit-argument
"\e2": digit-argument
"\e3": digit-argument
"\e4": digit-argument
"\e5": digit-argument
"\e6": digit-argument
"\e7": digit-argument
"\e8": digit-argument
"\e9": digit-argument
"\C-x\C-v": display-shell-version
"\C-xA": do-lowercase-version
"\C-xB": do-lowercase-version
"\C-xC": do-lowercase-version
...
"\C-xX": do-lowercase-version
"\C-xY": do-lowercase-version
"\C-xZ": do-lowercase-version
"\eA": do-lowercase-version
"\eB": do-lowercase-version
"\eC": do-lowercase-version
...
"\eX": do-lowercase-version
"\eY": do-lowercase-version
"\eZ": do-lowercase-version
"\el": downcase-word
# dump-functions (not bound)
# dump-macros (not bound)
# dump-variables (not bound)
"\e\C-i": dynamic-complete-history
"\C-x\C-e": edit-and-execute-command
# emacs-editing-mode (not bound)
"\C-x)": end-kbd-macro
"\e>": end-of-history
"\C-e": end-of-line
"\eOF": end-of-line
"\e[4~": end-of-line
"\e[F": end-of-line
"\C-x\C-x": exchange-point-and-mark
"\ex": execute-named-command
# export-completions (not bound)
# fetch-history (not bound)
# forward-backward-delete-char (not bound)
# forward-byte (not bound)
"\C-f": forward-char
"\eOC": forward-char
"\e[C": forward-char
"\C-s": forward-search-history
"\e\e[C": forward-word
"\e[1;3C": forward-word
"\e[1;5C": forward-word
"\e[5C": forward-word
"\ef": forward-word
"\eg": glob-complete-word
"\C-x*": glob-expand-word
"\C-xg": glob-list-expansions
# history-and-alias-expand-line (not bound)
"\e^": history-expand-line
"\e[5~": history-search-backward
"\e[6~": history-search-forward
# history-substring-search-backward (not bound)
# history-substring-search-forward (not bound)
"\e#": insert-comment
"\e*": insert-completions
"\e.": insert-last-argument
"\e_": insert-last-argument
"\C-k": kill-line
# kill-region (not bound)
# kill-whole-line (not bound)
"\e[3;5~": kill-word
"\ed": kill-word
# magic-space (not bound)
# menu-complete (not bound)
# menu-complete-backward (not bound)
"\C-n": next-history
"\eOB": next-history
"\e[B": next-history
# next-screen-line (not bound)
"\en": non-incremental-forward-search-history
# non-incremental-forward-search-history-again (not bound)
"\ep": non-incremental-reverse-search-history
# non-incremental-reverse-search-history-again (not bound)
# old-menu-complete (not bound)
"\C-o": operate-and-get-next
# overwrite-mode (not bound)
"\C-x!": possible-command-completions
"\e=": possible-completions
"\e?": possible-completions
"\C-x/": possible-filename-completions
"\C-x@": possible-hostname-completions
"\C-x~": possible-username-completions
"\C-x$": possible-variable-completions
"\C-p": previous-history
"\eOA": previous-history
"\e[A": previous-history
# previous-screen-line (not bound)
# print-last-kbd-macro (not bound)
"\C-q": quoted-insert
"\C-v": quoted-insert
"\e[2~": quoted-insert
# redraw-current-line (not bound)
"\C-x\C-r": re-read-init-file
"\C-r": reverse-search-history
"\e\C-r": revert-line
"\er": revert-line
" ": self-insert
"!": self-insert
"\"": self-insert
"#": self-insert
"$": self-insert
"%": self-insert
"&": self-insert
"'": self-insert
"(": self-insert
")": self-insert
"*": self-insert
"+": self-insert
",": self-insert
"-": self-insert
".": self-insert
"/": self-insert
"0": self-insert
"1": self-insert
"2": self-insert
"3": self-insert
"4": self-insert
"5": self-insert
"6": self-insert
"7": self-insert
"8": self-insert
"9": self-insert
":": self-insert
";": self-insert
"<": self-insert
"=": self-insert
">": self-insert
"?": self-insert
"@": self-insert
"A": self-insert
"B": self-insert
"C": self-insert
...
"X": self-insert
"Y": self-insert
"Z": self-insert
"[": self-insert
"\\": self-insert
"]": self-insert
"^": self-insert
"_": self-insert
"`": self-insert
"a": self-insert
"b": self-insert
"c": self-insert
...
"x": self-insert
"y": self-insert
"z": self-insert
"{": self-insert
"|": self-insert
"}": self-insert
"~": self-insert
"\200": self-insert
"\201": self-insert
"\202": self-insert
... <== applicable keybindings 
"\375": self-insert
"\376": self-insert
"\377": self-insert
"\C-@": set-mark
"\e ": set-mark
# shell-backward-kill-word (not bound)
"\e\C-b": shell-backward-word
"\e\C-e": shell-expand-line
"\e\C-f": shell-forward-word
"\e\C-d": shell-kill-word
"\e\C-t": shell-transpose-words
# skip-csi-sequence (not bound)
"\C-xs": spell-correct-word
"\C-x(": start-kbd-macro
# tab-insert (not bound)
"\e&": tilde-expand
"\C-t": transpose-chars
"\et": transpose-words
# tty-status (not bound)
"\C-x\C-u": undo
"\C-_": undo
# universal-argument (not bound)
# unix-filename-rubout (not bound)
"\C-u": unix-line-discard
"\C-w": unix-word-rubout
"\eu": upcase-word
# vi-append-eol (not bound)
# vi-append-mode (not bound)
# vi-arg-digit (not bound)
# vi-back-to-indent (not bound)
# vi-backward-bigword (not bound)
# vi-backward-word (not bound)
# vi-bword (not bound)
# vi-bWord (not bound)
# vi-change-case (not bound)
# vi-change-char (not bound)
# vi-change-to (not bound)
# vi-char-search (not bound)
# vi-column (not bound)
# vi-complete (not bound)
# vi-delete (not bound)
# vi-delete-to (not bound)
# vi-edit-and-execute-command (not bound)
# vi-editing-mode (not bound)
# vi-end-bigword (not bound)
# vi-end-word (not bound)
# vi-eof-maybe (not bound)
# vi-eword (not bound)
# vi-eWord (not bound)
# vi-fetch-history (not bound)
# vi-first-print (not bound)
# vi-forward-bigword (not bound)
# vi-forward-word (not bound)
# vi-fword (not bound)
# vi-fWord (not bound)
# vi-goto-mark (not bound)
# vi-insert-beg (not bound)
# vi-insertion-mode (not bound)
# vi-match (not bound)
# vi-movement-mode (not bound)
# vi-next-word (not bound)
# vi-overstrike (not bound)
# vi-overstrike-delete (not bound)
# vi-prev-word (not bound)
# vi-put (not bound)
# vi-redo (not bound)
# vi-replace (not bound)
# vi-rubout (not bound)
# vi-search (not bound)
# vi-search-again (not bound)
# vi-set-mark (not bound)
# vi-subst (not bound)
# vi-tilde-expand (not bound)
# vi-undo (not bound)
# vi-unix-word-rubout (not bound)
# vi-yank-arg (not bound)
# vi-yank-pop (not bound)
# vi-yank-to (not bound)
"\C-y": yank
"\e.": yank-last-arg
"\e_": yank-last-arg
"\e\C-y": yank-nth-arg
"\ey": yank-pop
```
----
