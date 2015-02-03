; крестики-нолики v0.3 bugfix
OpenWindow(0,100,100,300,320,"Крестики-нолики")
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
Repeat
  eee = WaitWindowEvent()
  If CreatePopupMenu(0)
    MenuItem(1, "Restart")
    MenuItem(2, "Quit")
  EndIf
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
    Next
  Else
    Select eee
      Case #PB_Event_Gadget
        If hod%2
          btnTxt$ = "O"
          param = 0
        Else
          btnTxt$ = "X"
          param = 1
        EndIf 
        For i = 1 To 9
          Select EventGadget()
            Case i
              hod+1
              SetGadgetText(i,btnTxt$)
              DisableGadget(i,1)
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
        
    EndSelect
  EndIf
Until eee = #PB_Event_CloseWindow
