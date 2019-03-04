.data
    string: 
        .rept 16
        .byte 0
        .endr   # Allocate buffer of 16 bytes

    writeBuff: .byte 0
    eol: .string "\n"
.text
.globl _start
_start:
    mov $3, %eax # read(0, str, strlen(str))
    mov $0, %ebx
    mov $string, %ecx
    mov $16, %edx
    int $0x80
    
    # do sth with input
    xor %eax, %eax  # clean eax
    xor %ebx, %ebx
    while:
        mov string(%ebx), %cl
        cmp $10, %cl               # if char is not asci 10 (enter)
        je endwhile
        
        sub $48, %cl
        add %cl, %al
        inc %ebx
        jmp while
    endwhile:

    whileDisplay:
        mov $10, %cl
        div %cl
        xor %ecx, %ecx
        add $48, %ah
        mov %ah, (writeBuff) # string to write
       

        push %eax

        mov $4, %eax # write(1, str, strlen(str))
        mov $1, %ebx
        mov $1, %edx # length
        
        # write digit
        mov $writeBuff, %ecx
        int $0x80
        mov $4, %eax

        # write eol
        mov $eol, %ecx
        int $0x80

        pop %eax

        xor %ah, %ah
        cmp $0, %al
        jnz whileDisplay
        
    # print input
    mov $4, %eax # write(1, str, strlen(str))
    mov $1, %ebx
    mov $string, %ecx
    mov $16, %edx
    int $0x80

    mov $1, %eax # exit(0)
    mov $0, %ebx
    int $0x80
