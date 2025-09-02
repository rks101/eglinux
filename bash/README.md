# Shell Scripting    

* [bash](#bash)
  * [Intro](#intro)
  * [`echo`](#echo)
  * [Comamnd Substitution](#command-substitution)
  * [Reading input](#reading-input)
  * [Bash builtin](#bash-builtin)
  * [Test expressions](#test-expressions)
  * [Help](#help)
  * [bash one liners](#bash-one-liners)



## Intro 

Shell Scripting offers a nice and robust way to automate system administration and daily tasks on Linux for both sysadmins and normal Linux users.     

Find out the current bash executable from `which bash` and add that after #! in the first line of .sh file. Save and grant executable permissions to this sh file using chmod +x filename.sh   

```
#!/usr/bin/bash
echo "Hello! bash"
````
To run a bash script:     
./filename.sh  or    
bash filename.sh   

----

## echo  

To print something: 
```
echo -e "Starting script to print diagnostic information...\n"    
```

Note:     
"-e" flag allows escape sequence \n characters.    
"-n" flag omits the trailing newline character, that is continue printing.    

[bash grammar](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_10_02) for what characters need to be escaped or require quoting.   

----

## Command Substitution   

Command substitution:   
```
PWD=`pwd`
echo -e "PWD = $PWD \n"
```

----

## Reading input   

To read value from stdin:
```
read var_name
```

----

## Bash builtin  

Bash built-in variables    
- `$0` : filename of the script 
- `$#` : the number of arguments of the scripts
- `$1`, `$2`, `$3`, ... : 1st, 2nd, 3rd, ... argument of the script being executed
- `$?` : return status of the last command executed  
- `$$` : PID of current bash   

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

----

## Help   

[Bash Scripting](https://linuxsimply.com/cheat-sheets/bash-scripting/)     

Check [Bash options](https://devhints.io/bash)    

Note: Some options may vary from shell to shell and across versions installed and distributions. Do not worry; explore different options.     

[Bash cheatsheet](https://github.com/LeCoupa/awesome-cheatsheets/blob/master/languages/bash.sh)     

[Practice simple commands from RHCSA](https://github.com/soficx/rhcsa)     

----

## bash one liners    
Try [Bash one-liners](https://onceupon.github.io/Bash-Oneliner/) and [more](https://www.bashoneliners.com/oneliners/newest/) to see the expressiveness of bash scripting    

----
