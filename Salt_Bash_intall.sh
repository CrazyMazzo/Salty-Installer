#!/bin/bash

read -rp 'What do you wish to install? (Master/Minion):' installvar
read -rp 'What is the Master ip:' mstr_ipvar

if [ "$installvar" = "Master" ]; then
        curl -L https://bootstrap.saltstack.com -o install_salt.sh
        sudo sh install_salt.sh -MAU $mstr_ipvar
        while true; do
                salt-key --accept-all
                sleep 30
        done

fi

if [ "$installvar" = "Minion" ]; then
        curl -L https://bootstrap.saltstack.com -o install_salt.sh
        sudo sh install_salt.sh -A "$mstr_ipvar"
fi
