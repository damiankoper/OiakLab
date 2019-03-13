main: main.o
	ld -melf_i386 main.o -o main

main.o: main.s
	as --gstabs+ --32 main.s -o main.o 

all: main

clean:
	rm -f main main.o