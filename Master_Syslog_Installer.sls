Syslog_Installer_Master:
 pkg.installed:
  - pkgs:
   - syslog-ng-core
   - syslog-ng

 copy config_file_master
  file.copy:
   - name: /etc/syslog-ng/syslog-ng.conf
   - source: ~/Salty-Installer/Master/syslog-ng.conf
   - force: True