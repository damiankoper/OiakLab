.data
  STDIN = 0
  STDOUT = 1
  WRITE = 4
  READ = 3
  EXIT = 1
  SYSCALL32 = 1
  INPUT_SIZE = 10

  eol: .ascii "\n"
  star: .ascii "*"
.bss
  input: .space INPUT_SIZE
.text
.globl _start
_start:
  # read(0, input, INPUT_SIZE)
  mov $READ, %eax 
  mov $STDIN, %ebx
  mov $input, %ecx
  mov $INPUT_SIZE, %edx
  int $0x80

  # parse text 0-9 for now
  # sub $2, %eax
  mov $0, %ecx
  movb input, %cl

  sub $48, %cl
  
  while:
    cmp $0, %cl
    je endWhile
    push %ecx

    # write(1, star, 1)
    mov $WRITE, %eax 
    mov $STDOUT, %ebx
    mov $star, %ecx
    mov $1, %edx
    int $0x80
    
    pop %ecx
    dec %cl
    jmp while
  endWhile:

  # write(1, star, 1)
  mov $WRITE, %eax 
  mov $STDOUT, %ebx
  mov $eol, %ecx
  mov $1, %edx
  int $0x80

  mov $EXIT, %eax
  mov $0, %ebx
  int $0x80
