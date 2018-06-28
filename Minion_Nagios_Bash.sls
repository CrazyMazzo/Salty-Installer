run Minion_Nagios_Bash:
 cmd:
 - run
 - name: /Salty-Installer/Minion_Nagios_Bash {{ grains['master'] }} {{ grains['ip_interfaces']['eth0'][0] }}