INCLUDE Irvine32.inc

FIB = 47

.data

message1 byte "Fibonacci numbers, Spencer Carlson. Whats your name?", 0
message2 byte "Hello ", 0
user byte 32 DUP(0)
fibprompt byte "How many Fibonacci numbers do you want?[1-46]", 0
yeet byte "Hey that recursion was pretty cool", 0
goodbye byte "See you later, ", 0
exitexl byte "!", 0
space byte "     ", 0
fibquant DWORD ?

.code
main proc
	
	call greet
	call DoIt
	call crlf
	mov edx, OFFSET yeet
	call WriteString
	call Crlf
	mov edx, OFFSET goodbye
	call WriteString
	mov edx, OFFSET user
	call WriteString
	mov edx, OFFSET exitexl
	call WriteString
	exit

main endp
greet PROC

	mov	edx, OFFSET message1
	call WriteString
	call Crlf
	mov edx, OFFSET user
	mov ecx, 31
	call ReadString ;read user name
	call Crlf
	mov edx, OFFSET message2
	call WriteString
	mov edx, OFFSET user ;greet them
	call WriteString
	call Crlf
	checkLoop:
		call getInt
		cmp fibquant, 46
		jg checkLoop
		cmp fibquant, 1
		jl checkLoop
	ret

greet ENDP
getInt PROC

	mov edx, OFFSET fibprompt
	call WriteString
	call ReadInt
	mov fibquant, eax ;get user input for quanitity
	call Crlf
	ret

getInt ENDP
getFib PROC

	fibCheck:
		cmp edx, 3
		jl fibLess
		jge Resume
	fibLess:
		mov eax, 1
		ret
	Resume:
		push edx
		dec edx
		call getFib
		pop edx
		push eax
		dec edx
		dec edx
		call getFib
		pop edx
		add eax, edx
		ret

getFib ENDP
DoIt PROC
	
	mov ecx, 0
	writeLoop:
		mov edx, fibquant
		call getFib
		dec fibquant
		mov edx, eax
		lineCheck:
			cmp ecx, 5
			jge linecase
			jl base
		linecase:
			call crlf
			mov ecx, 0
			jmp base
		base:
			call WriteDec
			mov edx, OFFSET space
			call WriteString
			inc ecx
			cmp fibquant, 0
			jnz writeLoop
			ret
	
DoIt ENDP
end main