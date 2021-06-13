ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

build-vm:
	as -g -o $(file).o $(file).s && gcc -Wall -o $(file) $(file).o

build:
	as -g -o $(file).o $(file).s && gcc -o $(file) $(file).o

debug:
	gdb ./$(file)
