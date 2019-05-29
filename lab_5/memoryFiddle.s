.data
    ROWS = 2
    COLS = 2
    
    SYS_getrlimit = 76
    RLIMIT_AS = 9

    SYS_mmap = 90
    PROT_READ = 0x1
    PROT_WRITE = 0x2
    SIZE = 0xef7fffff

    mmap_arg_struct:
    .long 0
    .long SIZE
    .long PROT_READ | PROT_WRITE
    .long 34
    .long -1
    .long 0

    rlimitSoft:
    .long 0
    rlimitHard:
    .long 0

    data1: .long 123
    matrix1: .space 4 * ROWS * COLS
.text


.globl _start
.extern exit
.extern printf
_start:
    # Sprawdź limit
    mov $SYS_getrlimit, %eax
    mov $RLIMIT_AS, %ebx
    mov $rlimitSoft, %ecx
    int $0x80

    # Przydziel pamięć
    mov $SYS_mmap, %eax
    mov $mmap_arg_struct, %ebx
    int $0x80

    mov $SIZE/4, %ecx
    insertLoop:
       # push %ecx

       # movl $0x000000ff, %ecx
       # waitLoop:
       #     nop
       #     loop waitLoop
       # pop %ecx

        movl $-1, -4(%eax, %ecx, 4)
        loop insertLoop


    push $0
    call exit
