.data
  STDIN = 0
  STDOUT = 1
  WRITE = 4
  READ = 3
  EXIT = 1
  SYSCALL32 = 1
  INPUT_SIZE = 10

  WIDTH = 11
  HEIGHT = 10

  eol: .ascii "\n"
  star: .ascii "*"
  space: .ascii " "
  writeBuff: .space 0

.text

printASCII:                 # printASCII(char)
    push %ebp
    mov %esp, %ebp

    mov 8(%ebp), %eax
    mov %eax, (writeBuff)

    mov $4, %eax            # write
    mov $1, %ebx            # stdout
    mov $writeBuff, %ecx    # ptr to str
    mov $1, %edx            # length
    int $0x80

    mov %ebp, %esp
    pop %ebp
    ret

.globl _start
_start:
  # init counters
  movb $WIDTH, %cl
  movb $HEIGHT, %ch

  whileRow:
    cmp $0, %cl
    je endWhileRow

    whileSpace:

      jmp whileSpace
    endWhileSpace:

    whileStar:

      jmp whileStar
    endWhileStar:

    dec %cl
    jmp whileRow
  endWhileRow:

  push $70
  call printASCII

  mov $EXIT, %eax
  mov $0, %ebx
  int $0x80
