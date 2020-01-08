#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT


NAME=${@?Error: no arguments given
Please enter domain alias name: example.com
Please enter user name: name
Please enter server IP address: 123.456.78.09}


echo '#!/bin/bash
yum update httpd
yum install -y httpd
systemctl start httpd
mkdir -p /var/www/'$1'/html
mkdir -p /var/www/'$1'/log
chown -R '$2':'$2' /var/www/'$1'/html
chmod -R 755 /var/www
echo "Website Temp" > /var/www/'$1'/html/index.html
mkdir /etc/httpd/sites-available /etc/httpd/sites-enabled
echo "IncludeOptional sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf
echo "
<VirtualHost *:80>
    ServerName www.'$1'
    ServerAlias '$1'
    DocumentRoot /var/www/'$1'/html
    ErrorLog /var/www/'$1'/log/error.log
    CustomLog /var/www/'$1'/log/requests.log combined
</VirtualHost>

<VirtualHost *:443>
    ServerName www.'$1'
    ServerAlias '$1'
    DocumentRoot /var/www/'$1'/html
    ErrorLog /var/www/'$1'/log/error.log
    CustomLog /var/www/'$1'/log/requests.log combined
</VirtualHost>
" > /etc/httpd/sites-available/'$1'.conf
ln -s /etc/httpd/sites-available/'$1'.conf /etc/httpd/sites-enabled/'$1'.conf
setsebool -P httpd_unified 1
ls -dZ /var/www/'$1'/log/
semanage fcontext -a -t httpd_log_t "/var/www/'$1'/log(/.*)?"
restorecon -R -v /var/www/'$1'/log
ls -dZ /var/www/'$1'/log/
systemctl restart httpd
' > httpd.sh


cat httpd.sh
read -p "Does the script look correct? [y|n]" answer
    if [[ $answer = y ]] ; then
      ssh root@$3 'bash -s' < httpd.sh
    else
      rm httpd.sh
      echo lets start over again...
      echo goodbye
      exit
    fi



