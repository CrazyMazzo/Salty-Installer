run Minion_Nagios_Bash:
 cmd:
 - run
 - name: ~/Salty-Installer/Minion_Nagios_Bash.sh
 
replace master_ip
 file.replace:
  - name: /usr/local/nagios/etc/nrpe.cfg
  - pattern: allowed_hosts=127.0.0.1,::1
  - repl: allowed_hosts=127.0.0.1,::1,{{ grains['master'] }}

replace minion_ip
 file.replace:
  - name: /usr/local/nagios/etc/nrpe.cfg
  - pattern: server_address=127.0.0.1
  - repl: server_address={{ grains['ip_interfaces']['eth0'][0] }}


 