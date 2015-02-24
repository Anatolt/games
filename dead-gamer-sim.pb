; Pure Basic Sourse File. Dead Games Simulator v0.3 Procedures

Global howManyDays, howManyLives, Days, Lives

Procedure indicators(li)
  howManyDays + 1
  howManyLives + li
  daysIndic$ = "Day: " + howManyDays 
  liveIndic$ = "Lives: " + howManyLives + "/5"
  SetGadgetText(Lives,liveIndic$)
  SetGadgetText(Days,daysIndic$)
EndProcedure

OpenWindow(0,0,0,220,120,"GamerSim",#PB_Window_ScreenCentered|#PB_Window_SystemMenu)
Goal = TextGadget(#PB_Any,10,10,200,20,"Stay alive 10 days")
Days = TextGadget(#PB_Any,10,30,200,20,daysIndic$)
Lives = TextGadget(#PB_Any,10,50,200,20,liveIndic$)
sleepBtn = ButtonGadget(#PB_Any,10,70,200,20,"Sleep")
playBtn = ButtonGadget(#PB_Any,10,90,200,20,"Play")

Procedure start_indic()
  howManyDays=1
  howManyLives=5
  daysIndic$ = "Day: " + howManyDays 
  liveIndic$ = "Lives: " + howManyLives + "/5"
  SetGadgetText(Lives,liveIndic$)
  SetGadgetText(Days,daysIndic$)
EndProcedure

start_indic()

Repeat 
  event = WaitWindowEvent()
  If howManyDays>9
    event = #PB_Event_CloseWindow
    Sourse$ = "https://github.com/Anatolt/games/blob/master/dead-gamer-sim.pb"
    youWinTxt$ = "You die from game too much " + deadUnsleep + " times. And die from sleep too much " + deadGame + " times"
    OpenWindow(1,100,100,500,80,"YouWIN")
    TextGadget(#PB_Any,12,12,480,20,"Please send me this text for statistic to tolik@at02.ru")  
    StringGadget(#PB_Any,10,30,480,20,youWinTxt$)
    link = HyperLinkGadget(#PB_Any,12,50,480,20,Sourse$,RGB(0,0,0))
    SetGadgetColor(link,#PB_Gadget_FrontColor,RGB(255,0,0))
    Repeat 
      ev = WaitWindowEvent() 
      If ev = #PB_Event_Gadget And EventGadget() = link And EventType() = #PB_EventType_LeftClick : RunProgram(Sourse$) : EndIf  
    Until ev = #PB_Event_CloseWindow
  Else
    If event = #PB_Event_Gadget
      Select EventGadget()
        Case sleepBtn
          indicators(3)
        Case playBtn
          indicators(-1)
      EndSelect
    EndIf
    Select howManyLives
      Case 0
        Result = MessageRequester("You DEAD","You DEAD. You die from PLAY too much")
        deadUnsleep + 1
        If Result
          start_indic()
        EndIf
      Case 6 To 10
        Result = MessageRequester("You DEAD","You DEAD. You die from SLEEP too much.")
        deadGame + 1
        If Result
          start_indic()
        EndIf
    EndSelect
  EndIf
Until event = #PB_Event_CloseWindow
