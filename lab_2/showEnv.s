.data
  str1: .string "Parametry wywołania:"
  str2: .string "Zmienne środowiskowe:"
  spc: .ascii " "
.text
.globl _start

# Podłączam część skryptów pomocniczych
.include "utils/exit.s"
.include "utils/printStr.s"


_start:  
  lea str1, %eax
  push %eax
  call printStr
  add $4, %esp # pop bez zapisywania

  # printuj argumenty
  mov (%esp), %eax
  xor %ecx, %ecx
  arguments:
    push 4(%esp, %ecx, 4)
    call printStr
    add $4, %esp # pop bez zapisywania
    inc %ecx
    cmp %eax, %ecx
    jne arguments

  lea str2, %eax
  push %eax
  call printStr
  add $4, %esp # pop bez zapisywania

  # printuj argumenty
  mov (%esp), %eax
  inc %eax
  env:
    cmp $0, 4(%esp, %eax, 4)
    je stopEnv
    push 4(%esp, %eax, 4)
    call printStr
    add $4, %esp # pop bez zapisywania
    inc %eax
    jne env
  stopEnv:

  jmp exit
          