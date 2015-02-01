; крестики-нолики
OpenWindow(0,100,100,300,300,"Крестики-нолики")
ButtonGadget(1,0  ,0  ,100,100,"1")
ButtonGadget(2,100,0  ,100,100,"2")
ButtonGadget(3,200,0  ,100,100,"3")
ButtonGadget(4,0  ,100,100,100,"4")
ButtonGadget(5,100,100,100,100,"5")
ButtonGadget(6,200,100,100,100,"6")
ButtonGadget(7,0  ,200,100,100,"7")
ButtonGadget(8,100,200,100,100,"8")
ButtonGadget(9,200,200,100,100,"9")
Repeat
  eee = WaitWindowEvent()
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
            ;Result$ = Str(i)+btnTxt$+Result$ 
            ;Debug Result$
        EndSelect
      Next
      WIN$ = "Ничо не записалось"
      If hod>8
        ott$ = GetGadgetText(1)+GetGadgetText(2)+GetGadgetText(3)
        ;ofn$ = GetGadgetText(1)+GetGadgetText(5)+GetGadgetText(9)
        ;ocs$ = GetGadgetText(1)+GetGadgetText(4)+GetGadgetText(7)
        ;tfe$ = GetGadgetText(2)+GetGadgetText(5)+GetGadgetText(8)
        ;tfs$ = GetGadgetText(3)+GetGadgetText(5)+GetGadgetText(7)
        ;cfi$ = GetGadgetText(4)+GetGadgetText(5)+GetGadgetText(6)
        ;tin$ = GetGadgetText(3)+GetGadgetText(6)+GetGadgetText(9)
        ;sen$ = GetGadgetText(7)+GetGadgetText(8)+GetGadgetText(9)
        ;xxx$ = "XXX"

        If ott$ = "XXX"
          WIN$ = "Выиграли крестики"
        Else
          WIN$ = "Я хз"
        EndIf
        MessageRequester("Всё",WIN$)
        ;For i = 1 To 9
        ;  Result$+GetGadgetText(i)
        ;Next
      EndIf
  EndSelect
Until eee = #PB_Event_CloseWindow
