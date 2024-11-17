.data
input: 		.asciz "Nhap so nguyen n: "
format:		.asciz "%ld"
square:		.asciz "La so chinh phuong\n"
notSquare:	.asciz "Khong phai so chinh phuong\n"
number:		.quad 	0

.text
.global main
.type 	main,%function

main:
	stp x29,x30,[sp,-16]!
	mov x29,sp
	
	adrp x0,input
	add x0,x0, :lo12:input
	bl printf
	
	adrp x0,format
	add x0,x0, :lo12:format
	adrp x1,number
	add x1,x1, :lo12:number
	bl scanf
	
	adrp x19,number
	add x19,x19, :lo12:number
	ldr x19,[x19]
	
	mov x20,#1
	
check_square:
	mul x21,x20,x20
	cmp x21,x19
	beq is_square
	bgt not_square
	
	add x20,x20,#1
	b   check_square
is_square:
	adrp x0,square
	add x0,x0, :lo12:square
	bl printf
	b exit
not_square:
	adrp x0,notSquare
	add x0,x0, :lo12:notSquare
	bl printf
exit:
	mov x0,#0
	ldp x29,x30,[sp],16
	ret
.size main,.-main
