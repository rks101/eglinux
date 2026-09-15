#!/usr/bin/env bash

echo -e "options: $-"

echo -e "Name should be encapsulated inside double quotes, otherwise"
echo -e "only the first word is picked up and the rest is ignored."
echo -e "Name contains up to three words having first letter in capital"
echo -e "case, followed by small letters, if any. Valid input has only A-Z, a-z,"
echo -e "or a space if name has more than one word.\n"

echo -e "Try executing this script using the following cases:\n \
        ./checkNames.sh  \n \
        ./checkNames.sh \"Raj\" \n \
        ./checkNames.sh \"R\" \n \
        ./checkNames.sh \"Raj Kumar\" \n \
        ./checkNames.sh \"R K\" \n \
        ./checkNames.sh \"Raj Kumar Solulu\" \n \
        ./checkNames.sh \"R K S\" \n \
        ./checkNames.sh \" K S \" \n"

name=$1
echo $name

# \s is for one space after a word 
regexName="^[A-Z][a-z]*(\\s[A-Z][a-z]*){0,2}$";

if [[ $name =~ $regexName ]]; then
        echo "Name is valid"
else
        echo "Name is NOT valid"
fi
