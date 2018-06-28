#!/bin/bash

mstr_ip=$1
minion_ip=$2

sudo adduser nagios

sudo apt-get update
sudo apt-get install build-essential libgd2-xpm-dev openssl libssl-dev unzip

cd ~
curl -L -O http://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz
tar zxf nagios-plugins-*.tar.gz

cd nagios-plugins-*
./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl

make
sudo make install

cd ~
curl -L -O https://github.com/NagiosEnterprises/nrpe/releases/download/nrpe-3.2.1/nrpe-3.2.1.tar.gz
tar zxf nrpe-*.tar.gz

cd nrpe-*
./configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagios --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu

make all
sudo make install
sudo make install-config
sudo make install-init

read -rp 'Master ip: ' $mstr_ip
read -rp 'Minion ip: ' $minion_ip
sudo sed -i -e "s%allowed_hosts=127.0.0.1,::1%allowed_hosts=127.0.0.1,::1,$mstr_ip%g" /usr/local/nagios/etc/nrpe.cfg

sudo sed -i -e "s%#server_address=127.0.0.1%server_address=$minion_ip%g" /usr/local/nagios/etc/nrpe.cfg
sudo sed -i -e 's+command[check_hda1]=/usr/local/nagios/libexec/check_disk -w 20% -c 10% -p /dev/hda1+command[check_hda1]=/usr/local/nagios/libexec/check_disk -w 20% -c 10% -p /dev/sda1+g' /usr/local/nagios/etc/nrpe.cfg

sudo systemctl restart nrpe.service
