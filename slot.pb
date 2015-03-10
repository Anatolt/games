version$ = "v0.3"
; переделал цифры в символы
; написал логику постановки символов вместо цифр
; переделал систему считывания значений
; переписал пояснения к выигрышу

; план 
; если зажать кнопку барабаны должны крутиться и делаться ставка раз в секунду
; добавить изображения барабанов 
; добавить картинками фрукты вместо цифр
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
;UsePNGImageDecoder()

LoadImage(#cherry, "cherry.bmp")
LoadImage(#seven, "seven.bmp")
LoadImage(#banan, "banan.bmp")
ImageGadget(#indik1, 10, 10, 70, 100, ImageID(#cherry))
ImageGadget(#indik2, 90, 10, 70, 100, ImageID(#seven))
ImageGadget(#indik3, 170, 10, 70, 100, ImageID(#banan))

; стартовое значение индикаторов ♣♥♠
;TextGadget(#indik1, 10, 10, 70, 100, "♣", #PB_Text_Center | #PB_Text_Border)
;TextGadget(#indik2, 90, 10, 70, 100, "♥", #PB_Text_Center | #PB_Text_Border)
;TextGadget(#indik3,170, 10, 70, 100, "♠", #PB_Text_Center | #PB_Text_Border)
TextGadget(#PB_Any, 10, 115, 200, 15, "Если выпадет ")
TextGadget(#PB_Any, 10, 130, 200, 15, "♣♣♣ выигрыш = 9 * ставка")
TextGadget(#PB_Any, 10, 145, 200, 15, "♥♥♥ выигрыш = 6 * ставка")
TextGadget(#PB_Any, 10, 160, 200, 15, "♠♠♠ выигрыш = 3 * ставка")

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
  state$ = ""
  Dim Result(3)
  For i = #indik1 To #indik3
    Result(i) = Random(3,1)
    Select Result(i)
      Case 1
        SetGadgetState(i,ImageID(#cherry))
      Case 2
        SetGadgetState(i,ImageID(#banan))
      Case 3
        SetGadgetState(i,ImageID(#seven))
    EndSelect
    state$+GetGadgetText(i)
  Next
  hod+1
  Stavka = GetGadgetState(#TrackBar)
  log$ = "Ход " + Str(hod) + ". Ставка " + Str(Stavka) + ". Выпало" + state$
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
