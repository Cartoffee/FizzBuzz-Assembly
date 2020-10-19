.model small
.stack 100h
.data
fizz db 10, 13, "Fizz$"
buzz db 10, 13, "Buzz$"
fizzbuzz db 10, 13, "FizzBuzz$"
newline db 10, 13, "$"
.code

start:
	xor CX, CX
	mov ax,@data
	mov ds,ax

counter:
	inc   CX
	cmp   CX, 30
	jle verificare
	jg    exit

verificare:
	
	mov   AX, CX  
	mov   BH, 15 
	div   BH     
	cmp   AH, 0            
	je    print_fizzbuzz
	
	mov   AX, CX 
	mov   BH, 3  
	div   BH   
	cmp   AH, 0       
	je    print_fizz
	
	mov   AX, CX 
	mov   BH, 5
	div   BH
	cmp   AH, 0        
	je    print_buzz
	
	jmp   print_other


print_fizzbuzz:
	mov AH, 09h
	mov DX, OFFSET fizzbuzz
	int 21h
	jmp counter


print_fizz:

	mov AH, 09h
	mov DX, OFFSET fizz
	int 21h
	jmp counter

print_buzz:

	mov AH, 09h
	mov DX, OFFSET buzz
	int 21h
	jmp counter

print_other:
	mov AH, 09h
	mov DX, OFFSET newline
	int 21h
	mov AX, CX
	cmp AX, 10
	jl print_1digit
	jge print_2digit

print_1digit:
	push ax
	mov bx, ax
	add bl, 48
	mov ah, 02h
	mov dl, bl
	int 21h
	jmp counter
	
print_2digit:
	push ax
	aam
	mov bx, ax
	add bh, 48
	add bl, 48
	mov ah, 02h
	mov dl, bh
	int 21h
	mov ah, 02h
	mov dl, bl
	int 21h
	jmp counter

	


exit:
	mov ah, 4ch
	int 21h
	int 20h

end start