Procedure OpenWindow_0(x = 0, y = 0, width = 670, height = 400)
  Window_0 = OpenWindow(#PB_Any, x, y, width, height, "", #PB_Window_SystemMenu)
  read_forum = ButtonGadget(1, 10, 30, 100, 25, "Read Forum")
  google = ButtonGadget(2, 10, 60, 100, 25, "Google")
  stack = ButtonGadget(3, 10, 90, 100, 25, "Stackoverflow")
  ask_friend = ButtonGadget(4, 10, 120, 100, 25, "Ask Friend")
  github = ButtonGadget(5, 10, 150, 100, 25, "Github")  
EndProcedure

OpenWindow_0()

Repeat 
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget
    Select EventGadget()
      Case 1
        Debug "forum"
      Case 2
        Debug "google"
      Case 3
        Debug "stack"
      Case 4
        Debug "friends"
      Case 5
        Debug "github"
    EndSelect
  EndIf
  
Until event = #PB_Event_CloseWindow
