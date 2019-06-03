run Minion_Nagios_Bash:
 cmd:
 - run
 - name: /srv/scripts/Minion_Nagios_Bash.sh
 
replace allowed_hosts:
 file.replace:
 - name: /usr/local/nagios/etc/nrpe.cfg
 - pattern: allowed_hosts=127.0.0.1,::1
 - repl: allowed_hosts=127.0.0.1,::1,{{ grains['master'] }}

replace disk:
 file.replace:
 - name: /usr/local/nagios/etc/nrpe.cfg
 - pattern: /dev/hda1
 - repl: /dev/sda1

replace server_address:
 file.replace:
 - name: /usr/local/nagios/etc/nrpe.cfg
 - pattern: #server_address=127.0.0.1
 - repl: server_address={{ grains['ip_interfaces']['eth0'][0] }}


 
