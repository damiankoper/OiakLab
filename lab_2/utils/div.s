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
# long2 = trash :(
.globl divFn
divFn:
    push %ebp
    mov %esp, %ebp
    pusha

    clc # wyczyść flagę przeniesienia na wszelki wypadek

    mov 8(%ebp), %ebx
    mov 12(%ebp), %edx

    # Skalowanie

    scaleLoopX:
        movl %ebx, %eax
        call shiftL

        movl %edx, %eax
        call shiftL

        movl (%ebx), %eax
        andl $0x40000000, %eax      
        cmp $0x40000000, %eax
        jne scaleLoopX


    # Zakładamy, że long1 >= long2
    # TODO: Tu miejsce na zwrócenie 0 i reszty jeśli long1<long2

    mov $0, %ecx
    scaleLoopD:
        inc %ecx

        movl %edx, %eax
        call shiftL

        movl (%edx), %eax
        andl $0x40000000, %eax      
        cmp $0x40000000, %eax
        jne scaleLoopD
    push %ecx

    # Dzielenie nieodtwarzające

    pushl $4
    pushl %edx
    pushl %ebx
    call subFn

    pop %ecx
    divLoop:
        push %ecx

        movl (%ebx), %eax
        andl $0x80000000, %eax  
        movl (%edx), %ecx   
        andl $0x80000000, %ecx  
        pusha

        movl %ebx, %eax
        call shiftL

        popa
        cmp %eax, %ecx
        je subR
        jne addR


        addR:
            pushl $4
            pushl %ebx
            pushl %edx
            call addFn
            jmp addsubEnd

        subR:
            pushl $4
            pushl %edx
            pushl %ebx
            call subFn

            pushl $4
            pushl $result
            pushl $add1
            call addFn

        addsubEnd:

        movl $result, %eax
        call shiftL

        pop %ecx
        loop divLoop



    mov $0, %eax
    resultLoop1:
        mov result(,%eax,4), %ecx
        mov %ecx, (%ebx, %eax, 4)

        inc %eax
        cmp $4, %eax
        jne resultLoop1

    popa
    mov %ebp, %esp
    pop %ebp 
    ret $12

shiftL: # x4 - cała liczba
    push %ecx
    clc
    mov $3, %ecx
    
    rcll (%eax,%ecx,4)
    dec %ecx
    
    rcll (%eax,%ecx,4)
    dec %ecx
    
    rcll (%eax,%ecx,4)
    dec %ecx
    
    rcll (%eax,%ecx,4)
    dec %ecx
    
    pop %ecx
    ret
