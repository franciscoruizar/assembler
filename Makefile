run-vm:
	as -g -o $(o) $(asm) && gcc -Wall -o $(bin) $(o) && sh $(bin)

run:
	as -g -o $(o) $(asm) && gcc -o $(bin) $(o) && sh $(bin)
