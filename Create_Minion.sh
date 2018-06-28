#!/bin/bash

read -rp 'What is the Master_IP: ' mstr_ip

sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

sudo chmod 755 ~/Salty-Installer/Salt_Bash_intall.sh
sudo ~/Salty-Installer/Salt_Bash_intall.sh $mstr_ip

sudo chmod 755 ~/Salty-Installer/Minion_Nagios_Bash.sh
