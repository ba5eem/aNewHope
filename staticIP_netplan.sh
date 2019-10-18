#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

GATEWAY=`route -n | grep 'UG[ \t]' | awk '{print $2}'`
ETHNUM=`route -n | grep 'UG[ \t]' | awk '{print $8}'`

if [ "$1" = "" ]; then
  echo "dont forget to pass ip address you want as static ip"
  exit 0
else
  sudo echo "
  network:
      ethernets:
          $ETHNUM:
              addresses:
              - $1/24
              gateway4: $GATEWAY
              nameservers:
                  addresses:
                  - 8.8.8.8
      version: 2" > /etc/netplan/*.yaml

  sudo reboot
fi