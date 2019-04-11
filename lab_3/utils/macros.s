.text

.macro expOfTo f reg
  movl \f, \reg
  andl $0x7f800000, \reg
  shr $23, \reg
.endm

.macro fracOfTo f reg
  expOfTo \f \reg
  cmp $0, \reg
  movl \f, \reg
  je 4f
  orl $0x00800000, \reg
  4: # local label
  andl $0x00ffffff, \reg
.endm
