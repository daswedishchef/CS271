INCLUDE Irvine32.inc

upper = 200
lower = 10
upper1 = 900
lower1 = 100

.data
greeting byte "Hello! This program was brought to you by Spencer Carlson", 0
prompt1 byte "Please enter a number between ten and two hundred: ", 0
unsort byte "--- Unsorted List ---", 0
sorted byte "--- Sorted List ---", 0
avgprompt byte "Average: ", 0
medprompt byte "Median: ", 0
spacing byte ", ", 0
arr DWORD upper DUP(0)
goodbye byte "Until next time!", 0
num1 DWORD ?
num2 DWORD ?
req4 DWORD ?
arri DWORD ?
arrj DWORD ?
arrk DWORD ?

.code
main proc
	call getnums
	call randomize
	push OFFSET arr
	push upper
	call fillarr
	mov edx, OFFSET unsort
	call writestring
	call crlf
	call printarr
	call crlf
	mov edx, OFFSET sorted
	call writestring
	call crlf
	call sort
	call printarr
	call crlf
	call getavg
	call getmed
	call crlf
	mov edx, OFFSET goodbye
	call writestring
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
	ret
getnums endp
fillarr proc
	pushad
	mov eax, num1
	mov edx, 4
	mul edx
	mov num2, eax
	mov ebp, esp
	mov edi, [ebp+40]
	mov ebx, 0
	mov ecx, [ebp+36]
	loop2:
		mov eax, upper1
		call RandomRange
		add eax, lower1
		mov [edi+ebx], eax
		add ebx, 4
		cmp num2, ebx
		jg loop2
	popad
	ret
fillarr endp
getavg proc
	pushad
	mov edx, OFFSET avgprompt
	call writestring
	mov ebp, esp
	mov edi, [ebp+40]
	mov ebx, 0
	mov ecx, [ebp+36]
	loop3:
		add eax, [edi+ebx]
		add ebx, 4
		cmp num2, ebx
		jg loop3
	cdq
	div num1
	call writedec
	call crlf
	popad
	ret
getavg endp
getmed proc
	pushad
	mov edx, OFFSET medprompt
	call writestring
	mov ebp, esp
	mov edi, [ebp+40]
	mov eax, num1
	mov ecx, 2
	cdq
	div ecx
	mov ecx, 4
	mul ecx
	mov ecx, [edi+eax]
	mov eax, ecx
	call writedec
	call crlf
	popad
	ret
getmed endp
sort proc
	pushad
	mov ecx, num2
	sub ecx, 4     ;request-1
	mov req4, ecx
	mov ebp, esp
	mov edi, [ebp+40]
	mov ebx, 0	
	mov arrk, ebx ;this is k
	outloop:
		mov edx, arrk
		mov arri, edx
		add edx, 4
		mov arrj, edx
	innerloop:
		mov ecx, arri
		mov edx, [edi+ecx]
		mov ecx, arrj
		mov eax, [edi+ecx]
		cmp edx, eax
		jle less
		mov edx, arrj
		mov arri, edx
	less:
		add arrj, 4
		mov edx, num2
		cmp arrj, edx
		jl innerloop
	mov ecx, arri
	mov eax, [edi+ecx]
	mov ecx, arrk
	mov ebx, [edi+ecx]
	mov [edi+ecx], eax
	mov ecx, arri
	mov [edi+ecx], ebx
	add arrk, 4
	mov ecx, req4
	cmp arrk, ecx
	jl outloop
	popad
	ret
sort endp
printarr proc
	pushad
	mov ebp, esp
	mov edi, [ebp+40]
	mov ebx, 0
	mov ecx, 0
	loop4:
		mov eax, [edi+ebx]
		call writedec
		mov edx, OFFSET spacing
		call writestring
		add ebx, 4
		inc ecx
		cmp num2, ebx
		jg newline
		popad
		ret
		newline:
			mov eax, 10
			cmp ecx, eax
			jl loop4
			call crlf
			mov ecx, 0
			jmp loop4
printarr endp
end main