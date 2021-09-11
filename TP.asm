global main
extern puts
extern gets
extern printf
extern sscanf
extern strlen
extern itoa

section .data
    msj_ingreso0 db "Por favor, elija una de las opciones (1 a 5):",0
    msj_ingreso1 db "Ingrese un numero entero de base %lld (Maximo 15 caracteres):",10,0
    msj_ingreso2 db "Que desea realizar con el numero ingresado?",0
    msj_ingreso3 db "Por favor, elija una de las opciones (1 o 2):",0
    msj_ingreso4 db "Por favor, seleccione el cambio de base que desee realizar (1 a 4):",0
    nueva_linea db "",13,0
    msj_separador db "_________________________________________________________________________________",0
    msj_opcion_base2 db "[1] Base 2.",0
    msj_opcion_base4 db "[2] Base 4.",0
    msj_opcion_base8 db "[3] Base 8.",0
    msj_opcion_base10 db "[4] Base 10.",0
    msj_opcion_base16 db "[5] Base 16.",0
    msj_opcion_cdb db "[1] Realizar un cambio de base al numero ingresado.",0
    msj_opcion_sum db "[2] Obtener la sumatoria en base 10 de los digitos del numero ingresado.",0
    msj_opcion_base db "Realizar el cambio de base del numero %s en base %lld a base %lld.",10,0
    msj_contador db "[%lld] ",0
    msj_parte1_salida db "Resultado: %s|%lld --> %s%lld|%lld.",0
    msj_parte1_salida_ db "Resultado: %s|%lld --> %s%s|%lld.",0
    msj_sumatoria db "Resultado Sumatoria: %lld.",0
    msj_explicacion_menu1 db "Por favor, seleccione la opcion correspondiente para ingresar un numero en la",0
    msj_explicacion_menu2 db "base deseada.",0
    msj_explicacion_menu3 db "Luego debera ingresar un numero de acuerdo a la base elegida. (Solo enteros)",0
    msj_explicacion_menu4 db "Una ves ingresado el numero, usted tendra 2 opciones, la primera consiste en",0
    msj_explicacion_menu5 db "poder realizar la conversion entre las bases indicadas y la segunda permite",0
    msj_explicacion_menu6 db "obtener la sumatoria en base 10 de los digitos del numero ingresado.",0

    format_input db	"%lld",0

    tabla_base2 db "01",0
    tabla_base4 db "0123",0
    tabla_base8 db "01234567",0
    tabla_base10 db "0123456789",0
    tabla_base16 db "0123456789ABCDEFabcdef",0

    ocurrio_caso_especial db "N",0
    numero_es_negativo db "N",0
    char_cero db "0",0
    char_menos db "-",0

    ; Exclusivo X a Decimal
    indice_x_decimal dq 0
    output_x_decimal dq 0

    ; Exclusivo Decimal a X
    indice_decimal_x dq 0

    ; Exclusivo Sumatoria Digitos
	indice_sum dq 0
	sum_resultado dq 0
	contador_sum dq 0
	len_sum dq 1

section .bss
    input_usuario_str resb 21
    input_usuario_int resq 1
    input_valido resb 1

    base_elegida resq 1
    numero_usuario_str resb 21
    base_destino resq 1
    numero_usuario_int resq 1

    len_usuario resq 1
    len_tabla_base resq 1
    indice1 resq 1
    indice2 resq 1
    tabla_base_auxiliar resb 30
    base_elegida_aux resq 1
    contador_opciones resq 1

    val_rango_1 resq 1
    val_rango_2 resq 1

    pos_base_dos resq 1
    pos_base_cuatro resq 1
    pos_base_ocho resq 1
    pos_base_diez resq 1
    pos_base_dieciseis resq 1

    ; Exclusivo X a Decimal
    longitud_x_decimal resq 1
    contador_x_decimal resq 1
    tmp_x_decimal resb 4
    input_num_x_decimal resq 1
    potencia_x_decimal resq 1

    ; Exclusivo Decimal a X
    resto_decimal_x resq 1
    caracter_decimal_x resb 1
    resultado_decimal_x resb 65
    longitud_decimal_x resq 1
    resultado_tmp_decimal_x resb 65

    ; Exclusivo Sumatoria Digitos
    sum_str resb 21
	sum_char resb 2
	sum_int resq 1

section .text

main:
    call interfaz_menu0
    call evaluar_input_menu
ret

interfaz_menu0:
    mov rcx, msj_separador
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_menu1
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_menu2
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_menu3
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_menu4
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_menu5
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_menu6
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

interfaz_menu1:
    mov rcx, msj_opcion_base2
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_opcion_base4
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_opcion_base8
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_opcion_base10
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_opcion_base16
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_ingreso0
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, input_usuario_str
    sub rsp, 32
    call gets
    add rsp, 32

    mov rcx, msj_separador
    sub rsp, 32
    call puts
    add rsp, 32

    mov qword[val_rango_1], 1
    mov qword[val_rango_2], 5
    call val_input
    cmp byte[input_valido], 'N'
    je interfaz_menu1

    mov rcx, [input_usuario_int]
    mov [base_elegida], rcx
    call identificar_base_input

interfaz_menu2:
    mov rcx, msj_ingreso1
    mov rdx, [base_elegida]
    sub rsp, 32
    call printf
    add rsp, 32

    mov rcx, input_usuario_str
    sub rsp, 32
    call gets
    add rsp, 32

    mov rcx, msj_separador
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, input_usuario_str
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [len_usuario], rax

    call comprobar_numero_negativo

    call validar_max_longitud
    cmp byte[input_valido], 'N'
    je interfaz_menu2

    call fue_negativo

    call identificar_base_val
    cmp byte[input_valido], 'N'
    je interfaz_menu2

    mov rcx, [len_usuario]
    lea rsi, [input_usuario_str]
    lea rdi, [numero_usuario_str]
    rep movsb

interfaz_menu3:
    mov rcx, msj_ingreso2
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_opcion_cdb
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_opcion_sum
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_ingreso3
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, input_usuario_str
    sub rsp, 32
    call gets
    add rsp, 32

    mov rcx, msj_separador
    sub rsp, 32
    call puts
    add rsp, 32

    mov qword[val_rango_1], 1
    mov qword[val_rango_2], 2
    call val_input
    cmp byte[input_valido], 'N'
    je interfaz_menu3
ret

val_input:
	mov	rcx, input_usuario_str
	mov	rdx, format_input
	mov	r8, input_usuario_int
	sub	rsp, 32
	call sscanf
	add	rsp, 32

	cmp rax, 1
	jl input_invalido

    mov rdx, [val_rango_1]
    cmp	[input_usuario_int], rdx
	jl input_invalido
    mov rdx, [val_rango_2]
	cmp [input_usuario_int], rdx
	jg input_invalido

    mov	byte[input_valido], 'S'
ret
input_invalido:
	mov	byte[input_valido], 'N'
ret

identificar_base_input:
    cmp qword[base_elegida], 1
    je base_input2
    cmp qword[base_elegida], 2
    je base_input4
    cmp qword[base_elegida], 3
    je base_input8
    cmp qword[base_elegida], 4
    je base_input10
    cmp qword[base_elegida], 5
    je base_input16
base_input2:
    mov qword[base_elegida], 2
ret
base_input4:
    mov qword[base_elegida], 4
ret
base_input8:
    mov qword[base_elegida], 8
ret
base_input10:
    mov qword[base_elegida], 10
ret
base_input16:
    mov qword[base_elegida], 16
ret

identificar_base_val:
    cmp qword[base_elegida], 2
    je base_dos_elegida
    cmp qword[base_elegida], 4
    je base_cuatro_elegida
    cmp qword[base_elegida], 8
    je base_ocho_elegida
    cmp qword[base_elegida], 10
    je base_diez_elegida
    cmp qword[base_elegida], 16
    je base_dieciseis_elegida
base_dos_elegida:
    mov qword[base_elegida_aux], 2

    mov rcx, tabla_base2
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [len_tabla_base], rax

    mov rcx, [len_tabla_base]
    lea rsi, [tabla_base2]
    lea rdi, [tabla_base_auxiliar]
    rep movsb

    jmp val_input_base
base_cuatro_elegida:
    mov qword[base_elegida_aux], 4

    mov rcx, tabla_base4
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [len_tabla_base], rax

    mov rcx, [len_tabla_base]
    lea rsi, [tabla_base4]
    lea rdi, [tabla_base_auxiliar]
    rep movsb

    jmp val_input_base
base_ocho_elegida:
    mov qword[base_elegida_aux], 8

    mov rcx, tabla_base8
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [len_tabla_base], rax

    mov rcx, [len_tabla_base]
    lea rsi, [tabla_base8]
    lea rdi, [tabla_base_auxiliar]
    rep movsb

    jmp val_input_base
base_diez_elegida:
    mov qword[base_elegida_aux], 10

    mov rcx, tabla_base10
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [len_tabla_base], rax

    mov rcx, [len_tabla_base]
    lea rsi, [tabla_base10]
    lea rdi, [tabla_base_auxiliar]
    rep movsb

    jmp val_input_base
base_dieciseis_elegida:
    mov qword[base_elegida_aux], 22

    mov rcx, tabla_base16
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [len_tabla_base], rax

    mov rcx, [len_tabla_base]
    lea rsi, [tabla_base16]
    lea rdi, [tabla_base_auxiliar]
    rep movsb

    jmp val_input_base

val_input_base:
    mov qword[indice1], 0
    mov qword[indice2], 0
val_input_base_:
    mov rbx, [indice1]
    mov rdx, [indice2]
    mov rcx, 1
    lea rsi, [input_usuario_str + rbx]
    lea rdi, [tabla_base_auxiliar + rdx]
    repe cmpsb
    je es_igual

    add qword[indice2], 1
    mov rdx, [base_elegida_aux]
    cmp [indice2], rdx
    je input_invalido
    jmp val_input_base_
es_igual:
    mov qword[indice2], 0
    add qword[indice1], 1
    mov rcx, [len_usuario]
    cmp [indice1], rcx
    je input_es_valido
    jmp val_input_base_
input_es_valido:
    mov	byte[input_valido], 'S'
ret

validar_max_longitud:
    cmp qword[len_usuario], 15
    jg input_invalido
    jmp input_es_valido

comprobar_numero_negativo:
    cmp byte[input_usuario_str], '-' 
    jne fin_check_negativo
    mov byte[numero_es_negativo], 'S'

    mov rcx, 1
    lea rsi, [char_cero]
    lea rdi, [input_usuario_str]
    rep movsb

    dec qword[len_usuario]
fin_check_negativo:
ret

fue_negativo:
    cmp byte[numero_es_negativo], 'S'
    jne fin_fue_negativo
    inc qword[len_usuario]
fin_fue_negativo:
ret

evaluar_input_menu:
    cmp	qword[input_usuario_int], 1
	je interfaz_submenu_1
    cmp	qword[input_usuario_int], 2
	je interfaz_submenu_2

interfaz_submenu_1:
    mov rcx, msj_ingreso4
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

    mov qword[contador_opciones], 0
    call opciones_conversion_base

    mov rcx, input_usuario_str
    sub rsp, 32
    call gets
    add rsp, 32

    mov rcx, msj_separador
    sub rsp, 32
    call puts
    add rsp, 32

    mov qword[val_rango_1], 1
    mov qword[val_rango_2], 4
    call val_input
    cmp byte[input_valido], 'N'
    je interfaz_submenu_1

    call identificar_base_destino
    call caso_especial_1
    call caso_especial_2
    cmp byte[ocurrio_caso_especial], 'S'
    je interfaz_submenu_1_
    call conversion_base

interfaz_submenu_1_:
    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_separador
    sub rsp, 32
    call puts
    add rsp, 32
ret

opciones_conversion_base:
    call imprimir_opcion_base2
    call imprimir_opcion_base4
    call imprimir_opcion_base8
    call imprimir_opcion_base10
    call imprimir_opcion_base16
ret
imprimir_opcion_base2:
    cmp qword[base_elegida], 2
    je fin_impresion_bases

    add qword[contador_opciones], 1
    mov rcx, msj_contador
    mov rdx, [contador_opciones]
    sub rsp, 32
    call printf
    add rsp, 32

    mov rcx, msj_opcion_base
    mov rdx, numero_usuario_str
    mov r8, [base_elegida]
    mov r9, 2
    sub rsp, 32
    call printf
    add rsp, 32

    mov rcx, [contador_opciones]
    mov [pos_base_dos], rcx
ret
imprimir_opcion_base4:
    cmp qword[base_elegida], 4
    je fin_impresion_bases

    add qword[contador_opciones], 1
    mov rcx, msj_contador
    mov rdx, [contador_opciones]
    sub rsp, 32
    call printf
    add rsp, 32

    mov rcx, msj_opcion_base
    mov rdx, numero_usuario_str
    mov r8, [base_elegida]
    mov r9, 4
    sub rsp, 32
    call printf
    add rsp, 32

    mov rcx, [contador_opciones]
    mov [pos_base_cuatro], rcx
ret
imprimir_opcion_base8:
    cmp qword[base_elegida], 8
    je fin_impresion_bases

    add qword[contador_opciones], 1
    mov rcx, msj_contador
    mov rdx, [contador_opciones]
    sub rsp, 32
    call printf
    add rsp, 32

    mov rcx, msj_opcion_base
    mov rdx, numero_usuario_str
    mov r8, [base_elegida]
    mov r9, 8
    sub rsp, 32
    call printf
    add rsp, 32

    mov rcx, [contador_opciones]
    mov [pos_base_ocho], rcx
ret
imprimir_opcion_base10:
    cmp qword[base_elegida], 10
    je fin_impresion_bases

    add qword[contador_opciones], 1
    mov rcx, msj_contador
    mov rdx, [contador_opciones]
    sub rsp, 32
    call printf
    add rsp, 32

    mov rcx, msj_opcion_base
    mov rdx, numero_usuario_str
    mov r8, [base_elegida]
    mov r9, 10
    sub rsp, 32
    call printf
    add rsp, 32

    mov rcx, [contador_opciones]
    mov [pos_base_diez], rcx
ret
imprimir_opcion_base16:
    cmp qword[base_elegida], 16
    je fin_impresion_bases

    add qword[contador_opciones], 1
    mov rcx, msj_contador
    mov rdx, [contador_opciones]
    sub rsp, 32
    call printf
    add rsp, 32

    mov rcx, msj_opcion_base
    mov rdx, numero_usuario_str
    mov r8, [base_elegida]
    mov r9, 16
    sub rsp, 32
    call printf
    add rsp, 32

    mov rcx, [contador_opciones]
    mov [pos_base_dieciseis], rcx
ret
fin_impresion_bases:
ret

identificar_base_destino:
	mov	rcx, input_usuario_str
	mov	rdx, format_input
	mov	r8, input_usuario_int
	sub	rsp, 32
	call sscanf
	add	rsp, 32

    mov rdx, [input_usuario_int]
    cmp [pos_base_dos], rdx
    je base_destino_dos
    cmp [pos_base_cuatro], rdx
    je base_destino_cuatro
    cmp [pos_base_ocho], rdx
    je base_destino_ocho
    cmp [pos_base_diez], rdx
    je base_destino_diez
    cmp [pos_base_dieciseis], rdx
    je base_destino_dieciseis
base_destino_dos:
    mov qword[base_destino], 2
ret
base_destino_cuatro:
    mov qword[base_destino], 4
ret
base_destino_ocho:
    mov qword[base_destino], 8
ret
base_destino_diez:
    mov qword[base_destino], 10
ret
base_destino_dieciseis:
    mov qword[base_destino], 16
ret

caso_especial_1:
    ;Si base destino 10 -> solo utilizo x -> 10
    cmp qword[base_elegida], 10
    je caso_especial_1_fin
    cmp qword[base_destino], 10
    jne caso_especial_1_fin

    call x_decimal
    mov	byte[ocurrio_caso_especial], 'S'

    mov byte[char_menos], ''
    call fue_negativo_

    mov rcx, msj_parte1_salida
    mov rdx, numero_usuario_str
    mov r8, [base_elegida]
    mov r9, char_menos
    push qword[base_destino]
    push qword[output_x_decimal]
    sub rsp, 32
    call printf
    add rsp, 32
    pop rcx
    pop rcx
    xor rcx, rcx
caso_especial_1_fin:
ret

caso_especial_2:
    ;Si base elegida 10 -> solo utilizo 10 -> x
    cmp qword[base_elegida], 10
    jne caso_especial_2_fin

	mov	rcx, numero_usuario_str
	mov	rdx, format_input
	mov	r8, numero_usuario_int
	sub	rsp, 32
	call sscanf
	add	rsp, 32

    call decimal_x
    mov	byte[ocurrio_caso_especial], 'S'

    mov byte[char_menos], ''
    call fue_negativo_

    mov rcx, msj_parte1_salida_
    mov rdx, numero_usuario_str
    mov r8, [base_elegida]
    mov r9, char_menos
    push qword[base_destino]
    push resultado_decimal_x
    sub rsp, 32
    call printf
    add rsp, 32
    pop rcx
    pop rcx
    xor rcx, rcx
caso_especial_2_fin:
ret

conversion_base:
    call x_decimal

    mov rdx, [output_x_decimal]
    mov [numero_usuario_int], rdx

    call decimal_x

    mov byte[char_menos], ''
    call fue_negativo_

    mov rcx, msj_parte1_salida_
    mov rdx, numero_usuario_str
    mov r8, [base_elegida]
    mov r9, char_menos
    push qword[base_destino]
    push resultado_decimal_x
    sub rsp, 32
    call printf
    add rsp, 32
    pop rcx
    pop rcx
    xor rcx, rcx
ret

fue_negativo_:
    cmp byte[numero_es_negativo], 'S'
    jne fin_fue_negativo_

    mov byte[char_menos], '-'
    mov rcx, 1
    lea rsi, [char_menos]
    lea rdi, [numero_usuario_str]
    rep movsb
fin_fue_negativo_:
ret

x_decimal:
    mov rcx, numero_usuario_str
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
    lea rsi, [numero_usuario_str + rdx]
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
    imul rax, [base_elegida]
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

decimal_x:
    mov rax, [numero_usuario_int]
    cmp rax, [base_destino]
    jl caso_borde_dh

    xor rdx, rdx
    mov rbx, [base_destino]
    idiv rbx
    mov qword[resto_decimal_x], rdx
    mov [numero_usuario_int], rax

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

    mov rax, [numero_usuario_int]
    cmp rax, [base_destino]
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
    mov rax, [numero_usuario_int]
    mov [resto_decimal_x], rax
    add qword[resto_decimal_x], 48
    jmp decimal_x_
ret

interfaz_submenu_2:
    cmp qword[base_elegida], 10
    je interfaz_submenu_2_
    jmp interfaz_submenu_2__

interfaz_submenu_2_:
    mov	rcx, numero_usuario_str
	mov	rdx, format_input
	mov	r8, numero_usuario_int
	sub	rsp, 32
	call sscanf
	add	rsp, 32
    jmp interfaz_submenu_2___

interfaz_submenu_2__:
    call x_decimal
    mov rdx, [output_x_decimal]
    mov [numero_usuario_int], rdx

interfaz_submenu_2___:
    call sumatoria_digitos
    cmp byte[numero_es_negativo], 'S'
    jne interfaz_submenu_2____
    neg qword[sum_resultado]

interfaz_submenu_2____:
	mov rcx, msj_sumatoria
	mov rdx, [sum_resultado]
	sub	rsp, 32
	call printf
	add	rsp, 32

    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_separador
    sub rsp, 32
    call puts
    add rsp, 32
ret

sumatoria_digitos:
	mov qword[sum_str], "0"
sumatoria_digitos_:
	mov rbx, [indice_sum]
	mov rcx, 1
	lea rsi, [sum_str + rbx]
	lea rdi, [sum_char]
	rep movsb

	mov	rcx, sum_char
	mov	rdx, format_input
	mov	r8, sum_int
	sub	rsp, 32
	call sscanf
	add	rsp, 32

	mov rcx, [sum_int]
	add [sum_resultado], rcx

	add qword[indice_sum], 1
	mov rcx, [len_sum]
	cmp [indice_sum], rcx
	je sumatoria_digitos__
	jmp sumatoria_digitos_
sumatoria_digitos__:
	add qword[contador_sum], 1
	mov rcx, [numero_usuario_int]
	cmp [contador_sum], rcx
	jg fin_sum

	mov	rcx, [contador_sum]
	mov	rdx, sum_str
	mov	r8, 10
	sub	rsp, 32
	call itoa
	add	rsp, 32

	mov rcx, sum_str
    sub	rsp, 32
	call strlen
	add	rsp, 32
	mov [len_sum], rax

	mov qword[indice_sum], 0
	jmp sumatoria_digitos_
fin_sum:
ret