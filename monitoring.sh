#!/bin/bash
arch_kernel=$(uname -a)
pcpu=$(nproc --all)
vcpu=$(cat /proc/cpuinfo | grep ^processor | wc -l)
free_ram=$(free --mega | grep Mem | awk '{printf "%s/%sMB (%.2f%%)", $3, $2, $3*100/$2}')
total=$(df -Bg | grep ^/dev/ | awk '{total+=$2 } END {printf "%dGb", total}')
used=$(df -Bm | grep ^/dev/ | awk '{used+=$3} END {printf "%d", used}')
percent=$(df -Bm | grep ^/dev/ | awk '{total+=$2}{used+=$3} END {printf "%.2f%%" , used*100/total}')
lv_count=$(lsblk | grep -c 'lvm')
lvm_status=$(awk -v count="$lv_count" 'BEGIN {if (count != 0) print "yes"; else print "no"}')
last_boot=$(who -b | awk '{print $3,$4}')
user_log=$(who -u | awk '{print $1}' | uniq| wc -l)
sudo_use=$(journalctl _COMM=sudo | grep -c COMMAND)
ip_addr=$(hostname -I)
mac_addr=$(ip addr | grep -E '.*link/ether' | awk '{print $2}')
cpu_load=$(iostat -c | grep -A 1 "idle" | grep "^ " | awk '{printf "%.2f%%\n", 100-$NF}')

echo "arch : $arch_kernel"
echo "vcpu : $vcpu"
echo "pcpu : $pcpu"
echo "free : $free_ram"
echo "lvm status : $lvm_status"
echo "lastboot : $last_boot"
echo "usetlog : $user_log"
echo "sudolog: $sudo_use"
echo "Ip4 : $ip_addr ($mac_addr)"
echo "cmd : $sudo_use"
echo "cpu load $cpu_load"
echo "used_disk $used/$total ($percent)"
echo "arch : $arch_kernel"
echo "vcpu : $vcpu"
echo "pcpu : $pcpu"
echo "free : $free_ram"
echo "lvm status : $lvm_status"
echo "lastboot : $last_boot"
echo "usetlog : $user_log"
echo "sudolog: $sudo_use"
echo "Ip4 : $ip_addr ($mac_addr)"
echo "cmd : $sudo_use"
echo "cpu load $cpu_load"
echo "used_disk $used/$total ($percent)"
