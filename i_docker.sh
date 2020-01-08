#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" &&
sudo apt update &&
apt-cache policy docker-ce &&
sudo apt install docker-ce -y &&
docker -v &&
echo 'docker: success'

