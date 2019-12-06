CFLAGS=-m32
AFLAGS=-f elf

build:	tema2

tema2:	tema2.o include/macro.o include/utils.o
	gcc $^ -o $@ $(CFLAGS)

tema2.o:tema2.asm
	nasm $^ -o $@ $(AFLAGS)

clean:
	rm -rf tema2.o tema2

task1: clean build
	./tema2 inputs/task1_1.pgm 1

task2: clean build
	./tema2 inputs/task2_2.pgm 2
