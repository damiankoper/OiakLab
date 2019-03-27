.include "add.s"
.text
# strToIntHex(char *string, super duper long* long, int wordsCount)
strFoIntHex:
    push %ebp
    movl %esp, %ebp
    pusha

    xor %eax, %eax
    xor %edx, %edx
    mov 8(%ebp), %ecx # ładujemy pierwszy argument(+8) do %ecx
    counter:
        mov (%ecx, %edx ,1), %al # ładujemy %ecx+%edx bo tam są kolejne znaki 
        cmpb $0, %al # sprawdzamy czy znak to null, jeśli tak do mamy liczbę znaków w %edx
        je stop
        inc %edx 
        jmp counter
    stop:

    popa
    movl %ebp, %esp
    pop %ebp
    ret
