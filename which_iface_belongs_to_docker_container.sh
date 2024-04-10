#!/bin/bash

export containers=$(sudo docker ps --format "{{.ID}}|{{.Names}}")
export interfaces=$(sudo ip ad);
for x in $containers
        do
                export name=$(echo "$x" |cut -d '|' -f 2);
                export id=$(echo "$x"|cut -d '|' -f 1)
                export ifaceNum="$(echo $(sudo docker exec -it "$id" cat /sys/class/net/eth0/iflink) | sed s/[^0-9]*//g):"
                export ifaceStr=$( echo "$interfaces" | grep $ifaceNum | cut -d ':' -f 2 | cut -d '@' -f 1);
                echo -e "$name: $ifaceStr";
done
