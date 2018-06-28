#!/bin/bash

read -rp 'What is the name of the host: ' minion_name
read -rp 'what is the ip address of the minion: ' ip_minion
if [ -f /usr/local/nagios/etc/servers/$minion_name.cfg ]; then
    read -rp 'File already exists, do you wish to replace it? (y,n)' bool
    if [ $bool="y" ]; then
        echo Replacing file
        sudo rm /usr/local/nagios/etc/servers/$minion_name.cfg
    else
        exit
    fi
fi
echo "define host {
        use                             linux-server
        host_name                       $minion_name
        alias                           minion1
        address                         $ip_minion
        max_check_attempts              5
        check_period                    24x7
        notification_interval           30
        notification_period             24x7
}

define service {
        use                             generic-service
        host_name                       $minion_name
        service_description             CPU load
        check_command                   check_nrpe!check_load
}


define service {
        use                             generic-service
        host_name                       $minion_name
        service_description             /dev/vda1 free space
        check_command                   check_nrpe!check_vda1
}" >> /usr/local/nagios/etc/servers/$minion_name.cfg

echo "Added /usr/local/nagios/etc/servers/$minion_name.cfg"