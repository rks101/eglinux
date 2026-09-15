#!/usr/bin/env bash

# Directory to create archive file for 
dir="logs"

# Double quotes around $dir and again around _`date`.tar.gz are important. 
arch_file="$dir""_`date +%d_%m_%Y_%H_%M_%S`.tar.gz"

echo $arch_file

# tar with -f for archive file and -z flag for .tar.gz (gzip compression) 
tar -zcvf $arch_file $dir
