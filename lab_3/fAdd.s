.data
  f1: .float 2
  f2: .float 2
  formatStr: .string "%5.5f"
.text

.extern printf
.extern scanf
.extern exit

.globl _start
_start:

  

  push $0
  call exit
