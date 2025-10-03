#!/usr/bin/bash

dir="logs"

arch_file="$dir""_`date +%d_%m_%Y_%H_%M_%S`.tar.gz"

echo $arch_file

tar -zcvf $arch_file $dir
