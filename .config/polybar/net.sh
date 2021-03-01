#!/bin/bash

#!/bin/bash

print_bytes() {
    if [ "$1" -eq 0 ] || [ "$1" -lt 1000 ]; then
        bytes="0 kBs"
    elif [ "$1" -lt 1000000 ]; then
        bytes="$(echo "scale=0;$1/1000" | bc -l ) kBs"
    else
        bytes="$(echo "scale=1;$1/1000000" | bc -l ) MBs"
    fi

    echo "$bytes"
}

print_bit() {
    if [ "$1" -eq 0 ] || [ "$1" -lt 10 ]; then
        bit="0 B"
    elif [ "$1" -lt 100 ]; then
        bit="$(echo "scale=0;$1*8" | bc -l ) B"
    elif [ "$1" -lt 100000 ]; then
        bit="$(echo "scale=0;$1*8/1000" | bc -l ) K"
    else
        bit="$(echo "scale=1;$1*8/1000000" | bc -l ) M"
    fi

    echo "$bit"
}

INTERVAL=3
INTERFACES="enp34s0"

declare -A bytes

for interface in $INTERFACES; do
    bytes[past_$1_$interface]="$(cat /sys/class/net/"$interface"/statistics/$1_bytes)"
done

while true; do
    count=0

    for interface in $INTERFACES; do
        bytes[now_$1_$interface]="$(cat /sys/class/net/"$interface"/statistics/$1_bytes)"

        bytes_count=$((((${bytes[now_$1_$interface]} - ${bytes[past_$1_$interface]})) / INTERVAL))

        count=$(((( "$count" + "$bytes_count" ))))

        bytes[past_$1_$interface]=${bytes[now_$1_$interface]}
    done

    echo "$(print_bytes $count)"

    sleep $INTERVAL
done
