##########
# KOHA PURGE INSTANCE
##########

# remove koha instance
removekohainstance:
  cmd.run:
    - name: koha-remove {{ pillar['koha']['instance'] }}

# purge stale mysql admin user
dropmysqlusers:
  cmd.run:
    - name: "echo \"drop user {{ pillar['koha']['adminuser'] }},{{ pillar['koha']['adminuser'] }}@localhost; flush privileges;\" | mysql -u root > /dev/null 2>&1"
    - require: 
      - cmd: removekohainstance

purgezebra:
  cmd.run:
    - name: rm -rf /var/lib/koha/{{ pillar['koha']['instance'] }}
    - watch: 
      - cmd: removekohainstance

purgeconfig:
  cmd.run:
    - name: rm -rf /etc/koha/sites/{{ pillar['koha']['instance'] }}
    - watch: 
      - cmd: removekohainstance
