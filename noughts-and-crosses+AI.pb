; крестики-нолики v0.6 + адекватный бот!!
OpenWindow(0,200,200,300,320,"Крестики-нолики")
btnTxt$ = "Press"
ButtonGadget(1,0  ,0  ,100,100,btnTxt$)
ButtonGadget(2,100,0  ,100,100,btnTxt$)
ButtonGadget(3,200,0  ,100,100,btnTxt$)
ButtonGadget(4,0  ,100,100,100,btnTxt$)
ButtonGadget(5,100,100,100,100,btnTxt$)
ButtonGadget(6,200,100,100,100,btnTxt$)
ButtonGadget(7,0  ,200,100,100,btnTxt$)
ButtonGadget(8,100,200,100,100,btnTxt$)
ButtonGadget(9,200,200,100,100,btnTxt$)
TextGadget(10,0,300,300,20,"v0.3  |  F5 - restart, Esc - quit",#PB_Text_Center)
CreatePopupMenu(0)
MenuItem(1, "Restart")
MenuItem(2, "Quit")
Dim state(9)
Repeat
  eee = WaitWindowEvent()
  If eee = #PB_Event_Menu 
    Select EventMenu() 
      Case 1
        restart = 1
      Case 2
        eee = #PB_Event_CloseWindow
    EndSelect
  EndIf
  AddKeyboardShortcut(0, #PB_Shortcut_F5, 1)
  AddKeyboardShortcut(0, #PB_Shortcut_Escape, 2)
  If restart
    restart = 0
    hod = 0
    For i = 1 To 9
      btnTxt$ = "Press"
      SetGadgetText(i,btnTxt$)
      DisableGadget(i,0)
      state(i) = 0
    Next
  ElseIf eee = #PB_Event_Gadget
    If hod%2
      btnTxt$ = "O"
    Else
      btnTxt$ = "X"
    EndIf 
    For i = 1 To 9
      Select EventGadget()
        Case i
          Debug "Игрок сделал ход " + i
          hod+2
          state(i) = 2
          SetGadgetText(i,btnTxt$)
          DisableGadget(i,1)
          btnTxt$ = "O"
          AI = Random(9,1)
          Debug "ИИ включился. Выбираем позицию " + AI + " её значение" + Str(state(AI))
          If state(AI) = 2
            Debug "Мы внутри цикла" 
            AI = Random(9,1)
          Else
            state(AI) = 2
            SetGadgetText(AI,btnTxt$)
            DisableGadget(AI,1)
          EndIf
      EndSelect
    Next
    
    ott$ = GetGadgetText(1)+GetGadgetText(2)+GetGadgetText(3)
    ofn$ = GetGadgetText(1)+GetGadgetText(5)+GetGadgetText(9)
    ocs$ = GetGadgetText(1)+GetGadgetText(4)+GetGadgetText(7)
    tfe$ = GetGadgetText(2)+GetGadgetText(5)+GetGadgetText(8)
    tfs$ = GetGadgetText(3)+GetGadgetText(5)+GetGadgetText(7)
    cfi$ = GetGadgetText(4)+GetGadgetText(5)+GetGadgetText(6)
    tin$ = GetGadgetText(3)+GetGadgetText(6)+GetGadgetText(9)
    sen$ = GetGadgetText(7)+GetGadgetText(8)+GetGadgetText(9)
    xxx$ = "XXX"
    ooo$ = "OOO"
    
    If ott$ = xxx$ Or ofn$ = xxx$ Or ocs$ = xxx$ Or tfe$ = xxx$ Or tfs$ = xxx$ Or cfi$ = xxx$ Or tin$ = xxx$ Or sen$ = xxx$
      MessageRequester("Всё","Крестики выиграли ")
      For i = 1 To 9
        DisableGadget(i,1)
      Next
    ElseIf ott$ = ooo$ Or ofn$ = ooo$ Or ocs$ = ooo$ Or tfe$ = ooo$ Or tfs$ = ooo$ Or cfi$ = ooo$ Or tin$ = ooo$ Or sen$ = ooo$
      MessageRequester("Всё","Нолики выиграли ")
      For i = 1 To 9
        DisableGadget(i,1)
      Next
    Else
      If hod>8
        MessageRequester("Всё","Ничья")
      EndIf
    EndIf
    
  EndIf
Until eee = #PB_Event_CloseWindow
