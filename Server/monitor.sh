#!/bin/bash

# CPU 사용량 검사
cpu=$(top -b -n 1 | grep "^%Cpu" | awk '{print $2 + $4}')
echo "CPU 사용량: $cpu%"

# Memory 사용량 검사
mem=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')
echo "Memory 사용량: $mem"

# Disk 사용량 검사
disk=$(df -h / | awk '{print $5}' | tail -1)
echo "Disk 사용량: $disk"