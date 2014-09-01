##########
# KOHADEV- APACHE
##########

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

/etc/apache2/sites-available/{{ pillar['koha']['instance'] }}-dev.conf:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/apache-dev.tmpl
    - template: jinja
    - context:
      OpacPort: 8080
      IntraPort: 8081
      ServerName: {{ pillar['koha']['instance'] }}
    - stateful: True

# make sure apache folders point to right dev folder
/etc/koha/apache-shared.conf:
  file.replace:
    - pattern: \/usr\/share\/koha\/lib
    - repl: /usr/local/src/koha

disable_default:
  cmd.run:
    - name: sudo a2dissite default || true

# disable automatically generated koha instance from koha-common install 
disable_prod:
  cmd.run:
    - name: sudo a2dissite {{ pillar['koha']['instance'] }}.conf || true

enable_dev:
  cmd.run:
    - name: sudo a2ensite {{ pillar['koha']['instance'] }}-dev.conf
    - require:
      - cmd: disable_prod

apache2_service:
  service:
    - running
    - name: apache2
    - watch:
      - file: /etc/koha/apache-shared.conf
      - cmd: enable_dev