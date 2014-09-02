##########
# KOHA-FROM-GIT
##########

# not working in debian, yet?
# gitconfig:
#   git.config:
#     - name: deichman.digibib
#     - value: Oslo Public Library
#     - user: digibib
#     - is_global: True

# TODO: this should be a cherry-piced or tagged version of koha
/tmp/koha-v{{ pillar['koha']['version']}}.tar.gz:
  file.managed:
    - source: https://github.com/Koha-Community/Koha/archive/v{{ pillar['koha']['version']}}.tar.gz
    - source_hash: md5=f278996c3edd0e8d8ec4893807f27d71

extract_koha:
  cmd.run:
    - unless: test -f /usr/local/src/koha
    - name: tar -C /usr/local/src/koha -zxf /tmp/koha-v{{ pillar['koha']['version']}}.tar.gz
    - user: {{ pillar['koha']['instance'] }}-koha
    # - name: wget https://github.com/Koha-Community/Koha/archive/v{{ pillar['koha']['version']}}.tar.gz -O /tmp/koha-v{{ pillar['koha']['version']}}.tar.gz
    # - name: git archive --format=tar --remote=git://github.com/Koha-Community/Koha.git "v{{ pillar['koha']['version']}}" > /koha-v{{ pillar['koha']['version']}}.tar.gz
    - require: 
      - file: /tmp/koha-v{{ pillar['koha']['version']}}.tar.gz

/usr/local/src/koha:
  file.directory:
    - user: {{ pillar['koha']['instance'] }}-koha
    - group: {{ pillar['koha']['instance'] }}-koha
    - makedirs: True

########
# KOHA BUGZILLA SETUP
########

/usr/local/bin/git-bz:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/git-bz
    - mode: 755

########
# KOHA GITIFY
########

https://github.com/mkfifo/koha-gitify:
  git.latest:
    - target: /usr/local/src/koha-gitify


gitify:
  cmd.run:
    - name: /usr/local/src/koha-gitify/koha-gitify {{ pillar['koha']['instance'] }} /usr/local/src/koha
    - cwd: /usr/local/src/koha
    - require:
      - git: https://github.com/mkfifo/koha-gitify
