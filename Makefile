run-vm:
	as -g -o $(o) $(asm) && gcc -Wall -o $(bin) $(o) && sudo sh $(bin)

run:
	as -g -o $(o) $(asm) && gcc -o $(bin) $(o) && sudo sh $(bin)
