.data
    result:  
        .rep 4
        .long 0
        .endr
    add1:  
        .rep 3
        .long 0
        .endr
        .long 1
.text
# addFn(superDuperLong* long1, superDuperLong* long2, int size)
# !!!! Działa tylko na liczbach dodatnich, gdzie size = 4 !!!! 128b
# long1/long2
# long1 = quotient 
# long2 = reminder 
.include "utils/sub.s"
.include "utils/add.s"

divFn:
    push %ebp
    mov %esp, %ebp
    pusha

    clc # wyczyść flagę przeniesienia na wszelki wypadek

    mov 8(%ebp), %ebx
    mov 12(%ebp), %edx


    divLoop:

        pushl $4
        pushl %edx
        pushl %ebx
        call subFn

        movl (%ebx), %eax
        andl $0x80000000, %eax      

        cmp $0x80000000, %eax
        je endAdd

        pushl $4
        pushl $result
        pushl $add1
        call addFn

        jmp divLoop

    endAdd:   
        pushl $4
        pushl %ebx
        pushl %edx
        call addFn
    end:

    popa
    mov %ebp, %esp
    pop %ebp 
    ret $12
