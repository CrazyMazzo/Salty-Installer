#!/bin/bash

mstr_ipvar=$1
ready="n"

sudo mkdir /srv/salt
sudo mkdir /srv/salt/Master
sudo mkdir /srv/salt/Minion
        sudo rm /srv/salt/*
        sudo rm /srv/salt/Master/*
        sudo rm /srv/salt/Minion/*
        sudo cp ~/Salty-Installer/*.sls /srv/salt/
        sudo cp ~/Salty-Installer/Master/* /srv/salt/Master/
        sudo cp ~/Salty-Installer/Minion/* /srv/salt/Minion/


read -rp 'What do you wish to install? (Master/Minion): ' installvar
if [ "$installvar" = "Master" ]; then
        curl -L https://bootstrap.saltstack.com -o install_salt.sh
        sudo sh install_salt.sh -M -U -A "$mstr_ipvar"
        sudo sh install_salt.sh -U -A "$mstr_ipvar"


        
        sudo systemctl restart salt-minion


        while [ $ready = "n" ]; do
            sudo salt-key --accept-all -y
            sudo salt-key
            read -rp 'Are the keys accepted? (y/n): ' ready
            echo "Waiting 10 seconds"
            sleep 10
        done

elif [ "$installvar" = "Minion" ]; then
        curl -L https://bootstrap.saltstack.com -o install_salt.sh
        sudo sh install_salt.sh -A "$mstr_ipvar"
        
        sudo systemctl restart salt-minion
fi


echo "Salt Installer done!!"
