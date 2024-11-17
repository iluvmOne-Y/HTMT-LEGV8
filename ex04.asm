.data
input: .asciz "Nhap so nguyen n:"
format: .asciz "%ld"
palindrome: .asciz "La so doi xung\n"
notPalind: .asciz "Khong phai so doi xung\n"
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
	add x1,x1, :lo12:number
	bl scanf
	
	adrp x19,number
	add x19,x19,: lo12:number
	ldr x19,[x19]
	mov x20,x19
	mov x21,#0
	
reverse:
	cmp x20,#0
	beq check_palindrome
	
	mov x22,#10
	udiv x23,x20,x22
	mul x24,x23,x22
	sub x24,x20,x24
	
	mul x21,x21,x22
	add x21,x21,x24
	
	udiv x20,x20,x22
	b reverse
	
check_palindrome:
	cmp x19,x21
	beq is_palindrome
	
	adrp x0,notPalind
	add x0,x0, :lo12:notPalind
	bl printf
	b exit

is_palindrome:
	adrp x0,palindrome
	add x0,x0, :lo12:palindrome
	bl printf
exit:
	mov x0,#0
	ldp x29,x30,[sp],16
	ret
.size main, .-main
