#!/bin/bash

arch_kernel=$(uname -a)
pcpu=$(grep 'physical id' /proc/cpuinfo | uniq | wc -l)
vcpu=$(nproc)
free_ram=$(free --mega | grep Mem | awk '{printf "%s/%sMB (%.2f%%)", $3, $2, $3*100/$2}')
total=$(df --total -h | grep total | awk '{printf "%sb" , $2 }')
used=$(df --total -BM | grep total | awk '{printf "%d", $3}')
percent=$(df --total -h | grep total | awk '{print $5}')
lv_count=$(lsblk | grep 'lvm' | wc -l)
lvm_status=$(if [ $lv_count -gt 0 ]; then echo yes ; else echo no ; fi)
last_boot=$(who -b | awk '{print $3,$4}')
user_log=$(who -u | awk '{print $1}' | uniq | wc -l)
sudo_use=$(journalctl _COMM=sudo | grep -c COMMAND)
ip_addr=$(hostname -I)
mac_addr=$(ip addr | grep -E '.*link/ether' | awk '{print $2}')
conections_tcp=$(netstat | grep tcp | grep ESTABLISHED | uniq | wc -l)
cpu_load=$(mpstat | grep all | awk '{printf "%.2f%%", 100-$NF}')

wall "
 -----------------------------------------------------
 #Architecture: $arch_kernel
 #CPU physical : $pcpu
 #vCPU : $vcpu
 #Memory Usage: $free_ram
 #Disk Usage: $used/$total ($percent)
 #CPU load: $cpu_load
 #Last boot: $last_boot
 #LVM use: $lvm_status
 #Connections TCP : $conections_tcp ESTABLISHED
 #User log: $user_log
 #Network: $ip_addr ($mac_addr)
 #Sudo : $sudo_use cmd
 -----------------------------------------------------
"
