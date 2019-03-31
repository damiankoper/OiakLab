.data
    WORD_WIDTH = 4
    c1: 
    .rep WORD_WIDTH
    .long 0xffffffff
    .endr
    c2:
    .rep WORD_WIDTH
    .long 0
    .endr
    # c2 = c1 + c2

    str: .string "0xAAAAAAAABBBBBBBBCCCCCCCCDDDDDDDDEEEEEEEE"
.bss

.text
.include "utils/exit.s"
.include "utils/add.s"
.include "utils/strToIntHex.s"
.globl _start
_start: 


push $WORD_WIDTH
push $c2 
push $str
call strToIntHex

#pushl $WORD_WIDTH
#pushl $c2
#pushl $c1
#call addFn

jmp exit   
         