#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

# $1 = domain name example.com
# $2 = ip address
# $3 = alias


doctl compute domain records create $1 --record-data `$2` --record-name `$3` --record-port 0 --record-priority 0 --record-ttl 3600 --record-type 'A' --record-weight 0