#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT


NAME=${@?Error: no arguments given
when running script include what firewall services you would like as individual arguments
for example
bash setup_firewall.sh ssh http https}


echo '#!/bin/bash
yum install -y firewalld
systemctl start firewalld
' > firewall.sh


for var in "$@"
do 
    echo "firewall-cmd --permanent --add-service=$var" >> firewall.sh
done

echo '
firewall-cmd --reload
systemctl enable firewalld
' >> firewall.sh

cat firewall.sh
read -p "Does the script look correct? [y|n]" answer
    if [[ $answer = y ]] ; then
      echo Enter in the server ip address?
      read address
      ssh root@$address 'bash -s' < firewall.sh
    else
      rm firewall.sh
      echo lets start over again...
      echo goodbye
      exit
    fi



