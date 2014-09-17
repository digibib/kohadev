# highstate: States to create a vanilla Koha development install 
base:
  '*':
    - koha
    #- koha.common
    #- koha.sites-config
    #- koha.apache
    #- koha.webinstaller
    # instance setup - should be run as states or pillared
    #- koha.createdb
    #- koha.gitify
    #- koha.adminuser
