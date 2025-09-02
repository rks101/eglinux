#!/usr/bin/bash

echo -e "\nLet us create a number sequence. Up to how many?\n"
read how_many

list=`seq 1 $how_many`

echo $list

echo -e "\nLet us create a character sequence. Filenames from a.txt to t.txt\n"

for i in {a..t}; do
        filename="$i.txt"
        echo $filename
done

# Downloads directory contains several WhatsApp*.jpg files.
# Rename them to a filename without special characters in it.

