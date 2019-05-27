.data
    ROWS = 1000
    COLS = 1000
    strFormatTime: .string "Obliczenia zajęły %lld cykli procesora. \n"
.bss
    matrix1: .space 4 * ROWS * COLS
    matrix2: .space 4 * ROWS * COLS
    time1: .space 8
    time2: .space 8
.text

.macro measureT time
    cpuid
    rdtsc
    movl %eax, \time
    movl %edx, \time+4
.endm

.macro calcTime
    movl time1, %eax
    movl time1+4, %edx
    subl %eax, time2
    sbbl %edx, time2+4
.endm

.globl _start
.extern exit
.extern printf
_start:

    # Po wierszach
    measureT time1
    mov $ROWS * COLS, %ecx
    rowLoop:
        movl $0, -4 + matrix1(, %ecx, 4)
        loop rowLoop
    measureT time2
    calcTime

    push time2+4
    push time2
    push $strFormatTime
    call printf
    add $12, %esp

    # Po kolumnach
    measureT time1
    mov $COLS, %ecx
    colLoop1:
        push %ecx
            rowLoop1:
                movl $0, matrix2(, %ecx, 4)
                add $ROWS, %ecx
                cmp $ROWS*COLS, %ecx
                jl rowLoop1
        pop %ecx
        decl %ecx
        cmp $-1, %ecx
        jnz colLoop1
    measureT time2
    calcTime

    push time2+4
    push time2
    push $strFormatTime
    call printf
    add $12, %esp

    push $0
    call exit
