.data
  f1: .float 3.
  f2: .float 15.
  
  # Błąd przy dzieleniu znormalizowana/zdenormalizowana
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
  
  # Obsługa zer, nan, inf
  movl f1, %eax
  movl f2, %edx
  shl %edx
  shl %eax
  # jeśli X2 = 0
  cmp $0, %edx
  je divX2Zero
  cmp $0, %eax 
  je divX1ZeroOnly
  jmp divZeroEnd
  divX2Zero:
    # jeśli X1 = 0
    cmp $0, %eax 
    je divX1Zero
    jmp setInf # jeśli tylko X2 = 0 to setInf
    divX1Zero:
      orl $0x7fffffff, result
      jmp divEnd
  divX1ZeroOnly:
    andl $0x80000000, result
    jmp divEnd
  divZeroEnd:

  # Wykładnik
  expOfTo f1, %esi
  expOfTo f2, %ebx

  # Kalkulacja
  sub %ebx, %esi
  add $0x7F, %esi

  cmp $0, %esi
  jl divX1ZeroOnly

  # Sprawdzenie +/-inf
  cmp $254, %esi
  jg setInf


  # Ułamek
  fracOfTo f1, %eax
  fracOfTo f2, %ebx

  movl %eax, %edx
  shl $26, %eax
  shr $6, %edx
  div %ebx
  # Sprawdzamy, czy trzeba normalizować
  fdiv_normalize_left:
  movl %eax, %ecx
  cmpl $0x04000000, %ecx
  jge fdiv_do_not_normalize_left
    roll %eax
    # Korekcja wykładnika
    dec %esi

    jmp fdiv_normalize_left
  fdiv_do_not_normalize_left:

  fdiv_normalize_right:
  movl %eax, %ecx
# 0000 1000 0000 0000 0000 0000 0000 0000
# 1 0000 0000 0000 0000 0000 0000
  andl $0xfc000000, %ecx
  cmpl $0x04000000, %ecx
  jle fdiv_do_not_normalize_right
    rorl %eax
    # Korekcja wykładnika
    inc %esi

    jmp fdiv_normalize_right
  fdiv_do_not_normalize_right:

  # Sprawdzenie +/-inf
  cmp $254, %esi
  jg setInf
  jmp infCheckEnd
  setInf:
    orl $0x7f800000, result
    andl $0xff800000, result 
    jmp divEnd
  infCheckEnd:

  # Wstawianie wykładnika
  shl $23, %esi
  andl $0x807fffff, result
  orl %esi, result

  
  # Ustawianie bitu S
  cmp $0, %edx
  je sBitEnd
    orl $0x00000001, %eax
  sBitEnd:


  # Zaokrąglanie symetrycznie do parzystej
  mov %eax, %ecx
  andl $0x00000007, %ecx
  cmp $0x00000003, %ecx
  je roundUp

  andl $0x00000007, %ecx
  cmp $0x00000007, %ecx
  je roundUp

  mov %eax, %ecx
  andl $0x00000007, %ecx
  cmp $0x00000002, %ecx
  je roundUp
  
  jmp roundEnd
  roundUp:
    add $4, %eax
  roundEnd:
  shr $3, %eax

  andl $0x007fffff, %eax
  orl %eax, result

  divEnd:

  push $0
  call exit

