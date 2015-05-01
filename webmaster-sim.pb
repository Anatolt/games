Global Window_0

Global forum, google, stack, friend, github, Text, Html, Design, Backup
Global Buy_Text, Buy_Html, Buy_Design, Buy_Domain, Buy_Hosting
Global Sell_Text, Sell_Html, Sell_Design, Noodles, McDonut, Home_Food, Walk, Conference, Club
Global journal, knowledge, knowhow, buy, sell, eat, buzz, tip
Global NewList all_btn()
Global Text_cnt, Html_cnt, Design_cnt, Money, Day, Lives_cnt, Mood_cnt

Procedure OpenWindow_0(width = 670, height = 400)
  Window_0 = OpenWindow(#PB_Any, #PB_Ignore, #PB_Ignore, width, height, "Симулятор неунывающего вебмастера v0.2", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
  forum = ButtonGadget(#PB_Any, 10, 60, 100, 25, "Read Forum")
  google = ButtonGadget(#PB_Any, 10, 30, 100, 25, "Google")
  stack = ButtonGadget(#PB_Any, 10, 90, 100, 25, "Stackoverflow")
  friend = ButtonGadget(#PB_Any, 10, 120, 100, 25, "Friend")
  github = ButtonGadget(#PB_Any, 10, 150, 100, 25, "Github")
  Text = ButtonGadget(#PB_Any, 120, 30, 100, 25, "Text: 0")
  Html = ButtonGadget(#PB_Any, 120, 60, 100, 25, "Html: 0")
  Design = ButtonGadget(#PB_Any, 120, 90, 100, 25, "Design: 0")
  Backup = ButtonGadget(#PB_Any, 120, 120, 100, 25, "Backup: N")
  Buy_Text = ButtonGadget(#PB_Any, 230, 30, 100, 25, "Buy Text")
  Buy_Html = ButtonGadget(#PB_Any, 230, 60, 100, 25, "Buy Html")
  Buy_Design = ButtonGadget(#PB_Any, 230, 90, 100, 25, "Buy Design")
  Buy_Domain = ButtonGadget(#PB_Any, 230, 120, 100, 25, "Domain: N")
  Buy_Hosting = ButtonGadget(#PB_Any, 230, 150, 100, 25, "Hosting: N")
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
  comment = TextGadget(#PB_Any, 340, 150, 310, 20, "Здоровье, настрой и деньги в журнал ↓") ; убрать в финальном релизе
  Win = ButtonGadget(#PB_Any, 560, 150, 100, 25, "Win")
EndProcedure

OpenWindow_0()

Procedure tip(txt$)
  Day+1
  AddGadgetItem(journal,0,FormatDate("%yyyy.%mm.%dd %hh:%ii:%ss", Date())+ " День: " + Str(Day)+" Денег: "+Str(Money)+"р "+" Настрой: "+
                          Str(Mood_cnt)+" Сытость: "+Str(Lives_cnt)+" "+txt$)
EndProcedure

Procedure add_text(numtext)
  Text_cnt + numtext
  SetGadgetText(Text,"Text: " + Str(Text_cnt))
EndProcedure

Procedure add_html(numhtml)
  Html_cnt + numhtml
  SetGadgetText(Html,"Html: " + Str(Html_cnt))
EndProcedure

Procedure add_design(numdes)
  Design_cnt + numdes
  SetGadgetText(Design,"Design: " + Str(Design_cnt))
EndProcedure

Procedure Money(num)
  If num < 0
    If Money < -num
      Debug "Недостаточно денег" ;не работает
    Else
      Money + num
    EndIf
  Else
    Money + num
  EndIf
EndProcedure

Procedure Mood(num)
  Mood_cnt + num
EndProcedure

Procedure Lives(num)
  Lives_cnt + num
EndProcedure

Procedure Hide(name_of_btn)
  If name_of_btn
    HideGadget(name_of_btn,1)
  Else
    Debug "No btn"
  EndIf
EndProcedure

Procedure Show(name_of_btn) ; почему-то не работает
  If name_of_btn
    HideGadget(name_of_btn,0)
  Else
    Debug "No btn"
  EndIf
EndProcedure

NewList all_btn()

Procedure add_btn(name_of_btn)
  AddElement(all_btn())
  all_btn() = name_of_btn
EndProcedure

add_btn(forum)
add_btn(stack)
add_btn(friend)
add_btn(github)
add_btn(Text)
add_btn(Html)
add_btn(Design)
add_btn(Backup)
add_btn(Buy_Text)
add_btn(Buy_Html)
add_btn(Buy_Design)
add_btn(Buy_Domain)
add_btn(Buy_Hosting)
add_btn(Sell_Text)
add_btn(Sell_Html)
add_btn(Sell_Design)
add_btn(Noodles)
add_btn(McDonut)
add_btn(Home_Food)
add_btn(Walk)
add_btn(Conference)
add_btn(Club)
add_btn(journal)
add_btn(knowhow)
add_btn(buy)
add_btn(sell)
add_btn(eat)
add_btn(buzz)

Sell_Text_Price = 200

Buy_Text_Price = 100
Buy_Html_Price = 500
Buy_Design_Price = 800
Buy_Hosting_Price = 600
Buy_Domain_Price = 500

; dead = 1 ; (стартовое состояние)
tip("Let get this party started")
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
        how_many_google = how_many_google + 1
        tip("Вы погуглили "+Str(how_many_google)+" раз")
      Case forum
        how_many_forum = how_many_forum + 1
        tip("Вы почитали форум "+Str(how_many_forum)+" раз")
      Case stack
        how_many_stack = how_many_stack + 1
        tip("Вы поискали на stackowerflow "+Str(how_many_stack)+" раз")
      Case friend
        how_many_friend = how_many_friend + 1
        tip("Вы поговорили с другом "+Str(how_many_friend)+" раз")
      Case github
        how_many_github = how_many_github + 1
        tip("Вы покурили github "+Str(how_many_github)+" раз")
      Case Text
        add_text(1)
        tip("Вы написали "+Str(Text_cnt)+" текст")
      Case Html
        add_html(1)
        tip("Вы наверстали "+Str(Html_cnt)+" html")
      Case Design
        add_design(1)
        tip("Вы нарисовали "+Str(Design_cnt)+" psd")
      Case Backup
        SetGadgetText(Backup,"Backup: Y")
        DisableGadget(Backup,1)
        tip("Вы сделали бекап")
      Case Buy_Text
        If Money >= Buy_Text_Price
          Money(-Buy_Text_Price)
          add_text(1)
          tip("Вы купили текст за "+Str(Buy_Text_Price))
        ElseIf Money < Buy_Text_Price
          tip("Недостаточно денег. Нужно "+Str(Buy_Text_Price))
        EndIf
      Case Buy_Html
        If Money >= Buy_Html_Price
          Money(-Buy_Html_Price)
          add_html(1)
          tip("Вы купили html за "+Str(Buy_Html_Price))
        ElseIf Money < Buy_Html_Price
          tip("Недостаточно денег. Нужно "+Str(Buy_Html_Price))
        EndIf
      Case Buy_Design
        If Money >= Buy_Design_Price
          Money(-Buy_Design_Price)
          add_design(1)
          tip("Вы купили дизайн за "+Str(Buy_Design_Price))
        ElseIf Money < Buy_Design_Price
          tip("Недостаточно денег. Нужно "+Str(Buy_Design_Price))
        EndIf
      Case Buy_Domain
        If Money >= 600
          Money(-600)
          SetGadgetText(Buy_Domain,"Domain: Y")
          DisableGadget(Buy_Domain,1)
          tip("Вы купили домен за 600")
        ElseIf Money < 600
          tip("Недостаточно денег. Нужно 600")
        EndIf
      Case Buy_Hosting
        If Money >= 700
          Money(-700)
          SetGadgetText(Buy_Hosting,"Hosting: Y")
          DisableGadget(Buy_Hosting,1)
          tip("Вы купили хостинг за 700")
        ElseIf Money < 700
          tip("Недостаточно денег. Нужно 700")
        EndIf
      Case Sell_Text
        If Text_cnt <= 0
          tip("Вы не можете продать текст. У вас его нет")
        ElseIf Text_cnt > 0
          add_text(-1)
          Money(Sell_Text_Price)
          tip("Вы продали текст. +"+Str(Sell_Text_Price))
        EndIf
      Case Sell_Html
        If Html_cnt <= 0
          tip("Вы не можете продать html. У вас его нет")
        ElseIf Html_cnt > 0
          add_html(-1)
          Money(1000)
          tip("Вы продали html. +1000")
        EndIf
      Case Sell_Design
        If Design_cnt <= 0
          tip("Вы не можете продать дизайн. У вас его нет")
        ElseIf Design_cnt > 0
          add_design(-1)
          Money(1200)
          tip("Вы продали дизайн. +1200")
        EndIf
      Case Noodles
        Money(-100)
        Lives(2)
        tip("Вы поели макарон")
      Case McDonut
        Money(-200)
        Lives(4)
        tip("Вы перекусили в Макдаке")
      Case Home_Food
        Money(-300)
        Lives(10)
        Mood(1)
        tip("Вы насладились домашней едой")
      Case Walk
        Mood(2)
        tip("Вы прогулялись")
      Case Conference
        Mood(4)
        tip("Вы посетили конфенцию. Получили новые знания")
      Case Club
        Mood(10)
        Money(-5000)
        tip("Вы потусили в клубе. ")
      Case Win ; не работает
        ForEach all_btn()
          DisableGadget(all_btn(),1)
        Next
    EndSelect
  EndIf
  
Until event = #PB_Event_CloseWindow
