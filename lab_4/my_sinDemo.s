	.file	"my_sinDemo.c"
	.text
.Ltext0:
	.section	.rodata
.LC1:
	.string	"%E"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.file 1 "./my_sinDemo.c"
	.loc 1 6 0
	.cfi_startproc
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	movl	%esp, %ebp
	pushl	%ebx
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x78,0x6
	.cfi_escape 0x10,0x3,0x2,0x75,0x7c
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	.loc 1 7 0
	subl	$12, %esp
	flds	.LC0@GOTOFF(%ebx)
	leal	-4(%esp), %esp
	fstps	(%esp)
	call	my_sin@PLT
	addl	$16, %esp
	subl	$4, %esp
	leal	-8(%esp), %esp
	fstpl	(%esp)
	leal	.LC1@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
	.loc 1 8 0
	movl	$0, %eax
	.loc 1 9 0
	leal	-8(%ebp), %esp
	popl	%ecx
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC0:
	.long	1070141403
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
.LFB1:
	.cfi_startproc
	movl	(%esp), %ebx
	ret
	.cfi_endproc
.LFE1:
	.text
.Letext0:
	.file 2 "/usr/lib/gcc/x86_64-linux-gnu/7/include/stddef.h"
	.file 3 "/usr/include/bits/types.h"
	.file 4 "/usr/include/bits/libio.h"
	.file 5 "/usr/include/stdio.h"
	.file 6 "/usr/include/bits/sys_errlist.h"
	.file 7 "/usr/include/math.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x35c
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF60
	.byte	0xc
	.long	.LASF61
	.long	.LASF62
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF8
	.byte	0x2
	.byte	0xd8
	.long	0x30
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF0
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF1
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.long	.LASF2
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF5
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF6
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF7
	.uleb128 0x2
	.long	.LASF9
	.byte	0x3
	.byte	0x37
	.long	0x61
	.uleb128 0x2
	.long	.LASF10
	.byte	0x3
	.byte	0x8c
	.long	0x85
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.long	.LASF11
	.uleb128 0x2
	.long	.LASF12
	.byte	0x3
	.byte	0x8d
	.long	0x6f
	.uleb128 0x5
	.byte	0x4
	.uleb128 0x6
	.byte	0x4
	.long	0x9f
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF13
	.uleb128 0x7
	.long	0x9f
	.uleb128 0x8
	.long	.LASF43
	.byte	0x94
	.byte	0x4
	.byte	0xf5
	.long	0x22b
	.uleb128 0x9
	.long	.LASF14
	.byte	0x4
	.byte	0xf6
	.long	0x5a
	.byte	0
	.uleb128 0x9
	.long	.LASF15
	.byte	0x4
	.byte	0xfb
	.long	0x99
	.byte	0x4
	.uleb128 0x9
	.long	.LASF16
	.byte	0x4
	.byte	0xfc
	.long	0x99
	.byte	0x8
	.uleb128 0x9
	.long	.LASF17
	.byte	0x4
	.byte	0xfd
	.long	0x99
	.byte	0xc
	.uleb128 0x9
	.long	.LASF18
	.byte	0x4
	.byte	0xfe
	.long	0x99
	.byte	0x10
	.uleb128 0x9
	.long	.LASF19
	.byte	0x4
	.byte	0xff
	.long	0x99
	.byte	0x14
	.uleb128 0xa
	.long	.LASF20
	.byte	0x4
	.value	0x100
	.long	0x99
	.byte	0x18
	.uleb128 0xa
	.long	.LASF21
	.byte	0x4
	.value	0x101
	.long	0x99
	.byte	0x1c
	.uleb128 0xa
	.long	.LASF22
	.byte	0x4
	.value	0x102
	.long	0x99
	.byte	0x20
	.uleb128 0xa
	.long	.LASF23
	.byte	0x4
	.value	0x104
	.long	0x99
	.byte	0x24
	.uleb128 0xa
	.long	.LASF24
	.byte	0x4
	.value	0x105
	.long	0x99
	.byte	0x28
	.uleb128 0xa
	.long	.LASF25
	.byte	0x4
	.value	0x106
	.long	0x99
	.byte	0x2c
	.uleb128 0xa
	.long	.LASF26
	.byte	0x4
	.value	0x108
	.long	0x263
	.byte	0x30
	.uleb128 0xa
	.long	.LASF27
	.byte	0x4
	.value	0x10a
	.long	0x269
	.byte	0x34
	.uleb128 0xa
	.long	.LASF28
	.byte	0x4
	.value	0x10c
	.long	0x5a
	.byte	0x38
	.uleb128 0xa
	.long	.LASF29
	.byte	0x4
	.value	0x110
	.long	0x5a
	.byte	0x3c
	.uleb128 0xa
	.long	.LASF30
	.byte	0x4
	.value	0x112
	.long	0x7a
	.byte	0x40
	.uleb128 0xa
	.long	.LASF31
	.byte	0x4
	.value	0x116
	.long	0x3e
	.byte	0x44
	.uleb128 0xa
	.long	.LASF32
	.byte	0x4
	.value	0x117
	.long	0x4c
	.byte	0x46
	.uleb128 0xa
	.long	.LASF33
	.byte	0x4
	.value	0x118
	.long	0x26f
	.byte	0x47
	.uleb128 0xa
	.long	.LASF34
	.byte	0x4
	.value	0x11c
	.long	0x27f
	.byte	0x48
	.uleb128 0xa
	.long	.LASF35
	.byte	0x4
	.value	0x125
	.long	0x8c
	.byte	0x4c
	.uleb128 0xa
	.long	.LASF36
	.byte	0x4
	.value	0x12d
	.long	0x97
	.byte	0x54
	.uleb128 0xa
	.long	.LASF37
	.byte	0x4
	.value	0x12e
	.long	0x97
	.byte	0x58
	.uleb128 0xa
	.long	.LASF38
	.byte	0x4
	.value	0x12f
	.long	0x97
	.byte	0x5c
	.uleb128 0xa
	.long	.LASF39
	.byte	0x4
	.value	0x130
	.long	0x97
	.byte	0x60
	.uleb128 0xa
	.long	.LASF40
	.byte	0x4
	.value	0x132
	.long	0x25
	.byte	0x64
	.uleb128 0xa
	.long	.LASF41
	.byte	0x4
	.value	0x133
	.long	0x5a
	.byte	0x68
	.uleb128 0xa
	.long	.LASF42
	.byte	0x4
	.value	0x135
	.long	0x285
	.byte	0x6c
	.byte	0
	.uleb128 0xb
	.long	.LASF63
	.byte	0x4
	.byte	0x9a
	.uleb128 0x8
	.long	.LASF44
	.byte	0xc
	.byte	0x4
	.byte	0xa0
	.long	0x263
	.uleb128 0x9
	.long	.LASF45
	.byte	0x4
	.byte	0xa1
	.long	0x263
	.byte	0
	.uleb128 0x9
	.long	.LASF46
	.byte	0x4
	.byte	0xa2
	.long	0x269
	.byte	0x4
	.uleb128 0x9
	.long	.LASF47
	.byte	0x4
	.byte	0xa6
	.long	0x5a
	.byte	0x8
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.long	0x232
	.uleb128 0x6
	.byte	0x4
	.long	0xab
	.uleb128 0xc
	.long	0x9f
	.long	0x27f
	.uleb128 0xd
	.long	0x30
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.long	0x22b
	.uleb128 0xc
	.long	0x9f
	.long	0x295
	.uleb128 0xd
	.long	0x30
	.byte	0x27
	.byte	0
	.uleb128 0xe
	.long	.LASF64
	.uleb128 0xf
	.long	.LASF48
	.byte	0x4
	.value	0x13f
	.long	0x295
	.uleb128 0xf
	.long	.LASF49
	.byte	0x4
	.value	0x140
	.long	0x295
	.uleb128 0xf
	.long	.LASF50
	.byte	0x4
	.value	0x141
	.long	0x295
	.uleb128 0x6
	.byte	0x4
	.long	0xa6
	.uleb128 0x7
	.long	0x2be
	.uleb128 0x10
	.long	.LASF51
	.byte	0x5
	.byte	0x87
	.long	0x269
	.uleb128 0x10
	.long	.LASF52
	.byte	0x5
	.byte	0x88
	.long	0x269
	.uleb128 0x10
	.long	.LASF53
	.byte	0x5
	.byte	0x89
	.long	0x269
	.uleb128 0x10
	.long	.LASF54
	.byte	0x6
	.byte	0x1a
	.long	0x5a
	.uleb128 0xc
	.long	0x2c4
	.long	0x300
	.uleb128 0x11
	.byte	0
	.uleb128 0x7
	.long	0x2f5
	.uleb128 0x10
	.long	.LASF55
	.byte	0x6
	.byte	0x1b
	.long	0x300
	.uleb128 0x3
	.byte	0xc
	.byte	0x4
	.long	.LASF56
	.uleb128 0xf
	.long	.LASF57
	.byte	0x7
	.value	0x1e9
	.long	0x5a
	.uleb128 0x12
	.long	.LASF65
	.byte	0x1
	.byte	0x5
	.long	0x5a
	.long	.LFB0
	.long	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x359
	.uleb128 0x13
	.long	.LASF58
	.byte	0x1
	.byte	0x5
	.long	0x5a
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x13
	.long	.LASF59
	.byte	0x1
	.byte	0x5
	.long	0x359
	.uleb128 0x2
	.byte	0x91
	.sleb128 4
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.long	0x99
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x1c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x4
	.byte	0
	.value	0
	.value	0
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	0
	.long	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF22:
	.string	"_IO_buf_end"
.LASF9:
	.string	"__quad_t"
.LASF30:
	.string	"_old_offset"
.LASF61:
	.string	"./my_sinDemo.c"
.LASF54:
	.string	"sys_nerr"
.LASF25:
	.string	"_IO_save_end"
.LASF5:
	.string	"short int"
.LASF8:
	.string	"size_t"
.LASF35:
	.string	"_offset"
.LASF19:
	.string	"_IO_write_ptr"
.LASF14:
	.string	"_flags"
.LASF21:
	.string	"_IO_buf_base"
.LASF26:
	.string	"_markers"
.LASF16:
	.string	"_IO_read_end"
.LASF57:
	.string	"signgam"
.LASF53:
	.string	"stderr"
.LASF6:
	.string	"long long int"
.LASF34:
	.string	"_lock"
.LASF11:
	.string	"long int"
.LASF60:
	.string	"GNU C11 7.3.0 -m32 -mtune=generic -march=i686 -g -fstack-protector-strong"
.LASF62:
	.string	"/home/damian_koper/Documents/GitHub/OiakLab/lab_4"
.LASF31:
	.string	"_cur_column"
.LASF50:
	.string	"_IO_2_1_stderr_"
.LASF64:
	.string	"_IO_FILE_plus"
.LASF47:
	.string	"_pos"
.LASF59:
	.string	"argv"
.LASF46:
	.string	"_sbuf"
.LASF43:
	.string	"_IO_FILE"
.LASF56:
	.string	"long double"
.LASF1:
	.string	"unsigned char"
.LASF58:
	.string	"argc"
.LASF4:
	.string	"signed char"
.LASF7:
	.string	"long long unsigned int"
.LASF48:
	.string	"_IO_2_1_stdin_"
.LASF0:
	.string	"unsigned int"
.LASF44:
	.string	"_IO_marker"
.LASF33:
	.string	"_shortbuf"
.LASF18:
	.string	"_IO_write_base"
.LASF42:
	.string	"_unused2"
.LASF15:
	.string	"_IO_read_ptr"
.LASF2:
	.string	"short unsigned int"
.LASF13:
	.string	"char"
.LASF65:
	.string	"main"
.LASF45:
	.string	"_next"
.LASF36:
	.string	"__pad1"
.LASF37:
	.string	"__pad2"
.LASF38:
	.string	"__pad3"
.LASF39:
	.string	"__pad4"
.LASF40:
	.string	"__pad5"
.LASF3:
	.string	"long unsigned int"
.LASF20:
	.string	"_IO_write_end"
.LASF12:
	.string	"__off64_t"
.LASF10:
	.string	"__off_t"
.LASF27:
	.string	"_chain"
.LASF24:
	.string	"_IO_backup_base"
.LASF51:
	.string	"stdin"
.LASF29:
	.string	"_flags2"
.LASF41:
	.string	"_mode"
.LASF17:
	.string	"_IO_read_base"
.LASF32:
	.string	"_vtable_offset"
.LASF23:
	.string	"_IO_save_base"
.LASF55:
	.string	"sys_errlist"
.LASF28:
	.string	"_fileno"
.LASF52:
	.string	"stdout"
.LASF49:
	.string	"_IO_2_1_stdout_"
.LASF63:
	.string	"_IO_lock_t"
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
