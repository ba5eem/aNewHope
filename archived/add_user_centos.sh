#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

echo '#!/bin/bash
adduser '$1' -p '$2'
gpasswd -a '$1' wheel
cp -R ~/.ssh /home/'$1'/
chown -R '$1':'$1' /home/'$1'/.ssh/
exit
' > makeuser.sh && 

ssh root@$3 'bash -s' < makeuser.sh &&

echo 'user created ***************' &&

rm makeuser.sh &&

ssh $1@$3
