.data
    buffer:
        .rep 8
        .long 0
        .endr
    result:  
        .rep 8
        .long 0
        .endr
.text
.include "utils/add.s"
# mulFn(superDuperLong* long1, superDuperLong* long2, int size)
# !!!! Działa tylko na liczbach, gdzie size = 4 !!!!
# wynik = long2:long1
mulFn:
    push %ebp
    mov %esp, %ebp
    pusha

    clc # wyczyść flagę przeniesienia na wszelki wypadek

    # Wskaźniki na składniki są na stosie 
    mov 8(%ebp), %ebx  # A
    mov 12(%ebp), %ecx # B


    # Pętla iterująca po B
    mov $3, %esi
    outerLoop:

        # Pętla iterująca po A
        mov $3, %edi
        innerLoop:
            pushl %edi

            # Mnożenie składowych
            mov (%ebx, %edi, 4), %eax
            mull (%ecx, %esi, 4)

            # Wstawianie wyniku już na odpowiednie miejsce bufora (z przesunięciem)
            push %ecx
            add %esi, %edi
            mov %edi, %ecx
            movl %edx, buffer(,%ecx,4)
            inc %ecx
            movl %eax, buffer(,%ecx,4)
            pop %ecx

            # Dodanie bufora do wyniku
            pushl $8 # hardkodowany rozmiar x2, ponieważ wynik mnożenia jest/może być 2x większy
            pushl $result
            pushl $buffer
            call addFn

            call clearBuffer

            pop %edi
            dec %edi
            cmp $-1, %edi
            jne innerLoop

        dec %esi
        cmp $-1, %esi
        jne outerLoop

    # Wpisywanie wyniku pod wskażniki z argumentów z adresu 'result'
    # Część wyższa
    mov $0, %eax
    resultLoop1:
        mov result(,%eax,4), %edx
        mov %edx, (%ecx, %eax, 4)

        inc %eax
        cmp $4, %eax
        jne resultLoop1

    # Część niższa
    mov $4, %eax
    mov $0, %ecx
    resultLoop2:
        mov result(, %eax, 4), %edx
        mov %edx, (%ebx, %ecx, 4)

        inc %ecx
        inc %eax
        cmp $8, %eax
        jne resultLoop2

    popa
        movl %ebp, %esp
        popl %ebp
        ret $8


    # Mały pomocnik do czyszczenia bufora
    clearBuffer:
    pusha
    mov $8, %ecx

    clearBufferLoop:
        dec %ecx
        movl $0, buffer(,%ecx,4)
        inc %ecx
        loop clearBufferLoop
    popa
    ret

    