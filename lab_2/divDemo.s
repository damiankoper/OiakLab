.data
    INPUT_SIZE = 100
    strBuffer1: .space INPUT_SIZE
    strBuffer2: .space INPUT_SIZE
    strBuffer3: .space INPUT_SIZE

    WORD_WIDTH: .long 4
    c1: 
    .rep 4
    .long 0xffffffff
    .endr
    c2:
    .rep 4
    .long 1
    .endr
.bss

.text
.include "utils/exit.s"

.globl _start
_start: 

# Sprawdź czy jest coś w argv, argc
mov (%esp), %eax
cmp $4, %eax
je divDemo_getArgsFromStack

divDemo_readArgs:
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

    # Get hex WORD_SIZE
    push $INPUT_SIZE
    push $strBuffer3
    call readStr

    push $1
    push $c1
    push $strBuffer3
    call strToIntHex

    movl c1, %ecx
    movl %ecx, WORD_WIDTH

    jmp argsFetched

divDemo_getArgsFromStack:
    # Get hex string 1 from stack
    mov $8, %eax
    mov (%esp, %eax, 1), %eax
    mov $12, %ebx
    mov (%esp, %ebx, 1), %ebx
    mov $16, %ecx
    movl (%esp, %ecx, 1), %ecx

    push $1
    push $c1
    push %ecx
    call strToIntHex

    movl c1, %ecx
    movl %ecx, WORD_WIDTH
    
argsFetched:

### Convert buffers
push (WORD_WIDTH)
push $c1
push %eax
call strToIntHex

push (WORD_WIDTH)
push $c2
push %ebx
call strToIntHex

# Multiply
push WORD_WIDTH
push $c2
push $c1
call divFn

# Get & print mul string
push WORD_WIDTH
push $strBuffer1
push $c1
call intHexToStr

push $strBuffer1
call printStr

jmp exit
