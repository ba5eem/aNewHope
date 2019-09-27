#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

# start editing your bash script here
curl -s https://raw.githubusercontent.com/ba5eem/aNewBash/master/newuser.sh | bash -s $1 $2 && curl -s https://raw.githubusercontent.com/ba5eem/aNewBash/master/i_docker.sh | bash && curl -s https://raw.githubusercontent.com/ba5eem/aNewBash/master/i_dockercompose.sh | bash && curl -s https://raw.githubusercontent.com/ba5eem/aNewBash/master/i_go.sh | bash && curl -s https://raw.githubusercontent.com/ba5eem/aNewBash/master/i_nvm.sh | bash && curl -s https://raw.githubusercontent.com/ba5eem/aNewBash/master/add_docker_sudo.sh | bash
echo 'setup complete'

