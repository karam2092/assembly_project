
.model small
.stack 100h
.data
menuMsg db "=== Rock Paper Scissors ===",13,10,'$'
menu2   db "1. Rock",13,10,"2. Paper",13,10,"3. Scissors",13,10,"4. Exit",13,10,'$'
prompt  db "Your choice (1-4): $"
Rock    db "rock $"
Paper   db "Paper $"
Scissors db "Scissors $" 
invalid db "Invalid choice, try again.",13,10,'$'
tieMsg  db "Tie!",13,10,'$'
p1Msg   db "Winner is player_1",13,10,'$'
compMsg db "Winner is computer",13,10,'$'
newline db 13,10,'$'
rand_num db 0

.code
start:
    mov ax,@data
    mov ds,ax

main_loop:
    ; print menu
    mov ah,09h
    mov dx,offset menuMsg
    int 21h
    mov ah,09h
    mov dx,offset menu2
    int 21h

get_choice:
    ; prompt
    mov ah,09h
    mov dx,offset prompt
    int 21h

    ; read char
    mov ah,01h
    int 21h
    sub al,'0'
    mov cl,al         ; CL = player choice

    cmp cl,4
    je exit_prog
    cmp cl,1
    jb invalid_choice
    cmp cl,3
    ja invalid_choice

   
    mov al,rand_num ;0
    inc al ;1
    mov rand_num,al ;1
    mov dl,0
    mov bl,3
    div bl             
    mov al,ah
    inc al            
    mov dl,al          ; dL = computer choice
    
  
    
    
   cmp cl, dl
   je print_tie

   cmp cl, 1
   je p1_rock

   cmp cl, 2
   je p1_paper

   jmp p1_scissors
    
   
p1_rock:
    cmp dl, 3     ; Rock beats Scissors
    je print_player
    jmp print_comp


p1_paper:
    cmp dl, 1     ; Paper beats Rock
    je print_player
    jmp print_comp


p1_scissors:
    cmp dl, 2     ; Scissors beats Paper
    je print_player
    jmp print_comp



print_tie:
    mov ah,09h
    mov dx,offset tieMsg
    int 21h
    jmp after_result
 
   
print_player:
    mov ah,09h
    mov dx,offset p1Msg
    int 21h
    jmp after_result

    

    
print_comp:
    mov ah,09h
    mov dx,offset compMsg
    int 21h
    jmp after_result

    

    
after_result:
    mov ah,09h
    mov dx,offset newline
    int 21h
    jmp main_loop

invalid_choice:
    mov ah,09h
    mov dx,offset invalid
    int 21h
    jmp main_loop

exit_prog:
    mov ax,4C00h
    int 21h

end start

