.text

.macro expOfTo f reg
  movl \f, \reg
  andl $0x7f800000, \reg
  shr $23, \reg
  cmp $0, \reg
  jne 5f
    inc \reg
  5:
.endm

.macro fracOfTo f reg
  # Analizuj wykładnik czy dodać ukrytą jedynkę
  movl \f, \reg
  andl $0x7f800000, \reg
  shr $23, \reg

  # Dodaj albo nie 
  cmp $0, \reg
  movl \f, \reg
  je 4f
    orl $0x00800000, \reg
  4: # local label
  andl $0x00ffffff, \reg
.endm

