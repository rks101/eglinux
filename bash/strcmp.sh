#!/usr/bin/bash

# This script performs a few checks on two strings supplied as arguments.
# Modify and try out a few simple things around strings.
# run as below: 
# ./strcmp.sh 
# ./strcmp.sh Hello Hello 
# ./strcmp.sh Hello Yello 
# ./strcmp.sh Xello Yello 

# Once upon a time, not long ago, there were two strings
str1=$1
str2=$2

# check arguments
if [ $# -ne 2 ]; then
        echo -e "\nIn-sufficient arguments!\n"
        echo -e "Usage: $0 argument1 argument2\n"
        exit 255
else
        echo -e "\nYou entered string1 = $str1, string2 = $str2\n"
fi

# check if any of the strings are empty
if [ -z $str1 ]; then
        echo -e "string1 is empty, leaving...\n"
        exit 254
elif [ -z $str2 ]; then
        echo -e "string2 is empty, leaving...\n"
        exit 254
else
        echo -e "Happy that both strings are not empty. This is not a trick!\n"
fi

# check if strings are the same
if [ $str1 == $str2  ]; then
        echo -e "\nBoth strings are same\n"
else
        echo -e "\nBoth strings are NOT same\n"
fi

# check which comes first lexicographically / in dictionary order
if [[ $str1 < $str2 ]]; then
        echo -e "\n$str1 comes first lexicographically / in dictionary order\n"
elif [[ $str2 < $str1 ]]; then
        echo -e "\n$str2 comes first lexicographically / in dictionary order\n"
else
        echo -e "\nI told you both strings are the same!\n"
fi

echo -e "That's all for now!\n"
