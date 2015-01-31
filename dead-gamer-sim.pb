; Pure Basic Sourse File. Dead Games Simulator v0.1

OpenWindow(0,100,100,220,120,"GamerSim")
howManyDays = 1
howManyLives = 5
liveIndic$ = "Lives: " + howManyLives + "/5"
daysIndic$ = "Day: " + howManyDays 
Goal = TextGadget(#PB_Any,10,10,200,20,"Stay alive 10 days")
Lives = TextGadget(#PB_Any,10,30,200,20,liveIndic$)
Days = TextGadget(#PB_Any,10,50,200,20,daysIndic$)
sleepBtn = ButtonGadget(#PB_Any,10,70,200,20,"Sleep")
playBtn = ButtonGadget(#PB_Any,10,90,200,20,"Play")

Repeat 
  event = WaitWindowEvent()
  If howManyDays>9
        event = #PB_Event_CloseWindow
    Sourse$ = "https://github.com/Anatolt/dead-gamer-simulator"
    youWinTxt$ = "You die from unsleep " + deadUnsleep + " times. And die from game too much " + deadGame + " times"
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
          howManyLives+3
          howManyDays+1 
          liveIndic$ = "Lives: " + howManyLives + "/5"
          daysIndic$ = "Day: " + howManyDays 
          SetGadgetText(Lives,liveIndic$)
          SetGadgetText(Days,daysIndic$)
        Case playBtn
          howManyLives-1
          howManyDays+1  
          liveIndic$ = "Lives: " + howManyLives + "/5"
          daysIndic$ = "Day: " + howManyDays 
          SetGadgetText(Lives,liveIndic$)
          SetGadgetText(Days,daysIndic$)
      EndSelect
    EndIf
    Select howManyLives
      Case 0
        youDeadTxt$ = "You DEAD. You die from unsleep "
        Result = MessageRequester("You DEAD",youDeadTxt$)
        deadUnsleep + 1
        If Result
          howManyLives = 5
          howManyDays = 1
          liveIndic$ = "Lives: " + howManyLives + "/5"
          daysIndic$ = "Day: " + howManyDays 
          SetGadgetText(Lives,liveIndic$)
          SetGadgetText(Days,daysIndic$)
        EndIf
      Case 6 To 10
        youDeadTxt$ = "You DEAD. You die from game too much "
        Result = MessageRequester("You DEAD",youDeadTxt$)
        deadGame + 1
        If Result
          howManyLives = 5
          howManyDays = 1
          liveIndic$ = "Lives: " + howManyLives + "/5"
          daysIndic$ = "Day: " + howManyDays 
          SetGadgetText(Lives,liveIndic$)
          SetGadgetText(Days,daysIndic$)
        EndIf
    EndSelect
  EndIf
Until event = #PB_Event_CloseWindow
