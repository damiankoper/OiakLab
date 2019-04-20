.data
  add_result: .long 0
  f1: .float 2.5
  d1: .quad 0
  d2: .double 2.5
  formatStr: .string "%E"
.text

.include "utils/macros.s"
.extern exit
.extern printf

.globl _start
_start:

  # printf potrzebuje double

  # Wykładnik
  expOfTo f1, %eax
  addl $896, %eax  # wyrównanie biasu
  shl $20, %eax
  movl %eax, d1+4 # <- little endian, część młodsza jest dalej

  # Ułamek - 1 słowo
  fracOfTo f1, %eax
  movl %eax, %ebx
  shr $3, %ebx
  andl $0x000fffff, %ebx
  orl %ebx, d1+4
  
  # Ułamek - 2 słowo
  shl $29, %eax
  movl %eax, d1

  # Znak
  movl f1, %eax
  andl $0x80000000, %eax
  orl %eax, d1+4 

  # 32bit -> trzeba pushować na 2 razy
  pushl d1+4
  pushl d1
  push $formatStr
  call printf

  push $0
  call exit
