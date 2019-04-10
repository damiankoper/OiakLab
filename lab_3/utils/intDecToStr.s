.include "add.s"
.text
# intDesToStr(superDuperLong* long, int wordsCount)
strFoIntHex:
    push %ebp
    movl %esp, %ebp
    pusha

    

    popa
    movl %ebp, %esp
    pop %ebp
    ret
