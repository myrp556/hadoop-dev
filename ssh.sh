#! /bin/bash

source /root/.bash_profile
systemctl start vsftpd

ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -N ""
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
chmod +x ./auth.exp

./auth.exp hadoop1 root
./auth.exp hadoop2 root
./auth.exp hadoop3 root

