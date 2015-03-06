version$ = "v0.2"
; конструктор форм откратительная глючная херня
; добавил пояснение расчёта выигрыша
; добавил кнопку "крутить до выигрыша"
; засунул вращение барабанов в процедуру
; вывел лог для пользователя вместо дебаггера

; план 
; добавить изображения барабанов 
; добавить фрукты вместо цифр
; добавить эффект вращения 
; кнопку старт/стоп
; сложный учёт

Global Money, SuperResult, hod

Enumeration FormFont
  #Font
  #indik1
  #indik2
  #indik3
  #money_indik
  #TrackBar
  #Woho
  #WohoWin
  #Log
  #cherry
  #seven
  #banan
EndEnumeration

LoadFont(#Font,"Arial", 66)

OpenWindow(#PB_Any, 200, 200, 250, 480, "Слот Машина " + version$, #PB_Window_SystemMenu)

; картинки блять опять не работают...
;LoadImage(#cherry, "cherry.jpg")    
;LoadImage(#seven, "seven.jpg")
;LoadImage(#banan, "banan.jpg")
;ImageGadget(#indik1, 10, 10, 70, 100, ImageID(#cherry))
;ImageGadget(#indik2, 90, 10, 70, 100, ImageID(#seven))
;ImageGadget(#indik3, 170, 10, 70, 100, ImageID(#banan))

; стартовое значение индикаторов
TextGadget(#indik1, 10, 10, 70, 100, "8", #PB_Text_Center | #PB_Text_Border)
TextGadget(#indik2, 90, 10, 70, 100, "8", #PB_Text_Center | #PB_Text_Border)
TextGadget(#indik3,170, 10, 70, 100, "8", #PB_Text_Center | #PB_Text_Border)

; задел на будущее вместо картинок
;TextGadget(#PB_Any, 10, 130, 100, 20, "♠♠♠ = Ставка *1")
;TextGadget(#PB_Any, 10, 150, 100, 20, "♣♣♣ = *2")
;TextGadget(#PB_Any, 10, 170, 100, 20, "♥♥♥ = *3")
;TextGadget(#PB_Any, 10, 190, 100, 20, "♦♦♦ = *4")

TextGadget(#PB_Any, 10, 130, 200, 20, "333 = выигрыш 9 * ставка")
TextGadget(#PB_Any, 10, 150, 100, 20, "222 = 6*ставка")
TextGadget(#PB_Any, 10, 170, 100, 20, "111 = 3*ставка")

For i = #indik1 To #indik3
  SetGadgetFont(i, FontID(#Font))
Next
ButtonGadget(#Woho, 10, 185, 120, 25, "Крутануть 1 раз")
ButtonGadget(#WohoWin, 10, 210, 120, 25, "Крутить до выигрыша")
Money = 600
TextGadget(#money_indik, 10, 240, 100, 25, "Баблища: " + Str(Money))
TextGadget(#PB_Any, 150, 190, 210, 20, "Ставка")
TrackBarGadget(#TrackBar, 140, 210, 100, 25, 1, 5)
TextGadget(#PB_Any, 150, 240, 20, 25, "1")
TextGadget(#PB_Any, 220, 240, 20, 25, "5")
EditorGadget(#Log, 10, 270, 230, 200)

Procedure Money(stavka)
  Money+stavka
  SetGadgetText(#money_indik,"Баблища: " + Str(Money))
EndProcedure

Procedure Roling()
  Dim Result(3)
  For i = #indik1 To #indik3
    SetGadgetText(i,Str(Random(3,1)))
    Result(i) = Val(GetGadgetText(i))
  Next
  hod+1
  Stavka = GetGadgetState(#TrackBar)
  log$ = "Ход " + Str(hod) + ". Ставка " + Str(Stavka) + ". "
  If Result(1) = Result(2) And Result(2) = Result(3)
    SuperResult = Stavka * (Result(1) + Result(1) + Result(1))
    AddGadgetItem(#Log,0,log$+"Выиграли " + Str(SuperResult))
    Money(SuperResult)
  Else
    AddGadgetItem(#Log,0,log$+"Проиграли " + Str(Stavka))
    Money(-Stavka)
  EndIf
EndProcedure

Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget 
    Select EventGadget() 
      Case #Woho
        Roling()
      Case #WohoWin
        While Not SuperResult 
          Roling()
        Wend
        SuperResult = 0
    EndSelect
  EndIf
  Until event = #PB_Event_CloseWindow
