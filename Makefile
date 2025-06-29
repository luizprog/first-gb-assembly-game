# Makefile

RGBASM = rgbasm
RGBLINK = rgblink
RGBFIX = rgbfix

SRC = src/code.asm
OBJ = build/code.o
OUTPUT = build/first_jogo.gb

.PHONY: all clean

all: $(OUTPUT)

$(OUTPUT): $(OBJ)
	$(RGBLINK) -o $(OUTPUT) $(OBJ)
	$(RGBFIX) -v -p 0 $(OUTPUT)

build/code.o: $(SRC)
	@mkdir -p build
	$(RGBASM) -o build/code.o -i include -i assets $(SRC)

clean:
	rm -rf build
