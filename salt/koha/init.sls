##########
# KOHA Development server
# BASED ON DEBIAN WHEEZE 64bit
# PACKAGES
##########

Europe/Oslo:
  timezone.system:
    - utc: True

installdeps:
  pkg.installed:
    - pkgs:
      - python-software-properties
      - software-properties-common
      - libnet-ssleay-perl
      - libcrypt-ssleay-perl
      - git
      - tig
      - mysql-server
    - skip_verify: True

##########
# MYSQL
##########

mysqlrepl1:
  file.replace:
    - name: /etc/mysql/my.cnf
    - pattern: max_allowed_packet.+$
    - repl: max_allowed_packet = 64M

mysqlrepl2:
  file.replace:
    - name: /etc/mysql/my.cnf
    - pattern: wait_timeout.+$
    - repl: wait_timeout = 6000

mysql:
  service:
    - running
    - require:
      - pkg: installdeps
    - watch:
      - file: /etc/mysql/my.cnf
