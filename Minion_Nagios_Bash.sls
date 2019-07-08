replace master_ip:
 file.replace:
  - name: /usr/local/nagios/etc/nrpe.cfg
  - pattern: allowed_hosts=127.0.0.1,::1
  - repl: allowed_hosts=127.0.0.1,::1,{{ grains['master'] }}

replace minion_ip:  
 file.replace:
  - name: /usr/local/nagios/etc/nrpe.cfg
  - pattern: server_address=127.0.0.1
  - repl: server_address={{ grains['ip_interfaces']['eth0'][0] }}
  
replace disk:
 file.replace:
 - name: /usr/local/nagios/etc/nrpe.cfg
 - pattern: /dev/hda1
 - repl: /dev/sda1


 
