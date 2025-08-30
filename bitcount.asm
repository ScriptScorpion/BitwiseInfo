section .data
    prompt: db "Enter number: ", 0
    returns: db " returns ", 0
    units: db " units, ", 0
    zeros: db " zeros, ", 0
    amount: db " amount of bits", 10, 0
section .bss
    num: resb 10
section .text
    global _start

_start:
    ; Print prompt
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, prompt     ; pointer to message
    mov rdx, 14         ; message length
    syscall

    ; Read number
    mov rax, 0          ; syscall: read
    mov rdi, 0          ; file descriptor: stdin
    mov rsi, num        ; buffer to store input
    mov rdx, 10         ; number of bytes to read
    syscall

    mov rsi, num
    xor rax, rax
    xor rcx, rcx
    call convert_loop

    mov rdi, [num]
    call std_print_num_dec

    mov rax, 1
    mov rdi, 1
    mov rsi, returns
    mov rdx, 9
    syscall

    ; Call onecount, zerocount, whole_amount
    mov rax, [num]
    call onecount
    mov r8, rax       

    mov rax, [num]
    call zerocount
    mov r9, rax   

    mov rax, [num]
    call whole_amount
    mov r10, rax  

    mov rdi, r8
    call std_print_num_dec

    mov rax, 1
    mov rdi, 1
    mov rsi, units
    mov rdx, 9
    syscall

    mov rdi, r9
    call std_print_num_dec

    mov rax, 1
    mov rdi, 1
    mov rsi, zeros
    mov rdx, 9
    syscall

    mov rdi, r10
    call std_print_num_dec

    mov rax, 1
    mov rdi, 1
    mov rsi, amount
    mov rdx, 16
    syscall
    ; Exit
    jmp exit        

onecount:
    ; Input: rax = number
    ; Output: rax = count of 1s
    xor rcx, rcx  
.loop1:
    test rax, rax  
    jz .done1
    test rax, 1  
    jz .skip1
    inc rcx    
.skip1:
    shr rax, 1  
    jmp .loop1
.done1:
    mov rax, rcx
    ret

zerocount:
    ; Input: rax = number
    ; Output: rax = count of 0s
    xor rcx, rcx        
.loop2:
    test rax, rax       
    jz .done2
    test rax, 1         
    jnz .skip2
    inc rcx       
.skip2:
    shr rax, 1  
    jmp .loop2
.done2:
    mov rax, rcx
    ret

whole_amount:
    ; Input: rax = number
    ; Output: rax = total bits
    xor rcx, rcx        
.loop3:
    test rax, rax    
    jz .done3
    inc rcx     
    shr rax, 1     
    jmp .loop3
.done3:
    mov rax, rcx
    ret



std_print_num_dec:
    push     rbx

    mov     rax, rdi 
    mov     rcx, 0xA 
    
    dec     rsp
    mov     rbx, 0x1

.loop:
    xor     rdx, rdx
    div     rcx 
    
    inc     rbx

    add     dl, 0x30  
    dec     rsp
    mov     BYTE [rsp], dl
    
    cmp     rax, 0x0
    jne     .loop
    
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, rsp
    mov     rdx, rbx
    syscall
    
    add     rsp, rbx

    pop     rbx

    ret 
convert_loop:
    mov cl, [rsi]     
    cmp cl, 0x0A        
    je .convert_done
    cmp cl, '0'       
    jb exit
    cmp cl, '9'
    ja exit
    
    sub cl, '0'        
    imul rax, 10     
    add rax, rcx
    
    inc rsi  
    jmp convert_loop
.convert_done:
    mov [num], rax
    ret
exit:
    mov rax, 60
    xor rdi, rdi
    syscall
