#!/usr/bin/bash

# echo numbers entered
how_many=0

echo -e "\nI can echo numbers back to you. How many numbers:\t"
read how_many

echo -e "you said $how_many \n"

if [[ $how_many -le 0 ]]; then
        echo -e "\nEnter a positive number.\n"
        exit 255
fi

i=0

# read in a while loop
while [ $i -lt "$how_many" ]; do
        i=$((i + 1))
        #echo "enter number $i: "
        read -p "Enter number $i : " x
        echo $x
done

i=0
sum=0
nums=0

# Okay, let's sum the first n numbers
echo -e "\nLet's sum the first n integers. How many? "
read nums

# sum using for loop and expression 
for (( i = 1; i <= $nums; i++ )); do
        sum=$((sum + i))
done

echo -e "\nSum of first $nums integers is $sum \n"
