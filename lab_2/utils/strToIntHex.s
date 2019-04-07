.text
.globl strToIntHex
# liczba zapisana ma format 0xFFFFFFFF dla size = 1
# liczba znaków po 0x musi być wielokrotnością 8
# strToIntHex(char *string, superDuperLong* long, int size)
strToIntHex:
    push %ebp
    movl %esp, %ebp
    pusha

    mov 8(%ebp), %edi # pointer do stringa
    mov 12(%ebp), %esi # pointer do wynikowego longa
    mov 16(%ebp), %ecx # size

    convertAll:
        push %edi
        mov $0, %edx
        xor %ebx, %ebx

        # obliczanie adresu kolejnego bajta 
        dec %ecx
        lea (%edi, %ecx, 8), %edi
        add $2, %edi
        inc %ecx

        convertWord:
            movb (%edi, %edx, 1), %al
            subb $48, %al
            cmp $10, %al
            jb number
            subb $7, %al # jeśli nie liczba to odejmij 7
            number:

            shl $4, %ebx
            addb %al, %bl

            inc %edx
            cmp $8, %edx
            jne convertWord

        pop %edi

        dec %ecx
        movl %ebx, (%esi, %ecx, 4)
        inc %ecx
        
        loop convertAll

    popa
    movl %ebp, %esp
    pop %ebp
    ret $12
