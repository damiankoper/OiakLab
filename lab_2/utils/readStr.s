.data
    STDIN = 0
    READ = 3
    SYSCALL32 = 0x80
.text
# readStr(char* result, int length)
readStr:
    push %ebp
    mov %esp, %ebp
    pusha

    mov 12(%ebp), %ecx
    mov 8(%ebp), %esi
    readStr_clearLoop:
        dec %ecx
        movb $0, (%esi, %ecx, 1)
        inc %ecx
        loop readStr_clearLoop

    mov $READ, %eax
    mov $STDIN, %ebx
    mov 8(%ebp), %ecx
    mov 12(%ebp), %edx
    int $SYSCALL32

    popa
    mov %ebp, %esp
    pop %ebp

    ret $8
