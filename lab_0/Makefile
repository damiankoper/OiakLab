endme: endme.o
	ld -melf_i386 endme.o -o endme

endme.o: endme.s
	as --gstabs+ --32 endme.s -o endme.o 

all: endme

clean:
	rm -f endme endme.o