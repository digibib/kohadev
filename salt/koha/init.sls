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
    - skip_verify: True

########
# APACHE
########

apache2:
  pkg.installed

/etc/apache2/ports.conf:
  file.append:
    - text:
      - Listen 8080
      - Listen 8081
    - stateful: True
    - require:
      - pkg: apache2

sudo a2enmod rewrite:
  cmd.run:
    - require:
      - pkg: apache2

apache2_service:
  service.running:
    - name: apache2
    - require:
      - pkg: apache2
      - cmd: sudo a2enmod rewrite
      - cmd: sudo a2enmod cgi
      - cmd: sudo a2dissite 000-default
      - file: /etc/apache2/ports.conf

koharepo:
  pkgrepo.managed:
    - name: deb http://debian.koha-community.org/koha squeeze main
    - key_url: http://debian.koha-community.org/koha/gpg.asc

##########
# KOHA-COMMON
##########

koha-common:
  pkg.installed:
    - skip_verify: True
    - require:
      - pkgrepo: koharepo
      - pkg: installdeps

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
