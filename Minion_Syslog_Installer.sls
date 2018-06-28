Syslog_Installer_Master:
 pkg.installed:
  - pkgs:
   - syslog-ng-core
   - syslog-ng

 copy config_file_master
  file.copy:
   - name: /etc/syslog-ng/syslog-ng.conf
   - source: ~/Salty-Installer/Minion/syslog-ng.conf
   - force: True

 replace config_Master_Ip
  file.replace:
   - name: /etc/syslog-ng/syslog-ng.conf
   - pattern: MASTER_IP
   - repl: {{ grains['master'] }}