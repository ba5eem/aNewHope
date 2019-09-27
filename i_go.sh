#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

# start editing your bash script here
curl -O https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz &&
tar xvf go1.10.3.linux-amd64.tar.gz &&
sudo chown -R root:root ./go &&
sudo mv go /usr/local &&
echo 'export GOPATH=$HOME/work' >> ~/.profile &&
echo 'PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> ~/.profile &&
source ~/.profile &&
rm go1.10.3.linux-amd64.tar.gz &&
echo 'go: success'