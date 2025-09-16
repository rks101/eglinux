# Shell Scripting    

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



## Intro 

Shell Scripting offers a nice and robust way to automate system administration and daily tasks on Linux for both sysadmins and normal Linux users.     

Find out the current bash executable from `which bash` and add that after #! in the first line of .sh file. Save and grant executable permissions to this sh file using chmod +x filename.sh   

```
#!/usr/bin/bash
echo "Hello! bash"
````
To run or execute a bash script:     
`./filename.sh`  or  `bash filename.sh`    
Read about the script and see if it requires any arguments or things to be set up before its execution.     

Test the following:    
- echo $SHELL 
- cat /etc/shells 
- which bash 

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
- compgen 
- cd 

Read `man bash` and `compgen` for builtins.    

Wild cards:   
- \*  :  any number of characters     
- ?  :  any one character    
- \[ ]  : constrain search to defined characters
- \[! \]  : constrain search to exclude characters, not this will not work in a regex    

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

[Bash Scripting](https://linuxsimply.com/cheat-sheets/bash-scripting/)     

Check [Bash options](https://devhints.io/bash)    

Note: Some options may vary from shell to shell and across versions installed and distributions. Do not worry; explore different options.     

[Bash cheatsheet](https://github.com/LeCoupa/awesome-cheatsheets/blob/master/languages/bash.sh)     

[Practice simple commands from RHCSA](https://github.com/soficx/rhcsa)     

----

## Sample scripts 

Under the bash directory, locate and play with a few sample scripts.    

---- 

## bash one liners    
Try [Bash one-liners](https://onceupon.github.io/Bash-Oneliner/) and [more](https://www.bashoneliners.com/oneliners/newest/) to see the expressiveness of bash scripting    

----
