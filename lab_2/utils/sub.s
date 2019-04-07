.text
.globl subFn
# subFn(superDuperLong* long1, superDuperLong* long2, int size)
# long1 = long1 - long2
subFn:
    push %ebp
    mov %esp, %ebp
    pusha

    clc # wyczyść flagę przeniesienia na wszelki wypadek
    mov 16(%ebp), %ecx # size

    mov 8(%ebp), %ebx
    mov 12(%ebp), %edx

    loopSubb:
        movl -4(%ebx, %ecx, 4), %eax
        sbbl -4(%edx, %ecx, 4), %eax
        movl %eax, -4(%ebx, %ecx, 4)
        loop loopSubb

    popa
    mov %ebp, %esp
    pop %ebp 
    ret $12

