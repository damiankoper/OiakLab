.data
  add_result: .long 0
  f1: .float -1.5
  f2: .float -1.5
.text

.include "utils/macros.s"
.extern exit

.globl _start
_start:

  movl $0, add_result

  # Zamiana jeśli A < B
  expOfTo f1 %eax
  expOfTo f2 %ebx
  cmp %eax, %ebx
  jg fadd_swap
  
  fracOfTo f1 %eax
  fracOfTo f2 %ebx
  cmp %eax, %ebx
  jg fadd_swap
  jmp fadd_swap_end
  fadd_swap:
  movl f1, %eax
  xchg f2, %eax
  xchg f1, %eax
  fadd_swap_end: 

  # Wykładniki
  expOfTo f1 %ecx
  expOfTo f2 %ebx
  # Różnica wykładników w %ecx
  subl %ebx, %ecx

  fracOfTo f1 %eax
  fracOfTo f2 %ebx
  
  # Wyrównanie wykładnika B, bo B < A
  shr %cl, %ebx

  movl f1, %ecx
  movl f2, %edx
  andl $0x80000000, %ecx
  andl $0x80000000, %edx
  cmp %ecx, %edx
  je signs_same
    # Znak -
    subl %ebx, %eax
    movl $0x80000000, add_result
  jmp add_sub_end
  signs_same:
    # Znak taki sam
    addl %ebx, %eax 
    movl add_result, %ebx
    andl $0x80000000, %ebx
    orl $0x80000000, add_result
  add_sub_end:

  expOfTo f1 %esi

  # Normalizacja sumy/różnicy
  # Sprawdzamy, czy trzeba normalizować
  fadd_normalize_left:
  cmpl $0x00400000, %eax
  jge fadd_do_not_normalize_left
    roll %eax
    # Korekcja wykładnika
    dec %esi
    jmp fadd_normalize_left
  fadd_do_not_normalize_left:
  fadd_normalize_right:
  cmpl $0x01000000, %eax
  jl fadd_do_not_normalize_right
    rorl %eax
    # Korekcja wykładnika
    inc %esi
    jmp fadd_normalize_right
  fadd_do_not_normalize_right:

  cmp $255, %esi
  jge setInf

  # Wstawianie wykładnika
  shl $23, %esi
  andl $0x807fffff, add_result
  orl %esi, add_result

  # Wstawienie mantysy
  andl $0x007fffff, %eax
  orl %eax, add_result

  jmp endAdd
  setZero:
  movl $0x00000000, add_result
  jmp endAdd
  setInf:
  movl $0x7f800000, add_result
  endAdd:

  push $0
  call exit
