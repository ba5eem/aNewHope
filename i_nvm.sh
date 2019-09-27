#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

# start editing your bash script here
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash &&
source ~/.bashrc &&
nvm install 8
echo 'nvm: success'
