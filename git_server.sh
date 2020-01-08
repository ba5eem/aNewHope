#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

# start editing your bash script here

sudo apt install ruby-full -y
sudo apt install libcgi-session-perl -y
git instaweb --httpd=webrick

# for multiple git repos to be viewed
git init gui
cd gui
ln -s /path/to/repo.git .
ln -s ...etc
git instaweb --httpd=webrick

