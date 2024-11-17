.data
input: 		.asciz "Nhap so phan tu n: "
inputElem: 	.asciz "Nhap phan tu thu %d: "
format:		.asciz "%ld"
outFormat:	.asciz "%ld "
newLine: 	.asciz "%\n"
arrayOut:	.asciz "Mang: "
primeList:	.asciz "Cac so nguyen to: "
maxM:		.asciz "Gia tri lon nhat: %ld\n"
avgM:		.asciz "Trung binh mang: %ld\n"
size:		.quad 	0
array:		.skip	800

.text
.global main
.type main,%function

main:
	stp x29,x30,[sp,-64]
	mov x29,sp
	stp x19,x20,[sp,16]
	stp x21,x22,[sp,32]
	stp x23,x24,[sp,48]
	
	adrp x0,input
	add x0,x0, :lo12:input
	bl printf
	
	adrp x0,format
	add x0,x0, :lo12:format
	adrp x1,size
	add x1,x1, :lo12:size
	bl scanf
	
	mov x19,#0
input_loop:
	adrp x0,size
	add x0,x0, :lo12:size
	ldr x0,[x0]
	cmp x19,x0
	bge print_array

	adrp x0,inputElem
	add x0,x0,:lo12:inputElem
	mov x1,x19
	add x1,x1,#1
	bl printf
	
	adrp x0,format
	add x0,x0,:lo12:format
	adrp x1,array
	add x1,x1,:lo12:array
	add x1,x1,x19,lsl #3
	bl scanf
	
	add x19,x19,#1
	b input_loop
print_array:

	adrp x0,arrayOut
	add x0,x0, :lo12:arrayOut
	bl printf
	
	mov x19,#0
print_loop:
	adrp x0,size
	add x0,x0,:lo12:size
	ldr x0,[x0]
	cmp x19,x0
	bge find_prime
	
	adrp x0,outFormat
	add x0,x0,:lo12:outFormat
	adrp x1,array
	add x1,x1, :lo12:array
	ldr x1,[x1,x19,lsl #3]
	bl printf
	
	add x19,x19,#1
	b print_loop
	
find_prime:
	adrp x0,newLine
	add x0,x0, :lo12:newLine
	bl printf
	
	adrp x0,primeList
	add x0,x0, :lo12:primeList
	bl printf
	
	mov x19,#0
prime_loop:
	adrp x0,size
	add x0,x0, :lo12:size
	ldr x0,[x0]
	cmp x19,x0
	bge find_max
	
	adrp x0,array
	add x0,x0, :lo12:array
	ldr x20,[x0,x19,lsl #3]
	
	mov  x21,#2
	
prime_check:
	cmp x21,x20
	bge is_prime_num
	
	udiv x22,x20,x21
	mul x22,x22,x21
	sub x22,x20,x22
	cmp x22,#0
	beq next_prime
	
	add x21,x21,#1
	b prime_check
is_prime_num:
	adrp x0,outFormat
	add x0,x0,:lo12:outFormat
	mov x1,x20
	bl printf 
next_prime:
	add x19,x19,#1
	b prime_loop
	
find_max:
	adrp x0,newLine
	add x0,x0,:lo12:newLine
	bl printf
	
	adrp x0,array
	add x0,x0, :lo12:array
	ldr x20,[x0]
	mov x19,#1
max_loop:
	adrp x0,size
	add x0,x0, :lo12:size
	ldr x0,[x0]
	cmp x19,x0
	bge print_max
	
	adrp x0,array
	add x0,x0,:lo12:array
	ldr x21,[x0,x19,lsl#3]
	cmp x21,x20
	ble next_max
	mov x20,x21
	
next_max:
	add x19,x19,#1
	b max_loop
print_max:
	adrp x0,maxM
	add x0,x0, :lo12:maxM
	mov x1,x20
	bl printf
calc_avg:
	mov x20,#0
	mov x19,#0
	
sum_loop:
	adrp x0,size
	add x0,x0, :lo12:size
	ldr x0,[x0]
	cmp x19,x0
	bge print_avg
	
	adrp x0,array
	add x0,x0, :lo12:array
	ldr x21, [x0,x19,lsl #3]
	add x20,x20,x21
	
	add x19,x19,#1
	b sum_loop
print_avg:
	adrp x0,size
	add x0,x0,: lo12:size
	ldr x1,[x0]
	udiv x20,x20,x1
	
	adrp x0,avgM
	add x0,x0, :lo12:avgM
	mov x1,x20
	bl printf
exit:
	ldp x23,x24,[sp,48]
	ldp x21,x22,[sp,32]
	ldp x19,x20,[sp,16]
	mov x0,#0
	ldp x29,x30,[sp],64
	ret
.size main,.-main
