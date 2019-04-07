.text
# addFn(superDuperLong* long1, superDuperLong* long2, int size)
# long2 = long1 + long2
.globl addFn
addFn:
    push %ebp
    mov %esp, %ebp
    pusha

    clc # wyczyść flagę przeniesienia na wszelki wypadek
    mov 16(%ebp), %ecx # size

    mov 8(%ebp), %ebx
    mov 12(%ebp), %edx

    loopAddc:
        movl -4(%ebx, %ecx, 4), %eax
        adc -4(%edx, %ecx, 4), %eax
        movl %eax, -4(%edx, %ecx, 4)
        loop loopAddc

    popa
    mov %ebp, %esp
    pop %ebp 
    ret $12

