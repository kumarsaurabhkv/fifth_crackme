puts proto
gets proto
.data
arr byte 26 DUP(0)
arr2 byte 26 DUP(0)
str1 byte "Enter your name: ",0
str2 byte "Enter password: ",0
.code
	input proc
		pop r13
		mov r12,rcx
		mov r14,rdx
		lea rcx,str1
		call puts
		mov rcx,r12
		call gets
		lea rcx,str2
		call puts
		mov rcx,r14
		call gets
		push r13
		ret
	input endp

	check_len proc
		mov rsi,rcx
		xor rax,rax
		xor rbx,rbx
		run1:
			cmp byte ptr[rsi],0
			je end_run1
			inc rsi
			inc rbx
			jmp run1
		end_run1:
		cmp rbx,5
		jge correct_len
		ret
		correct_len:
		mov rax,1
		ret
	check_len endp

	check_name_only_capital_letters proc
		mov rsi,rcx
		xor rax,rax
		run2:
			mov bl,[rsi]
			cmp bl,'Z'
			jle next
			ret
			next:
			cmp bl,'A'
			jge next2
			ret
			next2:
			inc rsi
			cmp byte ptr[rsi],0
			jne run2
		mov rax,1
		ret
	check_name_only_capital_letters endp

	check_password proc
		mov r11,rdx
		mov rsi,rcx
		mov rdi,offset arr
		call init_arr
		mov rsi,r11
		mov rdi,offset arr2
		call init_arr
		mov rsi,offset arr
		mov rdi,offset arr2
		mov bl,26
		run_check_pass:
			mov al,[rsi]
			mov ah,[rdi]
			cmp al,ah
			je next_check_pass
			xor rax,rax
			ret
			next_check_pass:
			inc rsi
			inc rdi
			dec bl
			jnz run_check_pass
		mov rax,1
		ret
	check_password endp

	init_arr proc
		xor rbx,rbx
		run_init:
			mov al,[rsi]
			cmp al,'A'
			jl digit
			sub al,'A'
			jmp next_init
			digit:
			sub al,'0'
			next_init:
			mov bl,al
			add rdi,rbx
			inc byte ptr[rdi]
			sub rdi,rbx
			inc rsi
			cmp byte ptr[rsi],0
			jne run_init
		ret
	init_arr endp
end