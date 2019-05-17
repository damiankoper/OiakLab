.data
  formatStr: .string "%d: %#4x \n"
  c: .long 0
.text
.extern printf
.globl stacktrace

stacktrace:
  push %ebp
  mov %esp, %ebp

  mov %ebp, %eax

  stackLoop:
    mov 4(%eax), %ebx

    push %eax
    push %ebx
    push c
    push $formatStr
    call printf
    add $12, %esp 
    pop %eax

    incl c
    mov (%eax), %eax

    test %eax, %eax
    jnz stackLoop

  mov %ebp, %esp
  pop %ebp
  ret
