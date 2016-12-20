 
data segment

make_dot db 0    
x_dot_index db 0
y_dot_index db 0
x_float_count db 0
y_float_count db 0
_TEN	dw 10d
x        dw 0    
y        dw 0
buffer   db 6 dup(0),'$'
lenth    dw 0
operand1 db 0
operand2 db 0
key      db 0 
of       db 0 
ng       db 0
xsighn   db 0
ysighn   db 0
;---------------------------------------------------
 
;print lines
;---------------------------------------------------                           
    l0   db 201,21 dup(205),187,'$'
	l8	 db 186,21 dup(' '),186,'$';second line
	
    l1   db 186,'   ',201,13 dup(205),187,'   ',186,'$'
    l2   db 186,'   ',186,13 dup(' '),186,'   ',186,'$'
    l3   db 186,'   ',200,13 dup(205),188,'   ',186,'$'
	
    l4   db 186,' ',218,196,191,' ',218,196,191,' ',218,196,191,' ',218,196,191,' ',218,196,191,' ',186,'$'
    l4_2 db 186,' ',218,196,196,196,196,196,191,' ',218,196,191,' ',218,196,191,' ',179,' ',179,' ',186,'$'
	l5   db 186,' ',179,' ',179,' ',179,' ',179,' ',179,' ',179,' ',179,' ',179,' ',179,' ',179,' ',186,'$'
	l5_2 db 186,' ',192,196,217,' ',192,196,217,' ',192,196,217,' ',192,196,217,' ',179,' ',179,' ',186,'$'
    l5_3 db 186,' ',179,' ',' ',' ',' ',' ',179,' ',179,' ',179,' ',179,' ',179,' ',179,' ',179,' ',186,'$'
	l6   db 186,' ',192,196,217,' ',192,196,217,' ',192,196,217,' ',192,196,217,' ',192,196,217,' ',186,'$'
	l6_2 db 186,' ',192,196,196,196,196,196,217,' ',192,196,217,' ',192,196,217,' ',192,196,217,' ',186,'$'
    l7   db 200,21 dup(205),188,'$'
;---------------------------------------------------                           
ends

;---------------------------------------------------
gotoxy macro x,y        ;move cursor
       pusha
       mov dl,x
       mov dh,y
       mov bx,0
       mov ah,02h
       int 10h 
       popa
endm
;--------------------------------------------------- 
putstr macro buffer     ;print string
       pusha
       mov ah,09h
       mov dx,offset buffer
       int 21h 
       popa
endm
;---------------------------------------------------
putch  macro char,color ;print character
       pusha
       mov ah,09h
       mov al,char
       mov bh,0
       mov bl,color
       mov cx,1
       int 10h 
       popa
endm
;---------------------------------------------------
clear  macro buf
       lea si,buf
       mov [si],' '
       mov [si+1],' '
       mov [si+2],' '
       mov [si+3],' '
       mov [si+4],' '
	   mov [si+5],' '
       gotoxy 15,3
       putstr buf
endm
;---------------------------------------------------
initmouse macro
        mov ax,0
        int 33h
endm
;---------------------------------------------------
getmouse macro key
         
        local l1,en,en1,en2
        local r1,c12,c13,c14,c15
        local r2,c21,c22,c23,c24
        local r3,c31,c32,c33,c34
		local r3_1
        local r4,c41,c42,c43,c44
		local r5,c51,c52
		local r6
		

        pusha     ;push all registers
        l1:
          mov ax,1    ;show mouse
          int 33h
          mov ax,3    ;get pose
          int 33h
          cmp bx,1
          jne l1
         
        ;....................
        r1:
        cmp cx,064h
        jna r2
        cmp cx,074h
         ja r2
            
           cmp dx,2ch
            jb c13
           cmp dx,3ch
            ja c13
           mov [key],'7'
           jmp en1
           c13:
           cmp dx,44h
            jb c14
           cmp dx,54h
            ja c14
           mov [key],'4'
           jmp en1
           c14:
           cmp dx,5ch
            jb c15
           cmp dx,6ch
            ja c15
           mov [key],'1'
           jmp en1
           c15:
           cmp dx,74h
            jb r2
           cmp dx,84h
            ja r2
           mov [key],'0'
           jmp en1
         
        ;....................
        r2:
        cmp cx,084h
         jb r3_1
        cmp cx,094h
         ja r3_1
          
           c21:
           cmp dx,2ch
            jb c22
           cmp dx,3ch
            ja c22
           mov [key],'8'
           jmp en1
           c22:
           cmp dx,44h
            jb c23
           cmp dx,54h
            ja c23
           mov [key],'5'
           jmp en1
           c23:
           cmp dx,5ch
            jb c24
           cmp dx,6ch
            ja c24
           mov [key],'2'
           jmp en1
           c24:
           cmp dx,74h
            jb r3_1
           cmp dx,84h
            ja r3_1
           mov [key],'0'
           jmp en1
		   
		r3_1:
		cmp cx,078h
         jb r3
        cmp cx,080h
         ja r3
			cmp dx,74h
			jb r3
			cmp dx,84h
			ja r3
			mov [key],'0'
			jmp en1
        ;....................
        r3:
        cmp cx,0a4h
         jb r4
        cmp cx,0b4h
         ja r4
          
           c31:
           cmp dx,2ch
            jb c32
           cmp dx,3ch
            ja c32
           mov [key],'9'
           jmp en1
           c32:
           cmp dx,44h
            jb c33
           cmp dx,54h
            ja c33
           mov [key],'6'
           jmp en1
           c33:
           cmp dx,5ch
            jb c34
           cmp dx,6ch
            ja c34
           mov [key],'3'
           jmp en1
           c34:
           cmp dx,74h
            jb r4
           cmp dx,84h
            ja r4
           mov [key],'.'
           jmp en1 
            
       ;..................... 
       r4:
        cmp cx,0c4h
         jb r5
        cmp cx,0d4h
         ja r5
           c41:
           cmp dx,2ch
            jb c42
           cmp dx,3ch
            ja c42
           mov [key],'/'
           jmp en1
           c42:
           cmp dx,44h
            jb c43
           cmp dx,54h
            ja c43
           mov [key],'*'
           jmp en1
           c43:
           cmp dx,5ch
            jb c44
           cmp dx,6ch
            ja c44
           mov [key],'-'
           jmp en1
           c44:
           cmp dx,74h
            jb r5
           cmp dx,84h
            ja r5
           mov [key],'+'
           jmp en1 
		 ;  .............................
	r5:
		cmp cx,0E4h
         jb r6
        cmp cx,0F4h
         ja r6
           cmp dx,2ch
            jb c51
           cmp dx,3ch
            ja c51
           mov [key],'C'
           jmp en1
		   c51:
		   cmp dx,44h
            jb c52
           cmp dx,54h
            ja c52
           mov [key],'_'
           jmp en1
		   c52:
		   cmp dx,58h
            jb r6
           cmp dx,84h
            ja r6
			mov [key],'='
			jmp en1
			;.........................
		r6:
		cmp cx,0F8h
		 jb en
		cmp cx,0FFh
		 ja en
		   cmp dx,8h
		    jb en
		   cmp dx,10h
		    ja en	
		   mov [key],'x'	
		   jmp en1	
		   
       ;.....................
       en:    
       mov [key],'='   ;no match found!
       en1:
	   cmp key,'x'
       je exit
       cmp key,'C'
       jne en2
       mov of,0 
       mov xsighn,0      
       jmp begin
       en2:
       popa     ;popall registers 
        
endm               
;---------------------------------------------------

number_in  macro  n,operand,lenth,dot_index,float_count,sign
    local l1,l1_2,l1_2_1,l1_3,l1_3_1
    local l2,l3,l4
	local next_step,next_step1
 
    pusha
	mov sign , 0
	mov float_count , 0
    
    mov lenth , 0
    mov  make_dot,0
	mov  dot_index,0
	
	l1:
		initmouse
		getmouse key
	
	l1_2: 
        cmp lenth,0    ;first time,clear scre
        jne l1_2_1
		cmp sign,1
		je l1_2_1
        clear  buffer
        putstr buffer
        gotoxy 17,3
    l1_2_1:    
        mov al,key     ;check if its number
		cmp al,'_'
		jne next_step1
		mov xsighn,1
		mov dl,'-'
		mov ah,02h
		int 21h
		jmp l1
	next_step1:	
		cmp al,'.'
		jne next_step
		 
		cmp make_dot,0
		jne calc2
		inc make_dot
        mov     ax,lenth + 1
        mov     dot_index,al
		mov ah,02h
		mov dl,'.'
		int 21h
        jmp     l1
		
next_step:		
		cmp al,48  
         jb l2                        
        cmp al,58 
         ja l2                               
                                       
    l1_3:                             
        mov [si],al
        pusha
         
        mov ah,02h
        mov dx,[si]
        int 21h    
       
        inc si 
        inc lenth
       
		cmp make_dot,0
		je l1_3_1
		inc float_count
		
	l1_3_1:	
		cmp lenth,6 ;just resive 5 digits + 1
        jne l1
    ;........................     
    l2:                     ;converting to in
        mov dx,0
        cmp lenth,0
         je l4
        mov operand,al ;get operand 
        lea si,buffer
        mov cx,lenth
        mov bx,10
	    l3:         ;make number
	        mov ax,dx
	        mul bx
	        mov dx,ax
	        mov ah,0
	        mov al,[si]
	        sub al,48
	        add dx,ax
	        inc si
	        loop l3

	;........................
	l4:
		
	    mov n,dx
	    gotoxy 24,3
	    popa
		

endm     
;---------------------------------------------------
putrez macro buffer,x
       local next_digit,pz1,pz2
	   local nex1,nex2
     
       pusha
       mov ax,x             ;convert <int> to <str>
	   mov cl,x_float_count
       clear  buffer
       lea si,buffer               
       mov bx,10             
       mov [si+5],'0'
	   mov [si+4],'.'
	   mov [si+3],'0'
	   
    ;........................                         
       next_digit: 
		
	     cmp cl,0
		 jne nex1
		 cmp x_float_count,0
		 jne nex2
		
		 mov [si+5],'0'
		 dec si
nex2:	 
		 mov dl,'.'
		 mov [si+5],dl
		 dec si
		 dec cl
		 dec x_float_count
		 
		 jmp next_digit
		 
  nex1:
		 mov dx,0           ; buffer 
         div bx             
         add dl,48          
         mov [si+5],dl
         dec si
		 dec cl
         cmp ax,0
         jne next_digit
		 
     
   ;.........................          
       gotoxy 17,3          ;print buffer
       putstr buffer 
        
       cmp of,1             ;print owerflow mark
       jne pz1 
       gotoxy 27,3
       putch  'F',15
       jmp pz2              ;print xsighn
   pz1:
       cmp xsighn,1
       jne pz2
       gotoxy 15,3
       putch  '-',15
   pz2:
       popa
 
endm
;---------------------------------------------------
reset macro
       mov x,0
       mov y,0 
       mov xsighn,0
       mov of,0
       clear buffer
       mov key,0
       mov operand1,0
endm


code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
 
;--------------------------------------------------
;--------------------------------------------------
;---  C A L C U L A T O R E -------- P R O C ------
;--------------------------------------------------
;--------------------------------------------------

call print_screen    
 
begin:
      reset
      calc1:
          putrez buffer,x   ;print  x
          number_in  x,operand1,lenth,x_dot_index,x_float_count,xsighn
          mov al,operand1
          cmp al,'='  
           je calc1
      calc2:
          number_in  y,operand2,lenth,y_dot_index,y_float_count,ysighn
          call calculate    ;x = x (operand1) y
          mov al,operand2
          cmp al,'='
           je calc1            ;if(operand2=='='):printx,start again.
          mov operand1,al        ;else:operand1=operand2,printx,get buffer again.
          putrez buffer,x
          jmp calc2
 
;--------------------------------------------------
;--------------------------------------------------
;-------------  F U N C T I O N S -----------------
;--------------------------------------------------
;--------------------------------------------------
 
print_screen proc :
        gotoxy 10,0;...........
        putstr l0
		gotoxy 10,1
		putstr l8
        gotoxy 10,2;........  ;
        putstr l1          ;  ;
        gotoxy 10,3        ;  ;out cadr
        putstr l2          ;  ;
        gotoxy 10,4        ;  ;
        putstr l3          ;  ;
        gotoxy 10,5;...... ;  ;
        putstr l4        ; ;rezualt board + exit key
        gotoxy 10,6      ; ;  ;
        putstr l5        ; ;  ;
        gotoxy 10,7      ; ;  ;
        putstr l6        ; ;  ;
        gotoxy 10,8      ; ;  ;
        putstr l4        ; ;  ;
        gotoxy 10,9      ;key board
        putstr l5        ; ;  ;
        gotoxy 10,10     ; ;  ;
        putstr l6        ; ;  ;
        gotoxy 10,11     ; ;  ;
        putstr l4        ; ;  ;
        gotoxy 10,12     ; ;  ;
        putstr l5        ; ;  ;
        gotoxy 10,13     ; ;  ;
        putstr l5_2        ; ;  ;
        gotoxy 10,14     ; ;  ;
        putstr l4_2        ; ;  ;
        gotoxy 10,15;..... ;  ;
        putstr l5_3          ;  ;
        gotoxy 10,16;.......  ;  
        putstr l6_2            ;
        gotoxy 10,17    
        putstr l7 
		
         
        ;keyboard lables
		
		gotoxy 31,1
		putch 'x',4
        gotoxy 13,6
        putch  '7',11
        gotoxy 17,6
        putch  '8',11
        gotoxy 21,6
        putch  '9',11
        gotoxy 25,6
        putch  '/',10
        gotoxy 29,6
		putch 'C',10
		gotoxy 13,9
        putch  '4',11
        gotoxy 17,9
        putch  '5',11
        gotoxy 21,9
        putch  '6',11
        gotoxy 25,9
        putch  '*',10
		gotoxy 29,9
        putch  241,10
        gotoxy 13,12
        putch  '1',11
        gotoxy 17,12
        putch  '2',11
        gotoxy 21,12
        putch  '3',11
        gotoxy 25,12
        putch  '-',10
		gotoxy 29,13
		putch  '=',10
        gotoxy 15,15
        putch  '0',11
        gotoxy 21,15
        putch  '.',10
        gotoxy 25,15
        putch  '+',10       
          
        ret
print_screen endp
;--------------------------------------------------
 
calculate proc near
    
	
    cmp operand1,'+'
     je pluss
    cmp operand1,'-'
     je miness
    cmp operand1,'*'
     je mulplus
    cmp operand1,'/'
     je devide
    jmp begin   ;no match found!

			pluss:
				mov al,x_float_count
				cmp al,y_float_count
				je p1
				ja p1x
				jb p1y
				p1x:
					mov ax,y
					mul _TEN
					mov y,ax
					inc y_float_count
					jmp pluss
				p1y:
					mov ax,x
					mul _TEN
					mov x,ax
					inc x_float_count
					jmp pluss
					p1:			
						mov al,xsighn
						cmp al,0 
						je pl1     ;x>0 & y>0
						jne pl2     ;x<0 & y>0
						pl1:
							mov ax,x
							add ax,y
							jno pl1_1
							mov of,1
							pl1_1:
								mov x,ax
								ret
						pl2:
							mov ax,x
							cmp ax,y
							jae pl3
							jb pl4
							pl3:
								mov ax,x
								sub ax,y
								mov x,ax
								ret
							pl4:
								mov ax,y
								sub ax,x
								mov x,ax
								mov xsighn,0
								ret
									
								
			
			miness:
					mov al,x_float_count
					cmp al,y_float_count
					ja m1x
					jb m1y
					je m1xy
				
				m1x:
					mov ax,y
					mul _TEN
					mov y,ax
					inc y_float_count
					jmp miness
				m1y:
					mov ax,x
					mul _TEN
					mov x,ax
					inc x_float_count
					jmp miness
			
			m1xy:	
					mov ax,x
					cmp ax,y
					jae mi3
					 jb mi4
				
				mi3:
					    mov ax,x
					    sub ax,y
					    mov x,ax
					    mov xsighn,0
					    ret
				mi4:
					    mov ax,y
					    sub ax,x
					    mov x,ax
					    mov xsighn,1
						ret
					
			mulplus:
					mov al,y_float_count
					add x_float_count,al
					
					mov dx,0
					mov ax,x
					cwd		
					mov bx,y		
					mul bx  		
					jno mu1 		
					mov of,1        
					mu1:             		
						add ax,dx		
						mov x,ax		
						mov al,xsighn		
						cmp al,ysighn		
						je mu2		
						jne mu3	
						mu2:						
							mov xsighn,0					
							ret	
						mu3:
							mov xsighn,1
							ret
							
				devide:
						mov al,x_float_count
						cmp al,y_float_count
						jne d1
						mov x_float_count,0
						xor dx,dx
						mov ax,x
						div y
						mov x,ax
					d1_1:
						cmp dx,0
						je endDIV
						cmp x_float_count,2
						je endDIV
						mov bx,dx
						mov ax,x
						mul _TEN
						mov x,ax
						
						mov ax,bx
						mul _TEN
						inc x_float_count
						div y
						add x,ax
						jmp d1_1
					endDiv:
						cmp dx,0
						je nOF
						mov of,1
					nOF:
						ret 
						
							d1:
								ja d1x
								jb d1y
									d1x:
										mov ax,y
										mul _TEN
										mov y,ax
										inc y_float_count
										jmp devide
									d1y:
										mov ax,x
										mul _TEN
										mov x,ax
										inc x_float_count
										jmp devide
					
calculate endp
;---------------------------------------------------                           
 
 
exit:
 
    mov ax, 4c00h ; exit 
    int 21h    
ends
 
end start 