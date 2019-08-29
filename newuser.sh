#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

# start editing your bash script here
sudo useradd -m -p $(openssl passwd -1 $2) $1 -s /bin/bash
echo .........
sudo mkdir /home/$1/.ssh
sudo touch /home/$1/.ssh/authorized_keys
sudo chown -R $1:$1 /home/$1/.ssh
sudo usermod -aG sudo $1
sudo chage -d 0 $1
echo Username is: $1
echo User created your default password is: $2
echo you will be required to change the password on first login
echo script complete - Aloha!