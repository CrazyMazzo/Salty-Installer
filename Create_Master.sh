#!/bin/bash

mstr_ip="$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"

sudo chmod 755 Salt_Bash_istall.sh
sudo ./Salt_Bash_intall $mstr_ip

sudo chmod 755 Nagios_install_bash.sh
sudo ./Nagios_install_bash.sh
sudo salt "58-UBU1604-SaltMaster" state.apply Minion_Nagios_Bash.sls

read -rp 'Is the Minion ready? (y/n): ' ready

while [ $ready = "n" ]; do
    sleep 30
    read -rp 'Is the Minion ready? (y/n): ' ready
done

read -rp 'What is the Name of the desired Minion: ' minion_name
read -rp 'What is the IP of the desired Minion: ' minion_ip


sudo chmod 755 Adding_Nagios_server.sh
sudo chmod 755 Add_Commands.sh

sudo ./Add_Commands.sh $minion_name $minion_ip








