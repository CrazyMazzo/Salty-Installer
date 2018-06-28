#!/bin/bash

mstr_ipvar=$1
ready="n"




read -rp 'What do you wish to install? (Master/Minion): ' installvar
if [ "$installvar" = "Master" ]; then
        curl -L https://bootstrap.saltstack.com -o install_salt.sh
        sudo sh install_salt.sh -M -U -A "$mstr_ipvar"
        echo "Install Minion"
        sudo sh install_salt.sh -U -A "$mstr_ipvar"

        sudo mkdir /srv/salt
        sudo rm /srv/salt/*
        sudo mv ~/Salty-Installer/*.sls /srv/salt/
        echo "hi"
        while [ $ready = "n" ]; do
        echo "bye"
            sudo salt-key --accept-all -y
            sudo salt-key
            read -rp 'Are the keys accepted? (y/n): ' ready
            echo "Waiting 10 seconds"
            sleep 10
        done

elif [ "$installvar" = "Minion" ]; then
        curl -L https://bootstrap.saltstack.com -o install_salt.sh
        sudo sh install_salt.sh -U -A "$mstr_ipvar"
        sudo mkdir /srv/salt
        sudo rm /srv/salt/*
        sudo mv ~/Salty-Installer/*.sls /srv/salt/
fi


echo "Salt Installer done!!"