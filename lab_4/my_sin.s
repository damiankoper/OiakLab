.text

.globl my_sin
my_sin:
  push %ebp
  mov %esp, %ebp

  fld 8(%esp)
  fsin

  mov %ebp, %esp
  pop %ebp
  ret
