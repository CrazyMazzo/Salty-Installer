run Minion_Nagios_Bash.sh:
 cmd:
 - run
 - name: /Salty-Installer/Minion_Nagios_Bash.sh {{ grains['master'] }} {{ grains['ip_interfaces']['eth0'][0] }}