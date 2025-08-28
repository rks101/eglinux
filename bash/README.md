# Shell Scripting    

Shell Scripting offers a nice and robust way to automate system administration and daily tasks on Linux for both sysadmins and normal Linux users.     

To print something: 
```
echo -e "Starting script to print diagnostic information...\n"    
```

Command substitution:   
```
PWD=`pwd`
echo -e "PWD = $PWD \n"
```

To read value from stdin:
```
read var_name
```

Bash built-in variables    
- `$0` : filename of the script 
- `$#` : the number of arguments of the scripts
- `$1`, `$2`, `$3`, ... : 1st, 2nd, 3rd, ... argument of the script being executed
- `$?` : return status of the last command executed  
- `$$` : PID of current bash   

[Bash Conditional Expressions](https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html)     
- [[ expression  ]] compound command    
- [ expression ] test command    
- (( expression )) evaluate and substitute the expression    

[Bash Scripting](https://linuxsimply.com/cheat-sheets/bash-scripting/)     

Check [Bash options](https://devhints.io/bash)    

Try [Bash one-liners](https://onceupon.github.io/Bash-Oneliner/) and [more](https://www.bashoneliners.com/oneliners/newest/) to see the expressiveness of bash scripting    

Note: Some options may vary from shell to shell and across versions installed and distributions. Do not worry; explore different options.     

[Bash cheatsheet](https://github.com/LeCoupa/awesome-cheatsheets/blob/master/languages/bash.sh)     

[Practice simple commands from RHCSA](https://github.com/soficx/rhcsa)     

