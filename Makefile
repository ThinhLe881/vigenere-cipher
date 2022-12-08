all: encrypt.asm decrypt.asm
	nasm -f elf64 -F dwarf -g -o encrypt.o encrypt.asm
	gcc -m64 -no-pie -o encrypt.out encrypt.o

	nasm -f elf64 -F dwarf -g -o decrypt.o decrypt.asm
	gcc -m64 -no-pie -o decrypt.out decrypt.o

clean:
	rm *.out
	rm *.o