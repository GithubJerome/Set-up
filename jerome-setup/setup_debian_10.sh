#!/bin/bash

ANS="y yes Y YES"

apt-get install sudo;
sudo adduser --disabled-password --gecos '' jerome;
sudo usermod -aG sudo jerome;
sudo echo 'jerome ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers;
sudo sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config;

apt update;
apt install -y vim;
apt-get update;
apt-get install -y python3-pip python3-dev;

echo -n "use UTC time? [Y/n]:"
read VAR

for item in $ANS
do
  if [ $VAR == $item ]; then
    timedatectl set-timezone Etc/UTC;
  fi
done

sudo apt-get install -y nginx;
sudo apt-get install -y uwsgi-plugin-python3;
sudo apt-get install -y libpq-dev python3-dev;
sudo apt-get install -y uwsgi;
sudo apt-get install -y vim;
sudo apt-get install -y curl;
sudo apt-get install -y git;
sudo apt-get install -y openssh-server;
sudo apt-get install -y zip;
sudo apt-get install -y htop;
sudo apt-get install -y wget;


echo -n "Install mongoDB? [Y/n]:"
read VAR

for item in $ANS
do
  if [ $VAR == $item ]; then

    apt-get install gnupg;
    wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -;
    echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.4 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list;
    apt-get update;
    apt-get install -y mongodb-org=4.4.0 mongodb-org-server=4.4.0 mongodb-org-shell=4.4.0 mongodb-org-mongos=4.4.0 mongodb-org-tools=4.4.0;

    echo "mongodb-org hold" | sudo dpkg --set-selections;
    echo "mongodb-org-server hold" | sudo dpkg --set-selections;
    echo "mongodb-org-shell hold" | sudo dpkg --set-selections;
    echo "mongodb-org-mongos hold" | sudo dpkg --set-selections;
    echo "mongodb-org-tools hold" | sudo dpkg --set-selections;

    ps --no-headers -o comm 1;

    systemctl start mongod;

    systemctl enable mongod

  fi
done

echo -n "Install PostgreSQL? [Y/n]:"
read VAR

for item in $ANS
do
  if [ $VAR == $item ]; then

    sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt buster-pgdg main" > /etc/apt/sources.list.d/pgdg.list';
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -;
    apt-get update;
    apt-get -y install postgresql-12;

    sed -i  '/^local   all             postgres                                peer/ s/peer/trust/' /etc/postgresql/12/main/pg_hba.conf;
    su - postgres -c "psql -U postgres -d postgres -c \"alter user postgres with password 'trustno1';\"";
    sed -i  '/^local   all             postgres                                trust/ s/trust/md5/' /etc/postgresql/12/main/pg_hba.conf;

  fi
done

reboot;
