#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

# start editing your bash script here



if [ "$1" = "" ]; then
  echo "dont forget to pass a new hostname as argument"
  exit 0
else
  sudo hostnamectl set-hostname $1
  echo "127.0.0.1 $1" | sudo tee -a /etc/hosts
  sed -i '/preserve_hostname:/d' /etc/cloud/cloud.cfg
  echo "preserve_hostname: true" | sudo tee -a /etc/cloud/cloud.cfg
  hostnamectl | grep $1
  sudo reboot
fi

