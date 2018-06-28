#!/bin/bash

mstr_ipvar=$1
while_done=false
ready="n"



while [ !$while_done ]; do
    read -rp 'What do you wish to install? (Master/Minion): ' installvar
    if [ "$installvar" = "Master" ]; then
            curl -L https://bootstrap.saltstack.com -o install_salt.sh
            sudo sh install_salt.sh -M -U -A "$mstr_ipvar"
            sudo sh install_salt.sh -U -A "$mstr_ipvar"

            sudo mkdir /srv/salt
            sudo rm /srv/salt/*
            sudo mv ~/Salty-Installer/*.sls /srv/salt/

            while [ $ready = "n" ]; do
                for n in {4..1}; do
                        echo $n/2 minutes left
                        sudo salt-key --accept-all -y
                        sleep 30
                done
                sudo salt-key
                read -rp 'Are the keys accepted? (y/n): ' ready
            done
            while_done=true

    elif [ "$installvar" = "Minion" ]; then
            curl -L https://bootstrap.saltstack.com -o install_salt.sh
            sudo sh install_salt.sh -U -A "$mstr_ipvar"
            sudo mkdir /srv/salt
            sudo rm /srv/salt/*
            sudo mv ~/Salty-Installer/*.sls /srv/salt/
            while_done=true
    fi
done