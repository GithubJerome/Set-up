# Setup for debian 10

## Installation
```bash
# Switch to root user first

apt-get install -y git
# or
sudo apt-get install git

# Add ssh keys on bitbucket/git

	# To get new pub key
	ssh-keygen -t rsa

# Clone this repo

cd setup10

# Change setup_debian_10.sh -> POSTGRES PASSWORD 

bash setup_debian_10.sh
# or
sudo bash setup_debian_10.sh

# ------------------- FOR SUMBA INSTALLATION (OPTIONAL) ------------------- #

# Change set_up_samba.sh -> SAMBA USER sbuser 
# Change set_up_samba.sh -> SAMBA PASSWORD sbpass 
# Change smb.conf [share] -> path
# Change smb.conf [share] -> valid users


bash set_up_samba.sh
# or
sudo bash set_up_samba.sh

# COPY smb.conf TO /etc/samba/smb.conf
# cp smb.conf /etc/samba/smb.conf
# CHANGE SAMBA PASSWORD
# smbpasswd -a <username>
# RESTART SAMBA
# systemctl restart smbd.service

# ------------------- FOR STATIC IP (OPTIONAL) ------------------- #

# CHANGE interfaces -> 192.168.1.88 to <any ip you want>
mv /etc/network/interfaces /etc/network/interfaces.backup
cp interfaces /etc/network/interfaces
reboot
```