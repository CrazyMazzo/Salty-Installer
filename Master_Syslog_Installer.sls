Syslog_Installer_Master:
 pkg.installed:
 - pkgs:
   - syslog-ng
   - syslog-ng-core

copy config_file_master:
 file.copy:
 - name: /etc/syslog-ng/syslog-ng.conf
 - source: /srv/salt/Master/syslog-ng.conf
 - force: True