#!/bin/bash

minion_name=$1
minion_ip=$2


sudo ./Adding_Nagios_server.sh $minion_name $minion_ip

sudo salt "$minion_name" state.apply -t 60 Minion_Nagios_Bash
sudo salt "$minion_name" cmd.run 'sudo systemctl restart nrpe.service'

sudo salt "$minion_name" state.apply -t 60 Minion_Syslog_Installer
sudo salt "$minion_name" cmd.run 'sudo systemctl restart syslog-ng'

