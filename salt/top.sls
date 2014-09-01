base:
  '*':
    # highstate: States to create a vanilla Koha development install 
    - koha
    - koha.createdb
    - koha.gitify
    - koha.apache
