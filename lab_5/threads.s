# https://softwareengineering.stackexchange.com/questions/207386/how-are-the-size-of-the-stack-and-heap-limited-by-the-os
# https://github.com/skeeto/pure-linux-threads-demo/blob/master/threads-i386.s
# https://nullprogram.com/blog/2015/05/15/


# https://dhavalkapil.com/blogs/Buffer-Overflow-Exploit/
# https://www.thegeekstuff.com/2013/06/buffer-overflow/

# https://stackoverflow.com/questions/1739349/understanding-and-doing-code-injection-in-c

.data
    STACK_SIZE = 1024
    SYS_CLONE = 120
    SYS_WAIT4 = 7
    CLONE_VM = 0x00000100
    CLONE_FS = 0x00000200
    CLONE_FILES = 0x00000400
    CLONE_SIGHAND = 0x00000800
    CLONE_PARENT = 0x00008000
    CLONE_THREAD = 0x00010000
    CLONE_IO = 0x80000000
    THREAD_FLAGS = CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_PARENT|CLONE_THREAD|CLONE_IO

    formatStr: .string "%d\n"
    c: .long 0
.bss
    stack1: .space STACK_SIZE
    stack2: .space STACK_SIZE
.text

.extern exit
.extern printf

.globl _start

_start:
push $stack1 + STACK_SIZE
push $THREAD_FN
call CREATE_THREAD
add $8, %esp

push $stack2 + STACK_SIZE
push $THREAD_FN
call CREATE_THREAD
add $8, %esp

WAIT_LOOP:
cmp $0, c
jnz WAIT_LOOP
    jmp EXIT

THREAD_FN:
    mov $9, %ecx
    PRINT_LOOP:
        push %ecx
        push %ecx
        add $48, (%esp)

        mov $4, %eax
        mov $1, %ebx
        mov %esp, %ecx
        mov $1, %edx
        int $0x80

        add $4, %esp
        pop %ecx
        loop PRINT_LOOP
    lock decl c
    jmp EXIT

CREATE_THREAD:
    lock incl c
    mov 4(%esp), %eax
    mov 8(%esp), %ecx

    mov %eax, (%ecx)
    
    mov $THREAD_FLAGS, %ebx
    mov $SYS_CLONE, %eax
    int $0x80
    ret

EXIT:
    push $0
    call exit
