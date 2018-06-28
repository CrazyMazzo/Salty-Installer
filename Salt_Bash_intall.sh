#!/bin/bash

mstr_ipvar=$1
while_working=true
ready="n"



while [ $while_working ]; do
    read -rp 'What do you wish to install? (Master/Minion): ' installvar
    if [ "$installvar" = "Master" ]; then
            curl -L https://bootstrap.saltstack.com -o install_salt.sh
            sudo sh install_salt.sh -M -U -A "$mstr_ipvar"
            sudo sh install_salt.sh -U -A "$mstr_ipvar"

            sudo mkdir /srv/salt
            sudo rm /srv/salt/*
            sudo mv ~/Salty-Installer/*.sls /srv/salt/
            echo "hi"
            while [ $ready = "n" ]; do
            echo "bye"
                for n in {4..1}; do
                        echo $n/2 minutes left
                        sudo salt-key --accept-all -y
                        sleep 30
                done
                sudo salt-key
                read -rp 'Are the keys accepted? (y/n): ' ready
            done
            while_working=false

    elif [ "$installvar" = "Minion" ]; then
            curl -L https://bootstrap.saltstack.com -o install_salt.sh
            sudo sh install_salt.sh -U -A "$mstr_ipvar"
            sudo mkdir /srv/salt
            sudo rm /srv/salt/*
            sudo mv ~/Salty-Installer/*.sls /srv/salt/
            while_done=false
    fi
done

echo "Salt Installer done!!"