INCLUDE Irvine32.inc

upper = 10
lower = 1

.data
greeting byte "Hello! This program was brought to you by Spencer Carlson", 0
prompt1 byte "Please enter a number between one and ten: ", 0
prompt2 byte "Enter another number less than the first: ", 0
error byte "Invalid, try again: ", 0
subtract byte "Subraction: ", 0
addition byte "Addition: ", 0
division byte "Division: ", 0
multiplication byte "multiplication: ", 0
goodbye byte "Until next time!", 0
num1 DWORD ?
num2 DWORD ?

.code
main proc
	
	call getnums
	call subt
	call mult
	call addi
	call divi
	exit

main endp
getnums proc
	finit
	mov	edx, OFFSET greeting
	call WriteString
	call crlf
	loop1:
		mov edx, OFFSET prompt1
		call WriteString
		call ReadInt
		mov num1, eax
		call crlf
		cmp num1, upper
		jg loop1
		cmp num1, lower
		jl loop1
		jmp loop2
	loop2:
		mov edx, OFFSET prompt2
		call WriteString
		call ReadInt
		mov num2, eax
		call crlf
		mov edx, num1
		cmp num2, edx
		jge loop2
		ret

getnums endp
divi proc
	mov edx, OFFSET division
	call WriteString
	fild num1
	fild num2 ;technically using registers st(0) and st(1)
	fdiv
	call WriteFloat
	call crlf
	mov edx, OFFSET goodbye
	call Writestring
	ret
divi endp
addi proc
	mov edx, OFFSET addition
	call WriteString
	fild num1
	fild num2
	fadd
	call WriteFloat
	call crlf
	ret
addi endp
subt proc
	mov edx, OFFSET subtract
	call writestring
	push num1
	push num2
	pop edx
	pop eax
	sub eax, edx
	call WriteDec
	call crlf
	ret
subt endp
mult proc
	mov edx, OFFSET multiplication
	call WriteString
	push OFFSET num1
	push OFFSET num2
	pop ecx
	pop ebx
	mov eax, [ecx]
	mov edx, [ebx]
	mul edx
	call WriteDec
	call crlf
	ret
mult endp
end main