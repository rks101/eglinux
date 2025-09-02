#!/usr/bin/bash

# This script requires one integer argument and 
# prints the sum of the digits up to the integer itself.     

max=$1
sum=0

if [ $# -lt 1 ]; then
        echo -e "\nOne integer argument required!\n"
        exit 255
fi

while [ $max -gt 0 ]; do
        echo "max = $max"
        sum=$((sum+max))
        max=$((max-1))
done

echo -e "\nsum = $sum"

exit 0
