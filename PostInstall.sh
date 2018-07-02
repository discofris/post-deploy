#!/bin/bash
# Change SSHd ..
sed -i 's/#PermitRootLogin prohibit-password /PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart sshd

# Change grub ...
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet" /GRUB_CMDLINE_LINUX_DEFAULT=""/' /etc/default/grub
update-grub

# Disable floppy
echo "blacklist floppy" | sudo tee /etc/modprobe.d/blacklist-floppy.conf
sudo rmmod floppy
sudo update-initramfs -u

# Necessary tools ...
apt-get install curl sudo build-essential linux-headers-$(uname -r) open-vm-tools software-properties-common apt-transport-https net-tools htop git

# Install Webmin
curl -s http://www.webmin.com/jcameron-key.asc | apt-key add -
echo "deb http://download.webmin.com/download/repository sarge contrib" | tee /etc/apt/sources.list.d/webmin.list
apt-get update && apt-get -y install webmin

