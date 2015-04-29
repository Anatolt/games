;чувак ты забыл кнопку "выиграть"
;кнопка гуглить не исчезает. просто когда заканчивается список фраз пишет "что гуглить-то?" 
;идея: можно дать пользователю реальную возможность гуглить через игру, чтобы он мог ввести что-то и игра выдала это в лог
Global Window_0

Global forum, google, stack, friend, github, Text, Html, Design, Backup, Buy_Text, Buy_Html, Buy_Design, Buy_Domain, Buy_Hosting, Sell_Text, Sell_Html, Sell_Design, Noodles, McDonut, Home_Food, Walk, Conference, Club, journal, knowledge, knowhow, buy, sell, eat, buzz, tip
;Global List all_btn() - так не прокатывает

Procedure OpenWindow_0(x = 0, y = 0, width = 670, height = 400)
  Window_0 = OpenWindow(#PB_Any, x, y, width, height, "", #PB_Window_SystemMenu)
  forum = ButtonGadget(#PB_Any, 10, 30, 100, 25, "Read Forum")
  google = ButtonGadget(#PB_Any, 10, 60, 100, 25, "Google")
  stack = ButtonGadget(#PB_Any, 10, 90, 100, 25, "Stackoverflow")
  friend = ButtonGadget(#PB_Any, 10, 120, 100, 25, "Friend")
  github = ButtonGadget(#PB_Any, 10, 150, 100, 25, "Github")
  Text = ButtonGadget(#PB_Any, 120, 30, 100, 25, "Text: 10")
  Html = ButtonGadget(#PB_Any, 120, 60, 100, 25, "Html: 10")
  Design = ButtonGadget(#PB_Any, 120, 90, 100, 25, "Design: 10")
  Backup = ButtonGadget(#PB_Any, 120, 120, 100, 25, "Backup: y")
  Buy_Text = ButtonGadget(#PB_Any, 230, 30, 100, 25, "Buy Text")
  Buy_Html = ButtonGadget(#PB_Any, 230, 60, 100, 25, "Buy Html")
  Buy_Design = ButtonGadget(#PB_Any, 230, 90, 100, 25, "Buy Design")
  Buy_Domain = ButtonGadget(#PB_Any, 230, 120, 100, 25, "Domain: y")
  Buy_Hosting = ButtonGadget(#PB_Any, 230, 150, 100, 25, "Hosting: y")
  Sell_Text = ButtonGadget(#PB_Any, 340, 30, 100, 25, "Sell Text")
  Sell_Html = ButtonGadget(#PB_Any, 340, 60, 100, 25, "Sell Html")
  Sell_Design = ButtonGadget(#PB_Any, 340, 90, 100, 25, "Sell Design")
  Noodles = ButtonGadget(#PB_Any, 450, 30, 100, 25, "Noodles")
  McDonut = ButtonGadget(#PB_Any, 450, 60, 100, 25, "McDonut")
  Home_Food = ButtonGadget(#PB_Any, 450, 90, 100, 25, "Home Food")
  Walk = ButtonGadget(#PB_Any, 560, 30, 100, 25, "Walk")
  Conference = ButtonGadget(#PB_Any, 560, 90, 100, 25, "Conference")
  Club = ButtonGadget(#PB_Any, 560, 60, 100, 25, "Club")
  journal = EditorGadget(#PB_Any, 10, 180, 650, 210)
  knowledge = TextGadget(#PB_Any, 10, 10, 100, 20, "Знания")
  knowhow = TextGadget(#PB_Any, 120, 10, 100, 20, "Умения")
  buy = TextGadget(#PB_Any, 230, 10, 100, 20, "Купить")
  sell = TextGadget(#PB_Any, 340, 10, 100, 20, "Заработать")
  eat = TextGadget(#PB_Any, 450, 10, 100, 20, "Кушать")
  buzz = TextGadget(#PB_Any, 560, 10, 100, 20, "Развлекаться")
  tip = TextGadget(#PB_Any, 340, 150, 310, 20, "Здоровье, настрой и деньги в журнал ↓") ; убрать в финальном релизе
EndProcedure

OpenWindow_0()

Procedure Hide(name_of_btn)
  If name_of_btn
    HideGadget(name_of_btn,1)
  EndIf
EndProcedure

Procedure Show(name_of_btn) ; почему-то не работает
  If name_of_btn
    HideGadget(name_of_btn,0)
  EndIf
EndProcedure

NewList all_btn()

Procedure add_btn(List lname(), name_of_btn)
  AddElement(lname())
  lname() = name_of_btn
EndProcedure

add_btn(all_btn(), forum)
add_btn(all_btn(), stack)
add_btn(all_btn(), friend)
add_btn(all_btn(), github)
add_btn(all_btn(), Text)
add_btn(all_btn(), Html)
add_btn(all_btn(), Design)
add_btn(all_btn(), Backup)
add_btn(all_btn(), Buy_Text)
add_btn(all_btn(), Buy_Html)
add_btn(all_btn(), Buy_Design)
add_btn(all_btn(), Buy_Domain)
add_btn(all_btn(), Buy_Hosting)
add_btn(all_btn(), Sell_Text)
add_btn(all_btn(), Sell_Html)
add_btn(all_btn(), Sell_Design)
add_btn(all_btn(), Noodles)
add_btn(all_btn(), McDonut)
add_btn(all_btn(), Home_Food)
add_btn(all_btn(), Walk)
add_btn(all_btn(), Conference)
add_btn(all_btn(), Club)
add_btn(all_btn(), journal)
add_btn(all_btn(), knowhow)
add_btn(all_btn(), buy)
add_btn(all_btn(), sell)
add_btn(all_btn(), eat)
add_btn(all_btn(), buzz)
add_btn(all_btn(), tip)

; dead = 1 ; (стартовое состояние)

Repeat 
  event = WaitWindowEvent()
  If dead
    ForEach all_btn()
      Hide(all_btn())
    Next
    dead = 0
  EndIf
  
  If event = #PB_Event_Gadget
    Select EventGadget()
      Case google
        Debug "google"
        Hide(read_forum)
      Case read_forum
        Show(stack)
      Case stack
        Show(read_forum)
        Debug "stack"
      Case ask_friend
        Show(github)
        Debug "ask_fr"
      Case github
        Debug "github"
      Case Text
        Debug "It works"
      Case Html
        Debug "It works"
      Case Design
        Debug "It works"
      Case Backup
        Debug "It works"
      Case Buy_Text
        Debug "It works"
      Case Buy_Html
        Debug "It works"
      Case Buy_Design
        Debug "It works"
      Case Buy_Domain
        Debug "It works"
      Case Buy_Hosting
        Debug "It works"
      Case Sell_Text
        Debug "It works"
      Case Sell_Html
        Debug "It works"
      Case Sell_Design
        Debug "It works"
      Case Noodles
        Debug "It works"
      Case McDonut
        Debug "It works"
      Case Home_Food
        Debug "It works"
      Case Walk
        Debug "It works"
      Case Conference
        Debug "It works"
      Case Club
        Debug "It works"
    EndSelect
  EndIf
  
Until event = #PB_Event_CloseWindow
