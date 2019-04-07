.data
    INPUT_SIZE = 100
    strBuffer1: .space INPUT_SIZE
    strBuffer2: .space INPUT_SIZE
    strBuffer3: .space INPUT_SIZE

    WORD_WIDTH: .long 4
    c1: 
    .rep 16
    .long 0
    .endr
    c2:
    .rep 16
    .long 0
    .endr
.bss

.text
.include "utils/exit.s"

.globl _start
_start: 

# Sprawdź czy jest coś w argv, argc
mov (%esp), %eax
cmp $4, %eax
je addDemo_getArgsFromStack

addDemo_readArgs:
    # Get hex string 1
    push $INPUT_SIZE
    push $strBuffer1
    call readStr
    lea strBuffer1, %eax

    # Get hex string 2
    push $INPUT_SIZE
    push $strBuffer2
    call readStr
    lea strBuffer2, %ebx

    # WORD_SIZE in fixed 4

    jmp argsFetched

addDemo_getArgsFromStack:
    # Get hex string 1 from stack
    mov $8, %eax
    mov (%esp, %eax, 1), %eax
    mov $12, %ebx
    mov (%esp, %ebx, 1), %ebx
    
argsFetched:

### Convert buffers
push (WORD_WIDTH)
push $c1
push %eax
call strToIntDec

push (WORD_WIDTH)
push $c2
push %ebx
call strToIntDec

# Add
push WORD_WIDTH
push $c2
push $c1
call addFn

# Get & print sum string
push WORD_WIDTH
push $strBuffer1
push $c2
call intHexToStr

push $strBuffer1
call printStr

jmp exit
