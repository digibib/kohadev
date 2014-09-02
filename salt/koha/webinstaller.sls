########
# RUN KOHA WEBINSTALLER
# Update koha syspref 'Version' manually, needed to bypass webinstaller
# Update database if not up to date with koha-common version
# Should not run it already up to date
########

watir:
  pkg.installed:
  - pkgs:
    - ruby-dev
    - build-essential
    - chrpath
    - git-core
    - libssl-dev
    - libfontconfig1-dev
    - libxft-dev
  gem.installed:
    - name: watir-webdriver
    - require:
      - pkg: watir

########
# PHANTOMJS
########

/tmp/phantomjs.tar.bz2:
  file.managed:
    - source: https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2
    - source_hash: md5=f278996c3edd0e8d8ec4893807f27d71

install_phantomjs:
  cmd.run:
    - unless: test -f /usr/local/bin/phantomjs
    - name: sudo tar -C /usr/local/bin -x phantomjs-1.9.7-linux-x86_64/bin/phantomjs -jvf phantomjs.tar.bz2 --strip-components=2
    - cwd: /tmp
    - require: 
      - pkg: watir

/tmp/KohaWebInstallAutomation.rb:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/KohaWebInstallAutomation.rb

run_webinstaller:
  cmd.script:
    - source: {{ pillar['saltfiles'] }}/updatekohadbversion.sh
    - stateful: True
    - env:
      - URL: "http://192.168.50.10:8081"
      - USER: {{ pillar['koha']['adminuser'] }}
      - PASS: {{ pillar['koha']['adminpass'] }}
      - INSTANCE: {{ pillar['koha']['instance'] }}
    - watch:
      - pkg: watir
      - file: /tmp/KohaWebInstallAutomation.rb
