#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

# start editing your bash script here
# adding docker to sudo group
sudo usermod -aG docker ${USER} &&
echo " add docker to user after script"
