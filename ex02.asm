.data
input: .asciz "Nhap so nguyen n: "
format: .asciz "%ld"
perfect: .asciz "La so hoan thien\n"
notPerfect: .asciz "Khong phai so hoan thien\n"
number: .quad 0

.text
.global main
.type main,%function

main:
	stp x29,x30,[sp,-16]!
	mov x29,sp
	
	adrp x0,input
	add x0,x0, :lo12:input
	bl printf
	
	adrp x0,format
	add x0,x0, :lo12:format
	adrp x1,number
	adrp x1,number
	add x1,x1, :lo12:number
	bl scanf
	
	adrp x19,number
	add x19,x19, :lo12:number
	ldr x19,[x19]
	
	mov x20,#1
	mov x21,#0

check_perfect:
	cmp x20,x19
	beq verify
	
	udiv x22,x19,x20
	mul x22,x22,x20
	sub x22,x19,x22
	cmp x22,#0
	bne next_divisor
	
	add x21,x21,x20
	
next_divisor:
	add x20,x20,#1
	b check_perfect
verify:
	cmp x21,x19
	beq is_perfect
	
	adrp  x0,notPerfect
	add x0,x0, :lo12:notPerfect
	bl printf
	b exit
	
is_perfect:
	adrp x0,perfect
	add x0,x0, :lo12:perfect
	bl printf
exit:
	mov x0,#0
	ldp x29,x30,[sp],16
	ret
.size main,.-main

