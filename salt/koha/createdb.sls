##########
# KOHA CREATE VANILLA INSTANCE WITH DEFAULT SCHEMAS
##########

# Create instance user and empty database if not already existant
createkohadb:
  cmd.run:
    - unless: id -u {{ pillar['koha']['instance'] }}-koha >/dev/null 2>&1
    - name: koha-create --create-db {{ pillar['koha']['instance'] }}
