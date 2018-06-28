Syslog_Installer_Minion:
 pkg.installed:
 - pkgs:
   - syslog-ng
   - syslog-ng-core

copy sconfig_file_master:
 file.copy:
 - name: /etc/syslog-ng/syslog-ng.conf
 - source: /srv/salt/Minion/syslog-ng.conf
 - force: True

replace config_Master_Ip:
 file.replace:
 - name: /etc/syslog-ng/syslog-ng.conf
 - pattern: MASTER_IP
 - repl: {{ grains['master'] }}