.data
  strA: .string "Wpisz A: "
  strB: .string "Wpisz B: "
  strFormat: .string "%lf"
.bss
  a: .double
  b: .double
.text
.extern scanf
.extern printf
.extern exit
.globl _start
_start:
  push $strA
  call printf

  push $strFormat
  push $a
  call scanf




  push $0
  call exit
