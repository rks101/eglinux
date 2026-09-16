!/usr/bin/env bash

# Print information, and a few comparisons    

echo "Starting the script..."

echo -e "User: $USER \n"
echo -e "Hostname: $HOSTNAME \n"
echo -e "Path: $PATH \n"

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

file1="SID.txt"
file2="abc.out"

if [ -e $file1 ]
  then 
    echo -e "$file1 exists."
  else 
    echo -e "$file1 does not exist."
fi 

if [ -e $file2 ]
  then 
    echo -e "$file2 exists."
  else 
    echo -e "$file2 does not exist."
fi

if [ $file1 -nt $file2 ]
  then
    echo -e "$file1 is newer than $file2"
else
    echo -e "$file2 is newer than $file1"
fi

echo "Press any key "
read key_value
echo "$key_value"

echo "Bye for now."
