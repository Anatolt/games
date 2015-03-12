v$ = "v0.1"

NewMap field.s()

For i = 1 To 5
  field(Str(i)) = "OOOOO"
Next

; расположение корабля
ship_pos_x = Random(4)
ship_pos_y = Random(4)

If OpenConsole("Одноклеточный морской бой "+v$) 
  PrintN("Привет!")
  While Not Input() = "exit"
    Debug "Позиция корабля: " + Str(ship_pos_x) + ":" + Str (ship_pos_y)
    PrintN("Это поле 5 на 5. На нём расположен кораблик размеров в 1 клетку поля.")
    ForEach field()
      PrintN(field())
    Next
    PrintN("Дружище, вам нужно в него попасть!")
    PrintN("Введите 2 координаты предполагаемого расположения корабля")
    Print("X = ")
    x=Val(Input())
    If x > 5 Or x < 0
      PrintN("Вы не попали в поле")
    Else
      Print("Y = ")
      y=Val(Input())
      If y > 5 Or y < 0
        PrintN("Вы не попали в поле")
      Else
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
        
      EndIf
    EndIf
  Wend
  CloseConsole()
EndIf
