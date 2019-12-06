%include "include/io.inc"

extern atoi
extern printf
extern exit
extern malloc

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
    ; push 23
    ; call xor_the_image
    ; add esp, 4
    

    ; push 25
    ; call print_image_line
    ; add esp, 4
    ; NEWLINE
    NEWLINE
    push 25
    call revient_is_onLine
    add esp, 4



    jmp done










solve_task2:
    ; TODO Task2
    jmp done
solve_task3:
    ; TODO Task3
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
    

hardcode_revient:
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

print_image_line:
    enter 0, 0
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
    leave
    ret

xor_the_image:
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

    leave
    ret

stop_xor_another_elem:
    leave
    ret


revient_is_onLine:
    enter 0, 0
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


    push eax
    call compare_with_revient
    add eax, 4

    leave
    ret


compare_with_revient: ; bool  strcmp(int * a, "revient") -> edx
    enter 0, 0
    mov edx, 1

    mov eax, [esp + 8] ;pointer catre inceput linie
    mov ebx, [revient]

    push eax
    push ebx
    mov ebx, [ebx + 0]
    mov eax, [eax + 0]

    pop ebx
    pop eax
    
    leave
    ret