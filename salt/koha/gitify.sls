##########
# KOHA-FROM-GIT
##########

# not working, yet?
# gitconfig:
#   git.config:
#     - name: deichman.digibib
#     - value: Oslo Public Library
#     - user: digibib
#     - is_global: True

/usr/local/src/koha:
  file.directory:
    - user: {{ pillar['koha']['instance'] }}-koha
    - group: {{ pillar['koha']['instance'] }}-koha
    - makedirs: True

# sync koha from master, discard all changes before upgrade
https://github.com/Koha-Community/Koha.git:
  git.latest:
    - rev: master
    - force_checkout: True
    - always_fetch: True
    - target: /usr/local/src/koha
    - user: {{ pillar['koha']['instance'] }}-koha

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
