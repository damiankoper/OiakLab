.text
# intHexToStr(superDuperLong* long, char* string, int wordsCount)
.globl intHexToStr
intHexToStr:
    push %ebp
    movl %esp, %ebp
    pusha

    
    mov 8(%ebp), %esi # pointer do wynikowego longa
    mov 12(%ebp), %edi # pointer do stringa
    #mov 16(%ebp), %ecx # size
    xor %ecx, %ecx
    # Hex prefix
    movb $'0', 0(%edi)
    movb $'x', 1(%edi)
    mov $2, %edx # licznik pozycji stringa

    intHexToStr_convertAll:
        push %ecx
        push %esi

        lea (%esi, %ecx, 4), %esi

        mov $4, %ecx
        intHexToStr_convertBytes:
            xor %eax, %eax
            dec %ecx

            movb (%esi, %ecx, 1), %al
            shr $4, %al
            call intHexToStr_ByteToCharByte

            xor %eax, %eax
            movb (%esi, %ecx, 1), %al
            andb $0x0F, %al
            call intHexToStr_ByteToCharByte

            inc %ecx
            loop intHexToStr_convertBytes


        pop %esi
        pop %ecx 

        inc %ecx
        cmp 16(%ebp), %ecx
        jne intHexToStr_convertAll
    
    # add null at end 
    movb $0, (%edi, %edx, 1)

    popa
    movl %ebp, %esp
    pop %ebp
    ret $12


# small helper - number to convert in %al
intHexToStr_ByteToCharByte: 
    addb $48, %al
    cmp $58, %al
    jl intHexToStr_number
    addb $7, %al # jeśli nie liczba to dodaj 7
    intHexToStr_number:

    movb %al, (%edi, %edx, 1)
    inc %edx
    ret
