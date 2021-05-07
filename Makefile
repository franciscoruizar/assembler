run-vm:
	as -g -o $(o) $(asm) && gcc -Wall $(bin) $(o) && ./$(bin)

run:
	as -g -o $(o) $(asm) && gcc $(bin) $(o) && ./$(bin)