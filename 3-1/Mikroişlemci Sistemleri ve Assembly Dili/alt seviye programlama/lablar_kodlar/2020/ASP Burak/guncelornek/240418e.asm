; s�ralaman�n macro ile yapilmasi 


myss 	segment para stack 'yigin'
		dw 12 dup (?) 
myss	ends
myds	segment para 'data'
dizi	dw 1,2,3,4,5,6,7,8,9,10
eleman 	dw 10 
myds	ends
mycs	segment para 'code'
		assume cs:mycs, ds:myds, ss:myss


		
		
sirala	macro 
		local donus,dis,ic
		; kulland���m yazma�lar�n �nceki degerlerinin bozulmamas� icin saklarim
		push si
		push di
		push cx
		push bx
		push ax
		;  siralama i�lemi 
		xor si,si ; d�� �evrim indisi
		mov cx, eleman
		dec cx
dis:	mov ax,dizi[si]  	;dizinin ilk eleman�n� buyuk kabul et 
		mov bx,si		 	;bx de buyuk olan eleman�n indisi olsun 
		push cx				; d�� �evrim d�ng� say�s�n� sakla 
		; d�� ve i� �evrim say�lar� ayn� oldugu i�in CX'in yeniden ilk 
		; degerlendirmesi yap�lmas�na gerek yoktur. 
		mov di,si
ic:		add di,2			; dizi word olunca bir sonraki indir +2 ileride
		cmp dizi[di],ax		; i�aretsiz de�erlendirece�iz
		jb donus
		mov ax, dizi[di]
		mov bx,di
donus:	loop ic		
		xchg ax,dizi[si]	; dizi elemanlar�n�n yerlerini degi�tirdik. 
		mov dizi[bx],ax
		pop cx				; d�� cevrim degerini y�g�ndan geri al 
		add si,2			; d�� c�verim indisini word dizi icin +2 yap
		loop dis
		; kulland���m yazma�lar�n �nceki degerlerinin geri almal�y�m 
		pop ax
		pop bx
		pop cx
		pop di
		pop si		
		endm
		
ana 	proc far
		push ds
		xor ax,ax
		push ax
		mov ax,myds
		mov ds,ax
		; 
		sirala		; macronun adini yazmak yeterli 
		;
	
donus:		ret
ana 	endp		

mycs	ends
		end ana 
		