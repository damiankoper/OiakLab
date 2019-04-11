.data
  f1: .long 0b01000000011110000000000000000000 

  f2: .long 0b01000000011110000000000000000000
  result: .float 0.0
.text

.include "utils/macros.s"
.extern exit
.globl _start
_start:

  # Bit znaku
  movl f1, %eax
  movl f2, %edx
  xorl %edx, %eax
  andl $0x80000000, %eax
  movl %eax, result

  # Wykładnik
  expOfTo f1, %eax
  expOfTo f2, %ebx

  # Kalkulacja
  add %ebx, %eax
  sub $0x7F, %eax

  # Wstawianie
  shl $23, %eax
  andl $0x807fffff, result
  orl %eax, result

  # Ułamek
  fracOfTo f1, %eax
  fracOfTo f2, %ebx
  mul %ebx

  # Sprawdzamy, czy trzeba normalizować, bit nr 48
  movl %edx, %ecx
  andl $0x00010000, %ecx
  cmpl $0x00010000, %ecx
  je fmul_do_not_normalize
    clc
    rorl %edx
    rorl %eax

    expOfTo f1, %eax
  fmul_do_not_normalize:
  

  push $0
  call exit

