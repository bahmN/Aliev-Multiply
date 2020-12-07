.model small
 
.stack 100h
 
.data
	PromptX db	'Enter price for 1 kilogram of apples: ', '$'
	PromptY db	'Enter apple weight: ', '$'
	sResult db	'Result= ', '$'
	CrLf	db	0Dh, 0Ah, '$'
	X	dw	?
	Y	dw	?
	Result	dw	?
	KeyBuf	db	7, ?, 7 dup(?)

	
.code
 
include STR2BIN.ASM	; добавление процедуры Str2Bin
include Show_AX.ASM	; добавление процедуры Show_AX

main	proc
	mov	ax,	@data
	mov	ds,	ax
 
	; ввод числа X с клавиатуры (строки)
InputX:
	lea	dx,	PromptX
	mov	ah,	09h
	int	21h
 
	mov	ah,	0Ah
	mov	dx,	offset KeyBuf
	int	21h
 
	; перевод строки (на новую строку)
	lea	dx,	CrLf
	mov	ah,09h
	int	21h
 
	; преобразование строки в число
	lea	bx, KeyBuf+1
	call	Str2Bin
	
	; проверка на ошибку
	jc	InputX
	
	mov [X], ax
 
	; ввод числа Y с клавиатуры (строки)
InputY:
	lea	dx,	PromptY
	mov	ah,	09h
	int	21h
 
	mov	ah,	0Ah
	mov	dx,	offset KeyBuf
	int	21h
 
	; перевод строки (на новую строку)
	lea	dx,	CrLf
	mov	ah,09h
	int	21h
 
	; преобразование строки в число
	lea	bx, KeyBuf+1
	call	Str2Bin
 
	; проверка на ошибку
	jc	InputY
	
	mov [Y], ax
 
	;умножение чисел
	mov	ax, [X]
	mov	cx, [Y]
	mul	cx	; ax * cx --> dx:ax
	mov	[Result], ax
	
	;вывод результата
	mov	ah,	09h
	lea	dx,	[sResult]
	int	21h
	
	mov	ax,	[Result]
	call	Show_AX
	
	mov	ah,	09h
	lea	dx,	[CrLf]
	int	21h
 
	mov	ax,	4C00h
	int	21h
main	endp 

end main