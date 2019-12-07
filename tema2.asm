%include "include/io.inc"

extern atoi
extern printf
extern exit
extern malloc
extern free

; Functions to read/free/print the image.
; The image is passed in argv[1].
extern read_image
extern free_image
; void print_image(int* image, int width, int height);
extern print_image

; Get image's width and height.
; Store them in img_[width, height] variables.
extern get_image_width
extern get_image_height

section .data
	use_str db "Use with ./tema2 <task_num> [opt_arg1] [opt_arg2]", 10, 0

section .bss
    task:       resd 1
    img:        resd 1
    img_width:  resd 1
    img_height: resd 1
    revient: resd 1
    task2msj: resd 1
    lenOfMsj: resd 1

section .text
global main
main:
    ; Prologue
    ; Do not modify!
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    cmp eax, 1
    jne not_zero_param

    push use_str
    call printf
    add esp, 4

    push -1
    call exit

not_zero_param:
    ; We read the image. You can thank us later! :)
    ; You have it stored at img variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 4]
    call read_image
    add esp, 4
    mov [img], eax

    ; We saved the image's dimensions in the variables below.
    call get_image_width
    mov [img_width], eax

    call get_image_height
    mov [img_height], eax

    ; Let's get the task number. It will be stored at task variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 8]
    call atoi
    add esp, 4
    mov [task], eax

    ; There you go! Have fun! :D
    mov eax, [task]
    cmp eax, 1
    je solve_task1
    cmp eax, 2
    je solve_task2
    cmp eax, 3
    je solve_task3
    cmp eax, 4
    je solve_task4
    cmp eax, 5
    je solve_task5
    cmp eax, 6
    je solve_task6
    jmp done

solve_task1:
    ;TODO Task1
    call hardcode_revient
    call bruteforce_singlebyte_xor
        push edx
        call print_image_line
        pop edx
        NEWLINE
        PRINT_UDEC 4, ecx ; key
        NEWLINE
        PRINT_UDEC 4, edx ; line
        NEWLINE
    call free_revient
    jmp done

solve_task2:
    ; TODO Task2
    call hardcode_task2msj
    call hardcode_revient
    call bruteforce_singlebyte_xor
    push edx
        push ecx
        call transform_key
        pop ecx
        mov ecx, eax
    pop edx
    inc edx

    mov DWORD[lenOfMsj], 28
    push edx
    call include_message_at_line
    add esp, 4
    
    push ecx
    call xor_the_image
    pop ecx

    push DWORD[img_height]
    push DWORD[img_width]
    push DWORD[img]
    call print_image
    add esp, 12


    call free_task2msj
    call free_revient
    jmp done

solve_task3:    
    ; TODO Task3
    mov eax, [ebp  + 12]
    mov ebx, [eax + 12] ; mesaj 
    mov ecx, [eax + 16] ; nr

    push ecx
    call atoi  ; eax = position
    add esp, 4

    push eax
    push ebx
    call morse_encrypt
    add esp, 4

                                                                                    push DWORD[img_height]
                                                                                push DWORD[img_width]
                                                                                push DWORD[img]
                                                                                call print_image
                                                                                add esp, 12
    jmp done
solve_task4:
    ; TODO Task4
    jmp done
solve_task5:
    ; TODO Task5
    jmp done
solve_task6:
    ; TODO Task6
    jmp done

    ; Free the memory allocated for the image.
    done:
        push DWORD[img]
        call free_image
        add esp, 4

        ; Epilogue
        ; Do not modify!
        xor eax, eax
        leave
        ret
    

hardcode_revient: ; aloc si hardcodez pe revient pe stiva
    enter 0, 0

    push 28
    call malloc
    add esp, 4
    
    mov ebx, 114
    mov [eax], ebx
    mov ebx, 101
    mov [eax + 4], ebx
    mov ebx, 118
    mov [eax + 8], ebx
    mov ebx, 105
    mov [eax + 12], ebx
    mov ebx, 101
    mov [eax + 16], ebx
    mov ebx, 110
    mov [eax + 20], ebx
    mov ebx, 116
    mov [eax + 24], ebx
    lea eax, [eax]
    mov [revient], eax
    leave
    ret

free_revient: ; free memory
    enter 0, 0
    push DWORD[revient]
    call free
    add esp, 4 
    leave
    ret

hardcode_task2msj:
    enter 0, 0

    push 112
    call malloc
    add esp, 4

    mov ebx, 67
    mov [eax], ebx
    mov ebx, 39
    mov [eax + 4], ebx
    mov ebx, 101
    mov [eax + 8], ebx
    mov ebx, 115
    mov [eax + 12], ebx
    mov ebx, 116
    mov [eax + 16], ebx
    mov ebx, 32
    mov [eax + 20], ebx
    mov ebx, 117
    mov [eax + 24], ebx
    mov ebx, 110
    mov [eax + 28], ebx
    mov ebx, 32
    mov [eax + 32], ebx
    mov ebx, 112
    mov [eax + 36], ebx
    mov ebx, 114
    mov [eax + 40], ebx
    mov ebx, 111
    mov [eax + 44], ebx
    mov ebx, 118
    mov [eax + 48], ebx
    mov ebx, 101
    mov [eax + 52], ebx
    mov ebx, 114
    mov [eax + 56], ebx
    mov ebx, 98
    mov [eax + 60], ebx
    mov ebx, 101
    mov [eax + 64], ebx
    mov ebx, 32
    mov [eax + 68], ebx
    mov ebx, 102
    mov [eax + 72], ebx
    mov ebx, 114
    mov [eax + 76], ebx
    mov ebx, 97
    mov [eax + 80], ebx
    mov ebx, 110
    mov [eax + 84], ebx
    mov ebx, 99
    mov [eax + 88], ebx
    mov ebx, 97
    mov [eax + 92], ebx
    mov ebx, 105
    mov [eax + 96], ebx
    mov ebx, 115
    mov [eax + 100], ebx
    mov ebx, 46
    mov [eax + 104], ebx
    mov ebx, 0
    mov [eax + 108], ebx

    lea eax, [eax]
    mov [task2msj], eax
    leave
    ret

free_task2msj:
    enter 0, 0
    push DWORD[task2msj]
    call free
    add esp, 4 
    leave
    ret

transform_key:
    enter 0, 0
    push ebx
        mov eax, [ebp + 8]
        mov ebx, 2
        imul ebx
        add eax, 3
        mov ebx, 5
        idiv ebx
        sub eax, 4
    pop ebx
    leave
    ret

print_image_line:  ; aduce mesajul de pe linia lui revient
    enter 0, 0
    pusha
    mov ebx, [ebp + 8] ; line
    mov eax, [img]
    mov edx, [img_width] ; lungime linie

    push eax
    mov eax, ebx
    mul edx
    mov edx, eax 
    mov eax, 4
    mul edx
    mov edx, eax ; nr bytes ep linie
    pop eax
    add eax,edx ; acum eax pointeaza la inceput liniei venita ca param

    mov ecx, 0
    mov ebx, [img_width]

    print_char_by_char:
        push edx
        mov eax, [img]
        add eax,edx

        lea eax, [eax + 4 * ecx + 0]
        mov edx, [eax]


        ; PRINT_UDEC 4, ecx
        cmp edx, 0
        je stop_print_char_by_char
        PRINT_CHAR  edx

        pop edx
        inc ecx
        cmp ecx, ebx
        je stop_print_char_by_char
        jmp print_char_by_char
        leave
        ret

    stop_print_char_by_char:
        pop edx
        popa
        leave
        ret

xor_the_image:  ; cripteaza imaginea cu o key data ca param
    enter 0, 0
    mov ebx, [ebp + 8] ; key of xor

    mov ecx, [img_height] ; aflu nr total de elem si l pun in ecx
    mov edx, [img_width]
    mov eax, ecx
    mul edx
    mov ecx, eax


    mov edx, 0
    xor_another_elem:
        mov eax, [img]
        lea eax, [eax + 4 * edx]

        push edx ; xor
        push ecx
        mov ecx, [eax]
        xor ecx, ebx
        mov [eax], ecx
        pop ecx
        pop edx
        
        inc edx
        cmp edx, ecx
        je stop_xor_another_elem
        jmp xor_another_elem


stop_xor_another_elem:
    leave
    ret


revient_is_onLine:  ; primeste param nr liniei si returneaza in edx daca e revient 
    enter 0, 0
    push eax
    push ebx
    push ecx

    mov ebx, [ebp +8] ; linia
    mov eax, [img]
    mov edx, [img_width] ; lungime linie

    push eax
        mov eax, ebx
        mul edx
        mov edx, eax 
        mov eax, 4
        mul edx
        mov edx, eax
    pop eax
    add eax,edx ; eax inceput linie

    mov ecx, 0
    mov ebx, [img_width]
    sub ebx, 6

search_on_line_next_char:
        push eax
            push ecx
                push eax
                    mov eax, 4
                    mul ecx
                    mov ecx, eax
                pop eax
                add eax, ecx
            pop ecx

            push ecx
                push eax
                call compare_with_revient
                add esp, 4
            pop ecx
        pop eax


        cmp edx, 1
        je true_revient_is_onLine
        inc ecx
        cmp ecx, ebx
        je false_revient_is_onLine
        jmp search_on_line_next_char


    false_revient_is_onLine:
        pop ecx
        pop ebx
        pop eax
        mov edx, 0
        leave
        ret

    true_revient_is_onLine:
        pop ecx
        pop ebx
        pop eax
        leave
        ret


compare_with_revient: ; bool  strcmp(char * a, "revient") -> edx
    enter 0, 0
    push eax
    push ebx
    push ecx

    mov eax, [esp + 8] ;pointer catre inceput linie
    mov ebx, [revient]
    mov ecx, 0

    check_next_letter:
        push eax
        push ebx
            mov ebx, [ebx + ecx]
            mov eax, [eax + ecx]
            cmp ebx, eax
            jne false_compare_with_revient
        pop ebx
        pop eax
        add ecx, 4
        
        cmp ecx, 25
        jg true_compare_with_revient
        jmp check_next_letter


    true_compare_with_revient:
        pop ecx
        pop ebx
        pop eax
        mov edx, 1
        leave
        ret

    false_compare_with_revient:
        pop ebx
        pop eax

        pop ecx
        pop ebx
        pop eax
        mov edx, 0
        leave
        ret

pos_revient_on_matrix:  ; fara param, aduce pozitia lui revient in imag daca este, altfel -1 (edx)
    enter 0, 0    
    push ecx
    mov ecx, [img_height]
    dec ecx


    check_another_line:
            push ecx
                call revient_is_onLine
            pop ecx

            cmp edx, 1
            je pos_found
            dec ecx
            cmp ecx, -1
            je pos_not_found
            jmp check_another_line


    pos_not_found:
        pop ecx
        mov edx, -1
        leave
        ret

    pos_found:
        mov edx, ecx
        pop ecx
        leave
        ret

bruteforce_singlebyte_xor:
    enter 0, 0

    mov ecx, 255
    try_anoother_key:
        push ecx  ; criptez
        call xor_the_image
        pop ecx

        call pos_revient_on_matrix ; caut revient
        cmp edx, - 1
        jne return_bruteforce_singlebyte_xor

        push ecx  ; decriptez la loc
        call xor_the_image
        pop ecx

        dec ecx
        cmp ecx, -1
        je return_bruteforce_singlebyte_xor



        jmp try_anoother_key

    return_bruteforce_singlebyte_xor:
        leave
        ret

include_message_at_pos:  ; il modifica pe eax sa pointeze la prim caracter liber
    enter 0, 0
    push ebx
    push ecx
    push edx
        mov eax, [ebp + 8] ; poz
        mov ecx, 0
        mov edx, [lenOfMsj]
        inc_msj_at_next_pos:
            push ebx
                mov ebx, [task2msj]
                lea ebx, [ebx + 4 * ecx]
                mov ebx, [ebx]
                ;                                                                             NEWLINE
                ;                                                                             PRINT_UDEC 4, [eax]
                mov [eax], ebx 
            pop ebx
            add eax, 4
            inc ecx
            cmp ecx, edx
            je stop_include_at_pos
            jmp inc_msj_at_next_pos
        stop_include_at_pos:
    pop edx
    pop ecx
    pop ebx
    leave
    ret        

include_message_at_line:
    enter 0, 0
    pusha
        mov eax, [img]
        push edx
            mov edx, [ebp + 8] ; linia
            push eax
                mov eax, [img_width]
                mul edx
                mov edx, eax
                mov eax, 4
                mul edx
                mov edx, eax
            pop eax
            add eax, edx
        pop edx

        push eax
        call include_message_at_pos
        add esp, 4
    popa
    leave
    ret

morse_encrypt:
    enter 0, 0
    mov edx, [ebp + 8]  ; msj
    mov ecx, [ebp + 12]  ; position

                                                                            mov ecx, 0  ; sa stergi
    push edx
    push eax
        mov eax, 4
        mul ecx
        mov ecx, eax
    pop eax
    pop edx

    mov eax, [img]
    add eax, ecx ; points where should i introduce the first char

    ; PRINT_UDEC 4, [eax]
    ; NEWLINE
    ; NEWLINE

    xor ecx, ecx
    ; repos:
    ;     push  [edx + ecx]
    ;     push eax
    ;     call add_morse_letter
    ;     add esp, 8
        
        ; push 32        ; spatiu dupa fiecare litera
        ; push eax
        ; call add_morse_letter
        ; add esp, 8
        
    ;     inc ecx
    ;     cmp byte[edx + ecx], 0
    ;     jne repos


        push  DWORD[edx + ecx]
        push eax
        call add_morse_letter
        add esp, 8

        mov DWORD[eax], 0         ; pun si terminator de sir
    leave
    ret


add_morse_letter:
    enter 0, 0
    push ebx
    push ecx
    push edx
    xor ebx, ebx
    mov eax, [ebp + 8]
    mov bl, [ebp + 12]


    cmp ebx, 65 ; A
        je encrypt_a
    cmp ebx, 66 ; B
        je encrypt_b
    cmp ebx, 67 ; C
        je encrypt_c
    cmp ebx, 68 ; D
        je encrypt_d
    cmp ebx, 69 ; E
        je encrypt_e
    cmp ebx, 70 ; F
        je encrypt_f
    cmp ebx, 71 ; G
        je encrypt_g
    cmp ebx, 72 ; H
        je encrypt_h
    cmp ebx, 73 ; I
        je encry4_i
    cmp ebx, 74 ; J
        je encrypt_j
    cmp ebx, 75 ; K
        je encrypt_k
    cmp ebx, 76 ; L
        je encrypt_l
    cmp ebx, 77 ; M
        je encrypt_m
    cmp ebx, 78 ; N
        je encrypt_n
    cmp ebx, 79 ; O
        je encrypt_o
    cmp ebx, 80 ; P
        je encrypt_p
    cmp ebx, 81 ; Q
        je encrypt_q
    cmp ebx, 82 ; R
        je encrypt_r
    cmp ebx, 83 ; S
        je encrypt_s
    cmp ebx, 84 ; T
        je encrypt_t
    cmp ebx, 85 ; U
        je encrypt_u
    cmp ebx, 86 ; V
        je encrypt_v
    cmp ebx, 87 ; W
        je encrypt_w
    cmp ebx, 88 ; X
        je encrypt_x
    cmp ebx, 89 ; Y
        je encrypt_y
    cmp ebx, 90 ; Z
        je encrypt_y
    cmp ebx, 32 ; blank
        je encrypt_blank
    cmp ebx, 44 ; comma
        je encrypt_comma
    return_after_morse_encrypt:
    pop edx
    pop ecx
    pop ebx
    leave
    ret

encrypt_a:
    pusha              ; hardcode letter
        push 8
        call malloc
        add esp, 4
        
        mov ebx, 46
        mov [eax], ebx
        mov ebx, 45
        mov [eax + 4], ebx
        lea eax, [eax]
        mov [task2msj], eax
        mov DWORD[lenOfMsj], 2
    popa
        push eax
        call include_message_at_pos
        add esp, 4
    push eax
    push DWORD[task2msj] ; FREE meomory
    call free
    add esp, 4 
    pop eax
    jmp return_after_morse_encrypt


    encrypt_b:
        pusha              ; hardcode letter
            push 16
            call malloc
            add esp, 4
            
            mov ebx, 45
            mov [eax], ebx
            mov ebx, 46
            mov [eax + 4], ebx
            mov ebx, 46
            mov [eax + 8], ebx
            mov ebx, 46
            mov [eax + 12], ebx
            
            lea eax, [eax]
            mov [task2msj], eax
            mov DWORD[lenOfMsj], 4
        popa
            push eax
            call include_message_at_pos
            add esp, 4
        push eax
        push DWORD[task2msj] ; FREE meomory
        call free
        add esp, 4 
        pop eax
        jmp return_after_morse_encrypt

    encrypt_c:
        pusha              ; hardcode letter
            push 16
            call malloc
            add esp, 4
            
            mov ebx, 45
            mov [eax], ebx
            mov ebx, 46
            mov [eax + 4], ebx
            mov ebx, 45
            mov [eax + 8], ebx
            mov ebx, 46
            mov [eax + 12], ebx

            lea eax, [eax]
            mov [task2msj], eax
            mov DWORD[lenOfMsj], 4
        popa
            push eax
            call include_message_at_pos
            add esp, 4
        push eax
        push DWORD[task2msj] ; FREE meomory
        call free
        add esp, 4 
        pop eax
        jmp return_after_morse_encrypt

    encrypt_d:
        pusha              ; hardcode letter
            push 12
            call malloc
            add esp, 4
            
            mov ebx, 45
            mov [eax], ebx
            mov ebx, 46
            mov [eax + 4], ebx
            mov ebx, 46
            mov [eax + 12], ebx

            lea eax, [eax]
            mov [task2msj], eax
            mov DWORD[lenOfMsj], 3
        popa
            push eax
            call include_message_at_pos
            add esp, 4
        push eax
        push DWORD[task2msj] ; FREE meomory
        call free
        add esp, 4 
        pop eax
        jmp return_after_morse_encrypt