#!/bin/bash

#sbuser="jerome"
#sbpass="jerome"

. ./config.cfg

apt-get -y install libcups2 samba samba-common cups;
mv /etc/samba/smb.conf /etc/samba/smb.conf.bak;

mkdir -p /home/shares/allusers
chown -R root:users /home/shares/allusers/
chmod -R ug+rwx,o+rx-w /home/shares/allusers/
mkdir -p /home/shares/anonymous
chown -R root:users /home/shares/anonymous/
chmod -R ug+rwx,o+rx-w /home/shares/anonymous/

echo -e "$sbpass\n$sbpass" | smbpasswd -a $sbuser;
systemctl restart smbd.service;

reboot;