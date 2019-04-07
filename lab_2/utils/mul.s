.data
    mul_buffer:
        .rep 8
        .long 0
        .endr
    mul_result:  
        .rep 8
        .long 0
        .endr
.text
.globl mulFn
.extern addFn
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

    call clearResult

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
            movl %edx, mul_buffer(,%ecx,4)
            inc %ecx
            movl %eax, mul_buffer(,%ecx,4)
            pop %ecx

            # Dodanie bufora do wyniku
            pushl $8 # hardkodowany rozmiar x2, ponieważ wynik mnożenia jest/może być 2x większy
            pushl $mul_result
            pushl $mul_buffer
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
        mov mul_result(,%eax,4), %edx
        mov %edx, (%ecx, %eax, 4)

        inc %eax
        cmp $4, %eax
        jne resultLoop1

    # Część niższa
    mov $4, %eax
    mov $0, %ecx
    resultLoop2:
        mov mul_result(, %eax, 4), %edx
        mov %edx, (%ebx, %ecx, 4)

        inc %ecx
        inc %eax
        cmp $8, %eax
        jne resultLoop2

        popa
        movl %ebp, %esp
        popl %ebp
        ret $12


# Mali pomocnicy do czyszczenia buforów
clearBuffer:
    pusha
    mov $8, %ecx

    clearBufferLoop:
        dec %ecx
        movl $0, mul_buffer(,%ecx,4)
        inc %ecx
        loop clearBufferLoop
    popa
    ret

clearResult:
    pusha
    mov $8, %ecx

    clearResultLoop:
        dec %ecx
        movl $0, mul_result(,%ecx,4)
        inc %ecx
        loop clearResultLoop
    popa
    ret


    