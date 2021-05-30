ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

build-vm:
	as -g -o $(file).o $(file).asm && gcc -Wall -o $(file) $(file).o

build:
	as -g -o $(file).o $(file).asm && gcc -o $(file) $(file).o

debug:
	gdb -tui ./$(file)
