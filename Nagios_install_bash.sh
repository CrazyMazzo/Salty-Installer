#!/bin/bash

sudo apt-get update
sudo apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.0 libgd2-xpm-dev

cd /tmp || exit
wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.3.4.tar.gz
tar xzf nagioscore.tar.gz


cd /tmp/nagioscore-nagios-4.3.4/ || exit
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
sudo make all

sudo useradd nagios
sudo usermod -a -G nagios www-data

sudo make install

sudo make install-init
sudo update-rc.d nagios defaults

sudo make install-commandmode

sudo make install-config

sudo make install-webconf
sudo a2enmod rewrite
sudo a2enmod cgi


sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin


sudo systemctl restart apache2.service
sudo systemctl start nagios.service


sudo apt-get install -y autoconf gcc libc6 libmcrypt-dev make libssl-dev wget bc gawk dc build-essential snmp libnet-snmp-perl gettext

cd /tmp || exit
wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.2.1.tar.gz
tar zxf nagios-plugins.tar.gz

cd /tmp/nagios-plugins-release-2.2.1/ || exit
sudo ./tools/setup
sudo ./configure
sudo make
sudo make install

cd ~ || exit
curl -L -O https://github.com/NagiosEnterprises/nrpe/releases/download/nrpe-3.2.1/nrpe-3.2.1.tar.gz

tar zxf nrpe-*.tar.gz

cd nrpe-* || exit
./configure
make check_nrpe
sudo make install-plugin

sudo sed -i -e 's%#cfg_dir=/usr/local/nagios/etc/servers%cfg_dir=/usr/local/nagios/etc/servers%g' /usr/local/nagios/etc/nagios.cfg

sudo mkdir /usr/local/nagios/etc/servers

echo '

define command	{
    command_name check_nrpe
    command_line $USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
}' >> /usr/local/nagios/etc/objects/commands.cfg


