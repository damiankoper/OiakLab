.data
  strA: .string "Wpisz A: "
  strB: .string "Wpisz B: "
  strC: .string "Wpisz ilość przedziałów: "

  strFormat: .string "%lf"
  strFormatInt: .string "%d"
  strFormatSin: .string "Całka z sin(x): %f \n"
  strFormatLog: .string "Całka z log(x): %f \n"
  strFormatTime: .string "Obliczenia zajęły %ld cykli procesora. \n"


  two_const: .double 2.0
  a: .double 1
  aCopy: .double 0
  b: .double 10
  numOfIntervals: .long 100
  interval: .double 0
  timeTSC1: .long 0
           .long 0
  timeTSC2: .long 0
           .long 0
  
.text
.extern scanf
.extern printf
.extern exit
.globl _start
_start:

  # A
  push $strA
  call printf
  add $4, %esp

  push $a
  push $strFormat
  call scanf
  add $8, %esp

  # Zapisz A dla drugiej całki
  movl a, %eax
  movl 4+a, %ebx
  movl %eax, aCopy
  movl %ebx, 4+aCopy

  # B
  push $strB
  call printf
  add $4, %esp

  push $b
  push $strFormat
  call scanf
  add $8, %esp

  # Intervals
  push $strC
  call printf
  add $4, %esp

  push $numOfIntervals
  push $strFormatInt
  call scanf
  add $8, %esp

  # Pomiar czasu 
  xor %eax, %eax
  cpuid
  rdtsc
  movl %eax, timeTSC1
  movl %edx, timeTSC1 + 4


  # Kalkulacja - metoda trapezów

  # Obliczanie wysokości trapezu
  fildl numOfIntervals
  fldl a
  fldl b
  
  fsubp
  fdivp
  # Zapisz interval
  fstpl interval

  ### sin(x)

  mov numOfIntervals, %ecx
  # Początkowe 0
  fldz
  # Działanie według ONP -> opisane w sprawozdaniu
  trapezeCalcSin:
    fldl interval
    fldl a
    fsin
    fldl a
    fldl interval
    faddp
    fsin
    faddp
    fmulp
    fldl two_const
    fdivrp
    faddp

    # Popchnij a
    fldl a
    faddl interval
    fstpl a
  loop trapezeCalcSin
  fstpl a

  # Pomiar czasu
  xor %eax, %eax
  cpuid
  rdtsc
  movl %eax, timeTSC2
  movl %edx, timeTSC2 + 4

  push a + 4
  push a
  push $strFormatSin
  call printf
  add $12, %esp

  # Przywróć stare A
  movl aCopy, %eax
  movl 4+aCopy, %ebx
  movl %eax, a
  movl %ebx, 4+a

  ### log10(x)

  mov numOfIntervals, %ecx
  # Początkowe 0
  fldz
  # Działanie według ONP -> opisane w sprawozdaniu
  trapezeCalcLog:
    fldl interval

    # Log10 a
    fldlg2
    fldl a
    fyl2x

    # Log10 a+b
    fldlg2
    fldl a
    fldl interval
    faddp
    fyl2x
    
    faddp
    fmulp
    fldl two_const
    fdivrp
    faddp

    # Popchnij a
    fldl a
    faddl interval
    fstpl a
  loop trapezeCalcLog
  fstpl a
  
  push a + 4
  push a
  push $strFormatLog
  call printf
  add $12, %esp

  # Wypisanie czasu całki sin(x)
  movl timeTSC2, %eax
  movl timeTSC2 + 4, %edx
  subl timeTSC1, %eax
  sbbl timeTSC1 + 4, %edx
  push %edx
  push %eax
  push $strFormatTime
  call printf
  add $12, %esp

  push $0
  call exit
