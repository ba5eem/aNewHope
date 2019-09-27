#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

# start editing your bash script here
curl -s https://raw.githubusercontent.com/ba5eem/aNewBash/master/newuser.sh | bash -s $1 $2
