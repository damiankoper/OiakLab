.data

.bss
    writeBuff: .byte 0
    readBuff: .byte 0
.text
.globl _start

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80

printASCII:                 # printASCII(char)
    push %ebp
    mov %esp, %ebp

    mov 8(%ebp), %eax
    mov %eax, (writeBuff)

    mov $4, %eax            # write
    mov $1, %ebx            # stdout
    mov $writeBuff, %ecx    # ptr to str
    mov $1, %edx            # length
    int $0x80

    mov %ebp, %esp
    pop %ebp
    ret

_start:
    push $66
    call printASCII
    call exit




