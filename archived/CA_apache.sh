#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT


NAME=${@?Error: no arguments given
include the following: example.com www.example.com}

echo '#!/bin/bash
yum install -y epel-release
yum install -y certbot python2-certbot-apache mod_ssl
certbot --apache --non-interactive --agree-tos -m webmaster@'$1' -d '$1' -d '$2'
' > https.sh && 

cat https.sh
read -p "Does the script look correct? [y|n]" answer
    if [[ $answer = y ]] ; then
      echo Enter in the server ip address?
      read address
      ssh root@$address 'bash -s' < https.sh
    else
      rm firewall.sh
      echo lets start over again...
      echo goodbye
      exit
    fi


