build-vm:
	as -g -o $(o) $(asm) && gcc -Wall -o $(bin) $(o)

build:
	as -g -o $(o) $(asm) && gcc -o $(bin) $(o)
