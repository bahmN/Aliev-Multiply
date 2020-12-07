Show_AX proc
  push bx
  push cx
  push dx

  cmp ax, 0
  jns begin
  not ax
  inc ax
  push ax
  mov al, '-'
  int 29h
  pop ax

begin:
  mov bx, 10
  xor cx, cx
isDiv:
  xor dx, dx
  div bx
  push dx
  inc cx
  or ax, ax
  jnz isDiv

isOutNum:
  pop ax
  or al, 30h
  int 29h
  loop isOutNum

  pop dx
  pop cx
  pop bx

  ret
Show_AX endp