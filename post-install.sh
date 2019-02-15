#!/bin/bash
#
# Post Deploy Script for a new Debian 9 box running on a VMware Host
#
# Enable root login ... yead I know ... ssshtd!
sed -i 's/#PermitRootLogin prohibit-password /PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart sshd

# Change GRUB options ...
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet" /GRUB_CMDLINE_LINUX_DEFAULT=""/' /etc/default/grub
update-grub

# Blacklist floppy ...
echo "blacklist floppy" | sudo tee /etc/modprobe.d/blacklist-floppy.conf
sudo rmmod floppy

# Blacklist SMBus
echo "blacklist i2c-piix4" | sudo tee /etc/modprobe.d/blacklist-smbus.conf

# Apply ...
sudo update-initramfs -u

# Necessary tools ...
apt-get install curl sudo build-essential linux-headers-$(uname -r) open-vm-tools software-properties-common apt-transport-https net-tools htop git

# Install Webmin
curl -s http://www.webmin.com/jcameron-key.asc | apt-key add -
echo "deb http://download.webmin.com/download/repository sarge contrib" | tee /etc/apt/sources.list.d/webmin.list
apt-get update && apt-get -y install webmin

# More to come ...
# soon? very soon?

