.data
    WRITE = 4
    STDOUT = 1
    SYSCALL32 = 0x80
    eol: .ascii "\n"
.text
.globl printStr
# printStr(char* str)
printStr:
    pushl %ebp
    movl %esp, %ebp
    pusha

    xor %eax, %eax
    xor %edx, %edx
    mov 8(%ebp), %ecx # ładujemy pierwszy argument(+8) do %ecx
    counter:
        mov (%ecx, %edx ,1), %al # ładujemy %ecx+%edx bo tam są kolejne znaki 
        cmpb $0, %al # sprawdzamy czy znak to null, jeśli tak do mamy liczbę znaków w %edx
        je stop
        inc %edx 
        jmp counter
    stop:

    mov $WRITE, %eax
    mov $STDOUT, %ebx
    mov 8(%ebp), %ecx
    int $SYSCALL32

    mov $WRITE, %eax
    mov $STDOUT, %ebx
    mov $eol, %ecx
    mov $1, %edx
    int $SYSCALL32

    popa
    movl %ebp, %esp
    popl %ebp
    ret $4

     