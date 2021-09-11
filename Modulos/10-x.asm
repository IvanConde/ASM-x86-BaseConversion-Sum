global main
extern puts
extern gets
extern printf
extern sscanf
extern strlen

section .data
    input_usuario dq 0505

    divisor_decimal_x dq 8 ;CAMBIA SEGUN LA BASE
    indice_decimal_x dq 0

section .bss
    resto_decimal_x resq 1
    caracter_decimal_x resb 1
    resultado_decimal_x resb 50
    longitud_decimal_x resq 1
    resultado_tmp_decimal_x resb 50

section .text

main:
    call decimal_x

    mov rcx, resultado_decimal_x
    sub rsp, 32
    call puts
    add rsp, 32

ret

decimal_x:
    mov rax, [input_usuario]
    cmp rax, [divisor_decimal_x]
    jl caso_borde_dh
    
    xor rdx, rdx
    mov rbx, [divisor_decimal_x]
    idiv rbx
    mov qword[resto_decimal_x], rdx
    mov [input_usuario], rax

    add qword[resto_decimal_x], 48
    call capturar_caracter_decimal
    mov al, [resto_decimal_x]
    mov [caracter_decimal_x], al

    mov rdx, [indice_decimal_x]
    mov rcx, 1
    lea rsi, [caracter_decimal_x]
    lea rdi, [resultado_tmp_decimal_x + rdx]
    rep movsb
    add qword[indice_decimal_x], 1

    mov rax, [input_usuario]
    cmp rax, [divisor_decimal_x]
    jge decimal_x
    mov [resto_decimal_x], rax
    add qword[resto_decimal_x], 48
decimal_x_:
    call agregar_cociente_final
    call invertir_resultado_decimal_x
ret

agregar_cociente_final:
    call capturar_caracter_decimal
    mov al, [resto_decimal_x]
    mov [caracter_decimal_x], al

    mov rdx, [indice_decimal_x]
    mov rcx, 1
    lea rsi, [caracter_decimal_x]
    lea rdi, [resultado_tmp_decimal_x + rdx]
    rep movsb
ret

invertir_resultado_decimal_x:
    mov rcx, resultado_tmp_decimal_x
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [longitud_decimal_x], rax

    mov	rdi, 0
	mov	rsi, [longitud_decimal_x]
ver_fin_copia:	
    cmp	rsi, 0
    je	fin_copia
    mov	al, [resultado_tmp_decimal_x + rsi - 1]
    mov	[resultado_decimal_x + rdi], al
    dec	rsi
    inc	rdi
    jmp	ver_fin_copia	
fin_copia:
    mov	byte[resultado_decimal_x + rdi + 1], 0

ret

capturar_caracter_decimal:
    cmp qword[resto_decimal_x], 58
    je caso_a_
    cmp qword[resto_decimal_x], 59
    je caso_b_
    cmp qword[resto_decimal_x], 60
    je caso_c_
    cmp qword[resto_decimal_x], 61
    je caso_d_
    cmp qword[resto_decimal_x], 62
    je caso_e_
    cmp qword[resto_decimal_x], 63
    je caso_f_
ret
caso_a_:
    mov qword[resto_decimal_x], 65
ret
caso_b_:
    mov qword[resto_decimal_x], 66
ret
caso_c_:
    mov qword[resto_decimal_x], 67
ret
caso_d_:
    mov qword[resto_decimal_x], 68
ret
caso_e_:
    mov qword[resto_decimal_x], 69
ret
caso_f_:
    mov qword[resto_decimal_x], 70
ret

caso_borde_dh:
    mov rax, [input_usuario]
    mov [resto_decimal_x], rax
    add qword[resto_decimal_x], 48
    jmp decimal_x_
ret