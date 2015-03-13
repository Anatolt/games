v$ = "v0.1"

;проверку количества ходов,
;проверку не стреляем ли мы опять в то же поле
;win state
;fail state

hod = 5
NewMap field.s()
For i = 1 To 5
  field(Str(i)) = "OOOOO"
Next

; расположение корабля
ship_pos_x = Random(4)
ship_pos_y = Random(4)
Debug "Позиция корабля: " + Str(ship_pos_x) + ":" + Str (ship_pos_y)

If OpenConsole("Одноклеточный морской бой "+v$) 
  PrintN("Привет! Нажмите пожалуйста Enter")
  Repeat
    If hod > 0
      If x = ship_pos_x And y = ship_pos_y
        PrintN("Вы победили!")
      Else
      PrintN("Это поле 5 на 5. На нём расположен кораблик размеров в 1 клетку поля.")
      ForEach field() : PrintN(field()) : Next
      PrintN("Дружище, вам нужно в него попасть!")
      PrintN("У вас осталось "+Str(hod)+" попыток")
      PrintN("Введите 2 координаты предполагаемого расположения корабля")
      Print("X = ")
      x=Val(Input())
      While x > 5 Or x < 0
        PrintN("Мимо поля. Значение должно быть от 1 до 5") : Print("X = ")
        x=Val(Input())
      Wend
      Print("Y = ")
      y=Val(Input())
      While y > 5 Or y < 0
        PrintN("Мимо поля. Значение должно быть от 1 до 5") : Print("Y = ")
        y=Val(Input())
      Wend
      Select x
        Case 1
          field(Str(y)) = "XOOOO"
        Case 2
          field(Str(y)) = "OXOOO"
        Case 3
          field(Str(y)) = "OOXOO"
        Case 4
          field(Str(y)) = "OOOXO"
        Case 5
          field(Str(y)) = "OOOOX"
      EndSelect
        hod = -1
        PrintN("Вы не попали")
      EndIf
    EndIf
    PrintN("Больше не осталось попыток")
    PrintN("Вы проиграли")
  ;CloseConsole()
Until Input() = "exit" ;Or Not WaitWindowEvent() = #PB_Event_CloseWindow
EndIf
