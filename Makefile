ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

run-vm:
	as -g -o $(o) $(asm) && gcc -Wall -o $(bin) $(o) && $(ROOT_DIR)/$(bin)

run:
	as -g -o $(o) $(asm) && gcc -o $(bin) $(o) && $(ROOT_DIR)/$(bin)
