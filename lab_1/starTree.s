.data
  STDIN = 0
  STDOUT = 1
  WRITE = 4
  READ = 3
  EXIT = 1
  SYSCALL32 = 1
  INPUT_SIZE = 10

  width: .long 11

  eol: .ascii "\n"
  star: .ascii "*"
  space: .ascii " "
  writeBuff: .space 1

.bss
  input: .space 10

.text

printASCII:                 # printASCII(char)
    push %ebp 
    movl %esp, %ebp
    pusha

    mov 8(%ebp), %eax
    mov %eax, (writeBuff)

    mov $4, %eax            # write
    mov $1, %ebx            # stdout
    mov $writeBuff, %ecx    # ptr to str
    mov $1, %edx            # length
    int $0x80

    popa
    movl %ebp, %esp
    pop %ebp
    ret

.globl _start
_start:
  # Wczytaj wysokosc
  pusha
  # read(0, input, INPUT_SIZE)
  mov $READ, %eax 
  mov $STDIN, %ebx
  mov $input, %ecx
  mov $INPUT_SIZE, %edx
  int $0x80
  mov %eax, %edx # ilość wczytanych jest w eax po przerwaniu, kopiuję do edx, bo eax używa mnożenie
  dec %edx
  mov $0, %eax # eax wynik
  mov $0, %ecx
  
  readLoop:
    push %edx
    mov $10, %edx
    mull %edx
    pop %edx

    movb input(,%ecx, 1), %bl
    sub $48, %ebx
    add %ebx, %eax

    inc %ecx
    cmp %ecx, %edx
    jne readLoop

  mov %eax, (width)
  popa



  # ebx - liczni gwiazdek - 1 :)
  movl $0, %ebx
  # eax - obliczanie początkowego licznika spacji
  movl (width), %eax
  movl $2, %ecx
  div %ecx
  mov %eax, %ecx
  # Zapisz początkowy licznik żeby natysować potem pień
  mov %eax, %edx
  ###

  whileRow:
    # Zapisz ecx
    push %ecx
    whileSpace:
      push space
      call printASCII
      pop space # trzeba popnąć pusznięty argument żeby stos się zgadzał
      dec %ecx
      cmp $0, %ecx
      jge whileSpace
    # Przywróć ecx
    pop %ecx
   
    push %ebx
    whileStar:
      push star
      call printASCII
      pop star
      dec %ebx
      cmp $0, %ebx
      jge whileStar
    pop %ebx
    add $2, %ebx

    # Wydrukuj znak nowej linii
    push eol
    call printASCII
    pop eol
    ###

    # Obniż licznik wysokości i skocz
    dec %ecx
    cmp $0, %ecx
    jge whileRow
    ###
  
  # Narysuj pień
  mov $2, %ecx # wysokość pnia
  whileRoot:
    push %edx
    whileRootSpace:
      push space
      call printASCII
      pop space # trzeba popnąć pusznięty argument żeby stos się zgadzał
      dec %edx
      cmp $0, %edx
      jge whileRootSpace
    pop %edx

    push star
    call printASCII
    pop star
    push eol
    call printASCII
    pop eol

    loop whileRoot
  ### end whileRoot

  # Exit gently
  mov $EXIT, %eax
  mov $0, %ebx
  int $0x80
