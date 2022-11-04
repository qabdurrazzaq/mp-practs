.model small
.stack
.data
msg1 db 10,13, "Mouse driver present"
.code
disp macro xx
mov ah,09
lea dx,xx
int 21h
endm
.startup
mov ax,0000   ;mouse driver check
int 33h

cmp ax,00h
je last
disp msg1

mov ax,0004  ;mouse cursor position
mov cx,0
mov dx,0
int 33h
mov ax, 0007 ;set horizontal limit
mov cx,0010
mov dx,055h
int 33h

mov ax, 0008 ;set vertical limit

mov cx,0010
mov dx,055h
int 33h

pixel:
mov ax,0001 ;display mouse cursor
int 33h

mov ax,0003
int 33h
cmp bx,01 ;left button
je left
jmp right

left:
mov bx,0011h   ;set graphics mode
int 10h

mov ah,0ch ;display pixel on screen
int 10h
right:
mov ax,0001
int 33h
cmp bx,02
je last
jmp pixel

last:
mov ax,00 ;set text mode
int 10h

	

end
