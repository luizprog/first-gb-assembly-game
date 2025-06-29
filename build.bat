@echo off
rgbasm -o code.o code.asm
rgblink -o first_jogo.gb code.o
rgbfix -v -p 0 first_jogo.gb
echo Build completo!
pause