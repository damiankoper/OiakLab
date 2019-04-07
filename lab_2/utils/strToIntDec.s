.data
    mul10:  
        .rep 4
        .long 0
        .endr

    bufferDec:  
        .rep 4
        .long 0
        .endr
.text
# tylko dla size = 4 - ograniczone przez mnożenie
# strToIntDec(char *string, superDuperLong* long, int size = 4)
.globl strToIntDec
strToIntDec:
    push %ebp
    movl %esp, %ebp
    pusha

    mov 8(%ebp), %edi # pointer do stringa
    mov 12(%ebp), %esi # pointer do wynikowego longa
    mov 16(%ebp), %ecx # size = 4

    mov $0, %edx
    counterDec:
        mov (%edi, %edx ,1), %al # ładujemy %ecx+%edx bo tam są kolejne znaki 
        cmpb $10, %al # sprawdzamy czy znak to eol
        je stopDec
        
        push %edx

        mov $3, %ecx
        movl $10, mul10(,%ecx, 4)

        push $4
        push $mul10
        push %esi
        call mulFn

        
        subb $48, %al
        mov $3, %ecx
        movzbl %al, %edx
        mov %edx, bufferDec(,%ecx, 4)

        push $4
        push %esi
        push $bufferDec
        call addFn

        pop %edx
        inc %edx 
        jmp counterDec
    stopDec:

    popa
    movl %ebp, %esp
    pop %ebp
    ret $12
