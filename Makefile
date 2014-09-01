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

clean:
	vagrant destroy --force
