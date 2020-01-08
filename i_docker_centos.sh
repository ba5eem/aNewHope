#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

NAME=${@?Error: no arguments given
please enter server ip as first argument:
bash install_docker.sh 138.197.204.210}

echo '#!/bin/bash
yum check-update
curl -fsSL https://get.docker.com/ | sh
systemctl start docker
systemctl enable docker
usermod -aG docker $(whoami)
exit
' > docker.sh && 

ssh root@$1 'bash -s' < docker.sh &&

echo 'docker installed ***************' &&

