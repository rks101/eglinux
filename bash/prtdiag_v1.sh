#!/usr/bin/bash

echo "--------------------------------------------------------------------------------"
date
echo "--------------------------------------------------------------------------------"
echo "Starting System Diagnostics..."
echo "User: $USER at $HOSTNAME started the script"
echo "--------------------------------------------------------------------------------"
os_info=`lsb_release -a`
echo "System OS: $os_info"
echo "--------------------------------------------------------------------------------"
kernel_ver=`uname -a`
echo "Kernel version: $kernel_ver"
echo "--------------------------------------------------------------------------------"
mem_total=`cat /proc/meminfo | grep -i MemTotal`
echo "Memory Total: $mem_total"
echo "--------------------------------------------------------------------------------"
mem_available=`cat /proc/meminfo | grep -i MemAvailable`
echo "Memory available: $mem_available"
echo "--------------------------------------------------------------------------------"

echo "Environment variables:"
env_vars=`printenv`
echo "$env_vars"
echo "--------------------------------------------------------------------------------"

sleep 10
echo "Done finally"

sleep 10
echo "Done finally"
