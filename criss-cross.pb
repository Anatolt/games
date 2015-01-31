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
      Else
        btnTxt$ = "X"
      EndIf 
      For i = 1 To 9
        Select EventGadget()
          Case i
            hod+1
            SetGadgetText(i,btnTxt$)
            Debug Result$
        EndSelect
        Next
      For i = 1 To 9
        Result$+GetGadgetText(i)
      Next
  EndSelect
Until eee = #PB_Event_CloseWindow
