.extern printf
.extern scanf
.extern _exit
.data
    INPUT_SIZE = 100
    strBuffer1: .space INPUT_SIZE
    strBuffer2: .space INPUT_SIZE
    strBuffer3: .space INPUT_SIZE
    strFormat: .string "%s"
    WORD_WIDTH: .long 4
    c1: 
    .rep 16
    .long 0xffffffff
    .endr
    c2:
    .rep 16
    .long 1
    .endr
.bss

.text
.include "utils/sub.s"
.include "utils/strToIntHex.s"
.include "utils/intHexToStr.s"


.globl _start
_start: 

# Sprawdź czy jest coś w argv, argc
mov (%esp), %eax
cmp $4, %eax
je addDemo_getArgsFromStack

addDemo_readArgs:
    # Get hex string 1
    push $strBuffer2
    push $strFormat
    call scanf
    add $8, %esp
    push $strBuffer2

    # Get hex string 2
    push $strBuffer1
    push $strFormat
    call scanf
    add $8, %esp
    push $strBuffer1

    # Get hex WORD_SIZE
    push $strBuffer3
    push $strFormat
    call scanf
    add $8, %esp

    pop %ebx
    pop %eax

    push $1
    push $c1
    push $strBuffer3
    call strToIntHex

    movl c1, %ecx
    movl %ecx, WORD_WIDTH

    jmp argsFetched

addDemo_getArgsFromStack:
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

# Subtract
push WORD_WIDTH
push $c2
push $c1
call subFn

# Get & print difference string
push WORD_WIDTH
push $strBuffer1
push $c1
call intHexToStr

push $strBuffer1
call printf
add $4, %esp

push $0
call exit # tym raze nie moja funkcja, a z biblioteki C