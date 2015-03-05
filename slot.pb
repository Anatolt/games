version$ = "v0.1"

; освоил 
; новый гаджет TrackBarGadget
; #PB_Text_Center | #PB_Text_Border
; применил то, что узнал вчера - складываю значения строк прямо внутри гаджетов
; рефакторинг в первой же версии - переделал всё через Enumeration чтобы сократить всё через цикл For


; план 
; добавить изображения барабанов 
; добавить фрукты вместо цифр
; показывать лог операций не в консоли
; добавить эффект вращения 
; кнопку старт/стоп
; сложный учёт

Global Money

Enumeration FormFont
  #Font
  #indik1
  #indik2
  #indik3
  #money_indik
  #TrackBar
  #Woho
EndEnumeration

LoadFont(#Font,"Arial", 66)

OpenWindow(#PB_Any, 200, 200, 250, 180, "Слот Машина " + version$, #PB_Window_SystemMenu)
TextGadget(#indik1, 10, 10, 70, 100, "8", #PB_Text_Center | #PB_Text_Border)
TextGadget(#indik2, 90, 10, 70, 100, "8", #PB_Text_Center | #PB_Text_Border)
TextGadget(#indik3, 170, 10, 70, 100, "8", #PB_Text_Center | #PB_Text_Border)
For i = #indik1 To #indik3
  SetGadgetFont(i, FontID(#Font))
Next
ButtonGadget(#Woho, 10, 120, 120, 25, "Вращать барабаны")
Money = 600
TextGadget(#money_indik, 10, 150, 100, 25, "Баблища: " + Str(Money))
TrackBarGadget(#TrackBar, 140, 120, 100, 25, 1, 5)
min = TextGadget(#PB_Any, 150, 150, 20, 25, "1")
max = TextGadget(#PB_Any, 220, 150, 20, 25, "5")

Procedure Money(stavka)
  Money+stavka
  SetGadgetText(#money_indik,"Баблища: " + Str(Money))
EndProcedure

Dim Result(3)

Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget And EventGadget() = #Woho
    For i = #indik1 To #indik3
      SetGadgetText(i,Str(Random(3,1)))
      Result(i) = Val(GetGadgetText(i))
    Next
    Stavka = GetGadgetState(#TrackBar)
    If Result(1) = Result(2) And Result(2) = Result(3)
      SuperResult = Stavka * (Result(1) + Result(1) + Result(1))
      Debug "You Win " + Str(SuperResult)
      Money(SuperResult)
    Else
      Debug "You Lose " + Str(Stavka)
      Money(-Stavka)
    EndIf
  EndIf
Until event = #PB_Event_CloseWindow
