.data
  f1: .float -12e+10
  const_f10: .float 10
  min: .string "-"
  comma: .string "."
.bss
  intStr: .space 100
  intBuf: .long
  charBuf: .byte
  controlWord: .word

.text
.extern exit
.extern printf 
.extern fflush
.globl _start
_start:
  finit

  # Integer z ucięciem -> -2
  fld f1
  ftst
  fstsw %ax
  and $0x0100, %ax
  cmp $0x0000, %ax
  je printMinEnd
    push $min
    call printf 
    add $4, %esp
  printMinEnd:

  # Zaokrąglanie przez obcięcie -> truncate - potrzebne do konwersji
  fstcw controlWord
  orw $0x0C00, controlWord
  fldcw controlWord

  xor %ecx, %ecx  
  intLoop:
    # Wartość absolutna i zaokrąglenie 
    fabs
    frndint

    fld const_f10
    fxch
    fstl %st(2)
    fprem # Re(minder)szta z dzielenia

    # Jeśli 0 to wyjdź z pętli
    fxch %st(2)
    ftst 
    fstsw %ax
    and $0x4000, %ax
    cmp $0x0000, %ax
    jne intLoopEnd 
    fxch %st(2)

    # Wpisz do intBuf i popnij ze stosu FPU
    fistpl intBuf
    add $48, intBuf
    movb intBuf, %al
    movb %al, intStr(,%ecx, 1)
    inc %ecx

    fdivrp
    jmp intLoop
  intLoopEnd:

  push %ecx
  push stdout;
  call fflush # Żeby wypisało się w dobrej kolejności trzeba spłukać stdout
  add $4, %esp
  pop %ecx

  # Printowanie części całkowitej
  printLoop:
    mov intStr-1(,%ecx,1), %al
    movb %al, charBuf

    push %ecx
    # Wypisz liczbę
    mov $4, %eax
    mov $1, %ebx
    mov $charBuf, %ecx
    mov $1, %edx
    int $0x80
    pop %ecx
  loop printLoop
   
  push $comma
  call printf

  push stdout
  call fflush # Żeby wypisało się w dobrej kolejności trzeba spłukać stdout
  add $4, %esp

  fld1
  fld f1
  fabs
  mov $10, %ecx
  fracLoop:
    fprem # Re(minder)szta z dzielenia
    fmul const_f10
    fld %st(0)
    frndint

    fistpl intBuf
    add $48, intBuf
    mov intBuf, %al
    movb %al, charBuf

    push %ecx
    # Wypisz liczbę
    mov $4, %eax
    mov $1, %ebx
    mov $charBuf, %ecx
    mov $1, %edx
    int $0x80
    pop %ecx

    loop fracLoop

  push $0
  call exit

