all: first_jogo.gb

first_jogo.gb: code.o
	rgblink -o first_jogo.gb code.o
	rgbfix -v -p 0 first_jogo.gb

code.o: code.asm
	rgbasm -o code.o code.asm

clean: 
	rm -f *.0 *.gb	