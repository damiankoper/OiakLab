.data
  f1: .long 0b00111111100000000000000000000000

  f2: .long 0b00111111100000000000000000000000
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
  
  movl f1, %eax
  movl f2, %edx
  shl %eax
  shl %edx
  # Obsługa zer
  cmp $0, %eax
  je mulZero
  cmp $0, %edx
  je mulZero
  jmp mulZeroEnd
  mulZero:
    andl $0x80000000, result 
    jmp mulEnd
  mulZeroEnd:

  # Wykładnik
  expOfTo f1, %esi
  expOfTo f2, %ebx

  # Kalkulacja
  add %ebx, %esi
  sub $0x7F, %esi

  # Ułamek
  fracOfTo f1, %eax
  fracOfTo f2, %ebx
  mul %ebx

  # Sprawdzamy, czy trzeba normalizować, bit 48 iloczynu
  movl %edx, %ecx
  andl $0x00008000, %ecx
  cmpl $0x00008000, %ecx
  jne fmul_do_not_normalize_right
    rorl %edx
    rcrl %eax

    # Korekcja wykładnika
    inc %esi

    jmp normalize_end
  fmul_do_not_normalize_right:

  # Sprawdzamy, czy trzeba normalizować, bit 47 iloczynu
  fmul_normalize_left:
  movl %edx, %ecx
  andl $0x00004000, %ecx
  cmpl $0x00000000, %ecx
  jne fmul_do_not_normalize_left
    roll %eax
    rcll %edx

    # Korekcja wykładnika
    dec %esi
  
    jmp fmul_normalize_left
  fmul_do_not_normalize_left:
  normalize_end:

  # Sprawdzenie +/-inf
  cmp $254, %esi
  jg setInf
  jmp infCheckEnd
  setInf:
    orl $0x7f800000, result
    andl $0xff800000, result 
    jmp mulEnd
  infCheckEnd:

  # Wstawianie wykładnika
  shl $23, %esi
  andl $0x807fffff, result
  orl %esi, result

  
  # Ustawianie bitu S
  mov %eax, %ecx
  andl $0x1fffffff, %ecx
  cmp $0, %ecx 

  jne sBit1
  sBit0:
    andl $0xffdfffff, %eax
    jmp sBitEnd
  sBit1:
    orl $0x00400000, %eax
  sBitEnd:

  # Ułamek
  mov $21, %ecx # 23 - R - S
  shiftLoop:
    clc
    rcrl %edx
    rcrl %eax
    loop shiftLoop

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
  shr $2, %eax

  andl $0x007fffff, %eax
  orl %eax, result

  mulEnd:

  push $0
  call exit

