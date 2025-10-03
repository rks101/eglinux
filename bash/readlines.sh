#!/usr/bin/bash

file=$1

while read -r line; do
        echo -e "$line"

done <$file
