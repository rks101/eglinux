#!/usr/bin/env bash

# Print information, and a few comparisons    
echo -e "\n\n"
echo "Starting the script..."

echo -e "User: $USER \n"
echo -e "Hostname: $HOSTNAME \n"
echo -e "Path: $PATH \n"
echo -e "Directories inside the path are:"
echo $PATH | tr ':' '\n'

echo -e "\n\n"
echo -e "Filename: $0"
echo -e "Number of arguments to this script = $#" 
#echo -e "Arguments are: $1 $2 $3"

if [ $# -eq 3 ]
  then
    echo -e "Three arguments.\n"
elif [ $# -eq 2 ]
  then
    echo -e "Two arguments.\n"
elif [ $# -eq 1 ] 
  then
    echo -e "One arguments.\n"
else
    echo -e "number of arguments = $#"
fi

echo -e "\n\n"

file1="SID.txt"
file2="abc.out"

if [ -e $file1 ]
  then 
    echo -e "$file1 exists."
  else 
    echo -e "$file1 does not exist."
    touch $file1 
    echo -e "empty $file1 is created."
fi 

if [ -e $file2 ]
  then 
    echo -e "$file2 exists."
  else 
    echo -e "$file2 does not exist."
    touch $file2
    echo -e "empty $file2 is created."
fi

echo -e "\n\n"

if [ $file1 -nt $file2 ]
  then
    echo -e "$file1 is newer than $file2"
else
    echo -e "$file2 is newer than $file1"
fi

echo -e "\n\n"

echo "Press any key followed by the enter key"
read key_value
echo "$key_value"

echo "Bye for now."
