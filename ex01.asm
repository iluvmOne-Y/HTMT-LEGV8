.data
	input: .asciz "Nhap so nguyen n: "
	format: .asciz "%ld"
	isPrime: .asciz "La so nguyen to\n"
	notPrime: .asciz "Khong phai so nguyen to\n"
	number:   .quad   0
.text
.global main
.type  main,%function
main:

	stp x29,x30,[sp,-32]!
	mov x29,sp
	stp x19,x20,[sp,16]
	
	adrp x0, input
	add x0,x0, :lo12:input
	bl printf
	
	
	adrp x0, format
	add x0,x0, :lo12:format
	adrp x1,number
	add x1,x1, :lo12:number
	bl scanf
	
	
	adrp x19,number
	add x19,x19, :lo12:number
	ldr x19,[x19]

	cmp x19,#1
	ble not_prime
	
	cmp x19,#2
	beq is_prime
	
	


	mov x20,#2
	
	
	
check_loop:
	
	cmp x20,x19
	bge is_prime

	udiv x21,x19,x20
	mul x21,x21,x20
	
	cmp x21,x19
	bne continue
	
	b not_prime
continue:
	add x20,x20,#1
	b   check_loop
	
is_prime:
	adrp x0,isPrime
	add x0,x0, :lo12:isPrime
	bl printf
	b exit
not_prime:
	adrp x0,notPrime
	add x0,x0, :lo12:notPrime
	bl printf
exit:
	ldp x19,x20,[sp,16]
	mov x0,#0
	ldp x29,x30,[sp],32
	ret
.size main, .-main
