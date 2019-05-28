.data
  STDOUT = 1
  WRITE = 4
  EXIT = 1
  SYSCALL32 = 1

  hello: .string "Hello World!\n"
  helloLen = 13
.text
.globl _start
_start:

  #.rept 10000
  #  nop
  #.endr

  mov $WRITE, %eax 
  mov $STDOUT, %ebx
  mov $hello, %ecx
  mov $helloLen, %edx
  int $0x80

  mov $EXIT, %eax
  mov $0, %ebx
  int $0x80
