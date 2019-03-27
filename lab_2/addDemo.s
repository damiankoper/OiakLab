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
.bss

.text
.include "utils/exit.s"
.include "utils/add.s"
.globl _start
_start:

pushl $WORD_WIDTH
pushl $c2
pushl $c1
call addFn

jmp exit
 