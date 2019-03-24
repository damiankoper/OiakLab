.data

.text
.globl _start

exit:
  mov $1, %eax
  mov $0, %ebx
  int $0x80

_start:
  jmp exit