#!/bin/bash

mstr_ip=$1
minion_ip=$2

sudo adduser nagios

sudo apt-get update
#sudo apt-get install build-essential libgd2-xpm-dev openssl libssl-dev unzip
sudo apt-get install -y autoconf gcc libc6 libmcrypt-dev make libssl-dev wget bc gawk dc build-essential snmp libnet-snmp-perl gettext

cd ~
curl -L -O http://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz
tar zxf nagios-plugins-*.tar.gz

cd nagios-plugins-2.2.1
./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl

make
sudo make install

cd ~
curl -L -O https://github.com/NagiosEnterprises/nrpe/releases/download/nrpe-3.2.1/nrpe-3.2.1.tar.gz
tar zxf nrpe-*.tar.gz

cd nrpe-3.2.1
./configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagios --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu

make all
sudo make install
sudo make install-config
sudo make install-init

#sudo sed -i -e "s%allowed_hosts=127.0.0.1,::1%allowed_hosts=127.0.0.1,::1,$mstr_ip%g" /usr/local/nagios/etc/nrpe.cfg

#sudo sed -i -e "s%#server_address=127.0.0.1%server_address=$minion_ip%g" /usr/local/nagios/etc/nrpe.cfg
sudo sed -i -e 's+command[check_hda1]=/usr/local/nagios/libexec/check_disk -w 20% -c 10% -p /dev/hda1+command[check_hda1]=/usr/local/nagios/libexec/check_disk -w 20% -c 10% -p /dev/sda1+g' /usr/local/nagios/etc/nrpe.cfg


