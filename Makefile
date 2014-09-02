.PHONY: all clean

all: reload provision

# halt + up is like a reload - except it should also work if there is no machine yet
reload: halt up

halt:
	vagrant halt

up:
	vagrant up

provision:
	vagrant provision

setup: createdb gitify adminuser

createdb:
	vagrant ssh -c 'sudo salt-call --local state.sls koha.createdb'

gitify:
	vagrant ssh -c 'sudo salt-call --local state.sls koha.gitify'

adminuser:
	vagrant ssh -c 'sudo salt-call --local state.sls koha.adminuser'

clean:
	vagrant destroy --force
