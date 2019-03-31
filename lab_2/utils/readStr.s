.data
    STDIN = 0
    READ = 3
    SYSCALL32 = 0x80
.text
# readStr(char* result, int* length)
readStr:
    push %ebp
    mov %esp, %ebp
    pusha

    mov $READ, %eax
    mov $STDIN, %ebx
    mov 8(%ebp), %ecx
    mov 12(%ebp), %edx
    int $SYSCALL32



    popa
    mov %ebp, %esp
    pop %ebp

    ret