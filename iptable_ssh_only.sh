#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

# iptable setup for ssh only access
# Details - ssh only
# You can change the ssh port here: /etc/ssh/sshd_config


# Flushing all rules
iptables -F
iptables -X

# Setting default filter policy
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Allow unlimited traffic on loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow incoming/outgoing ssh only on specified ports
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# setting while in this ip - setup to allow access to ssh to another ip as the only OUTPUT/INPUT option on this ip
iptables -A OUTPUT -p tcp -s $1/24 --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -s $1/24 --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# make sure nothing comes or goes out of this box other than ssh
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP