v$ = "v0.2"
;проверку количества ходов,
;проверку не стреляем ли мы опять в то же поле
;win state
;fail state
hod = 5
NewMap field.s()
For i = 1 To 5 : field(Str(i)) = "OOOOO" : Next
; расположение корабля
ship_pos_x = Random(4)
ship_pos_y = Random(4)
Debug "Позиция корабля: " + Str(ship_pos_x) + ":" + Str (ship_pos_y)
If OpenConsole("Однострочный морской бой "+v$) 
  Repeat
    PrintN("Где то в этой строке прячется корабль. Угадай где")
    str$="00000"
    PrintN(str$)
    While Not x = ship_pos_x
      While x>5 Or x<0
        PrintN("Мимо поля. Надо от 1 до 5. X = ")
      Wend
      For i = 1 To 5
        If i = x
          str$ = str$ + "X"
        Else
          str$ = str$ + Str(0)
        EndIf
      Next
      PrintN(str$)
      PrintN("Промазал")
      PrintN("Номер символа?")
      Print("X = ")
      x=Val(Input())
    Wend
    PrintN("Победа!")
  Until Input() = "exit" ;Or Not WaitWindowEvent() = #PB_Event_CloseWindow
EndIf
