global main
extern puts
extern gets
extern printf
extern sscanf
extern strlen

section .data
    input_usuario db "3215470",0
    format_input db "%lli",0
    ; Exclusivo X a Decimal
    indice_x_decimal dq 0
    output_x_decimal dq 0

section .bss
    base_x_decimal resq 1
    ; Exclusivo X a Decimal
    longitud_x_decimal resq 1
    contador_x_decimal resq 1
    tmp_x_decimal resb 4
    input_num_x_decimal resq 1
    potencia_x_decimal resq 1

section .text

main:
    mov qword[base_x_decimal], 8
    call x_decimal
    
    mov rcx, format_input
    mov rdx, [output_x_decimal]
    sub rsp, 32
    call printf
    add rsp, 32
ret

x_decimal:
    mov rcx, input_usuario ;CAMBIAR SEGUN INPUT
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [longitud_x_decimal], rax
    
    mov rcx, [longitud_x_decimal]
    sub rax, 1
    mov [potencia_x_decimal], rax
x_decimal_:
    mov	qword[contador_x_decimal], rcx

    mov	qword[tmp_x_decimal], 0

    mov rdx, [indice_x_decimal]
    mov rcx, 1
    lea rsi, [input_usuario + rdx]
    lea rdi, [tmp_x_decimal]
    rep movsb

    call capturar_caracter_hexa

	mov	rcx, tmp_x_decimal
	mov	rdx, format_input
	mov	r8, input_num_x_decimal
	sub	rsp, 32
	call sscanf
	add	rsp, 32

    call realizar_sumatoria

    mov	rcx, qword[contador_x_decimal]
    add Qword[indice_x_decimal], 1
    loop x_decimal_
ret
realizar_sumatoria:
    mov rcx, [potencia_x_decimal]
    cmp rcx, 0
    je potencia_cero
    mov rax, 1
f_loop:
    imul rax, [base_x_decimal] ;BASE VARIA
    dec rcx
    cmp rcx, 0
    jg f_loop

    imul rax, qword[input_num_x_decimal]
    add qword[output_x_decimal], rax
    sub qword[potencia_x_decimal], 1
ret
potencia_cero:
    mov rax, 1
    imul rax, qword[input_num_x_decimal]
    add qword[output_x_decimal], rax
ret
capturar_caracter_hexa:
    cmp qword[tmp_x_decimal], 'A'
    je caso_a
    cmp qword[tmp_x_decimal], 'a'
    je caso_a
    cmp qword[tmp_x_decimal], 'B'
    je caso_b
    cmp qword[tmp_x_decimal], 'b'
    je caso_b
    cmp qword[tmp_x_decimal], 'C'
    je caso_c
    cmp qword[tmp_x_decimal], 'c'
    je caso_c
    cmp qword[tmp_x_decimal], 'D'
    je caso_d
    cmp qword[tmp_x_decimal], 'd'
    je caso_d
    cmp qword[tmp_x_decimal], 'E'
    je caso_e
    cmp qword[tmp_x_decimal], 'e'
    je caso_e
    cmp qword[tmp_x_decimal], 'F'
    je caso_f
    cmp qword[tmp_x_decimal], 'f'
    je caso_f
ret
caso_a:
    mov qword[tmp_x_decimal], '10'
ret
caso_b:
    mov qword[tmp_x_decimal], '11'
ret
caso_c:
    mov qword[tmp_x_decimal], '12'
ret
caso_d:
    mov qword[tmp_x_decimal], '13'
ret
caso_e:
    mov qword[tmp_x_decimal], '14'
ret
caso_f:
    mov qword[tmp_x_decimal], '15'
ret