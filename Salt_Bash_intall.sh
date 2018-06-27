#!/bin/bash

read -rp 'What do you wish to install? (Master/Minion):' installvar
read -rp 'What is the Master ip:' mstr_ipvar

if [ "$installvar" = "Master" ]; then
        curl -L https://bootstrap.saltstack.com -o install_salt.sh
        sudo sh install_salt.sh -M -U -A "$mstr_ipvar"
        for n in {10..1}; do
                echo $n/2 minutes left
                salt-key --accept-all -y
                sleep 30

        done

fi

if [ "$installvar" = "Minion" ]; then
        curl -L https://bootstrap.saltstack.com -o install_salt.sh
        sudo sh install_salt.sh -U -A "$mstr_ipvar"
fi
