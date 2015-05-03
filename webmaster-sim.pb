;добавлять в код ссылку на блогозапись, чтобы были перекрёстные ссылки и можно было в коде понять за какой это день 
;http://at02.ru/easy-to-work-with-plan
;расписать даты в расписании работ
;добавить расписание работ прямо в код!

;1 — 6 дни оживляем каждый столбец кнопок (2 мая)
;7 день тестим, правим косяки(3 мая)
;8 день придумываем десяток рандомных событий(4 мая)
;9 — 10 дни вносим рандом в игру(6 мая)
;11 тестим, даём тестить друзьям, правим косяки(7 мая)

;почему не работает и не исчезает кнопка Win? думал дело в имени, переименовал - нифига. 
;вставил дебаг просто на нажатие. не работает! мистика
;переместил её выше. всё равно не работает. интересно, как вывести название переменной в Debug?

Global Window_0
Global forum, google, stack, friend, github, Make_Text, Make_Html, Make_Design, Make_Backup
Global Buy_Text, Buy_Html, Buy_Design, Buy_Domain, Buy_Hosting
Global Sell_Text, Sell_Html, Sell_Design, Noodles, McDonut, Home_Food, Walk, Conference, Club
Global journal, knowledge, knowhow, buy, sell, eat, buzz, tip
Global Text_cnt, Html_cnt, Design_cnt, Money, Day, Lives_cnt, Mood_cnt
Global NewList all_btn()

Procedure OpenWindow_0(width = 670, height = 400)
  Window_0 = OpenWindow(#PB_Any, #PB_Ignore, #PB_Ignore, width, height, "Мумулятор вебмастера v0.2", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
  forum = ButtonGadget(#PB_Any, 10, 60, 100, 25, "Read Forum")
  google = ButtonGadget(#PB_Any, 10, 30, 100, 25, "Google")
  stack = ButtonGadget(#PB_Any, 10, 90, 100, 25, "Stackoverflow")
  friend = ButtonGadget(#PB_Any, 10, 120, 100, 25, "Friend")
  github = ButtonGadget(#PB_Any, 10, 150, 100, 25, "Github")
  Make_Text = ButtonGadget(#PB_Any, 120, 30, 100, 25, "Text: 0")
  Make_Html = ButtonGadget(#PB_Any, 120, 60, 100, 25, "Html: 0")
  Make_Design = ButtonGadget(#PB_Any, 120, 90, 100, 25, "Design: 0")
  Make_Backup = ButtonGadget(#PB_Any, 120, 120, 100, 25, "Backup: N")
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
  WeGotWinner = ButtonGadget(#PB_Any, 560, 150, 100, 25, "Win")
  journal = EditorGadget(#PB_Any, 10, 180, 650, 210)
  knowledge = TextGadget(#PB_Any, 10, 10, 100, 20, "Знания")
  knowhow = TextGadget(#PB_Any, 120, 10, 100, 20, "Умения")
  buy = TextGadget(#PB_Any, 230, 10, 100, 20, "Купить")
  sell = TextGadget(#PB_Any, 340, 10, 100, 20, "Заработать")
  eat = TextGadget(#PB_Any, 450, 10, 100, 20, "Кушать")
  buzz = TextGadget(#PB_Any, 560, 10, 100, 20, "Развлекаться")
  comment = TextGadget(#PB_Any, 340, 150, 310, 20, "Здоровье, настрой и деньги в журнал ↓") ; убрать в финальном релизе
EndProcedure

OpenWindow_0()

Procedure add_btn(name_of_btn)
  AddElement(all_btn())
  all_btn() = name_of_btn
EndProcedure

add_btn(forum)
add_btn(stack)
add_btn(friend)
add_btn(github)
add_btn(Make_Text)
add_btn(Make_Html)
add_btn(Make_Design)
add_btn(Make_Backup)
add_btn(Buy_Text)
add_btn(Buy_Html)
add_btn(Buy_Design)
add_btn(Buy_Domain)
add_btn(Buy_Hosting)
add_btn(Sell_Text)
add_btn(Sell_Html)
add_btn(Sell_Design)
;add_btn(Noodles)
add_btn(McDonut)
add_btn(Home_Food)
;add_btn(Walk)
add_btn(Conference)
add_btn(Club)
add_btn(WeGotWinner)
add_btn(knowhow)
add_btn(buy)
add_btn(sell)
;add_btn(eat)
;add_btn(buzz)

Procedure tip(txt$)
  Day+1
  Lives_cnt-1
  Mood_cnt-1
  AddGadgetItem(journal,0,FormatDate("%yyyy.%mm.%dd %hh:%ii:%ss", Date())+ " День: " + Str(Day)+" $: "+Str(Money)+" (: "+
                          Str(Mood_cnt)+" Сыт: "+Str(Lives_cnt)+" "+txt$)
EndProcedure

Procedure add_text(numtext)
  Text_cnt + numtext
  SetGadgetText(Make_Text,"Text: " + Str(Text_cnt))
EndProcedure

Procedure add_html(numhtml)
  Html_cnt + numhtml
  SetGadgetText(Make_Html,"Html: " + Str(Html_cnt))
EndProcedure

Procedure add_design(numdes)
  Design_cnt + numdes
  SetGadgetText(Make_Design,"Design: " + Str(Design_cnt))
EndProcedure

Procedure Money(num)
  Money + num
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
    Debug "No btn to hide" + Str(name_of_btn)
  EndIf
EndProcedure

Procedure Show(name_of_btn) ; почему-то не работает
  If name_of_btn
    HideGadget(name_of_btn,0)
  Else
    Debug "No btn to show" + Str(name_of_btn)
  EndIf
EndProcedure

Sell_Text_Price = 200

Buy_Text_Price = 100
Buy_Html_Price = 500
Buy_Design_Price = 800
Buy_Hosting_Price = 700
Buy_Domain_Price = 600

Procedure start()
  Lives_cnt = 10
  Mood_cnt = 10
  tip("Let get this party started")
EndProcedure
dead = 1 ; (стартовое состояние)
start()

Repeat 
  event = WaitWindowEvent()
  ;помощ друга в первый раз, близко к смерти (может вырубить при этом все кнопки?)
  If Lives_cnt <= 1
    HideGadget(friend,0)
  EndIf
  
  ; если умер - спрятать все кнопки
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
        Select how_many_google
          Case 1
            HideGadget(sell,0)
            HideGadget(Make_Text,0)
            HideGadget(knowhow,0)
            HideGadget(Sell_Text,0)
            tip("Вы узнали что можно писать тексты на продажу")
          Case 2
            HideGadget(forum,0)
            tip("Вы аткнулись на форум вебмастеров")
          Case 3 To 9
            tip("Гугл кончился")
          Case 10
            tip("Вы заработали достижение Гуглер. Распечатайте и повесьте на стену")
          Case 11 To 999
            tip("Дальше ничего не произойдёт. Правда")
        EndSelect
        tip("Вы погуглили "+Str(how_many_google)+" раз")
        
      Case forum
        how_many_forum = how_many_forum + 1
        Select how_many_forum
          Case 1
            HideGadget(stack,0)
            tip("На форуме вам дали ссылку на stackowerflow")
          Case 2
            HideGadget(github,0)
            tip("Вам посоветовали почитать исходники на github")
          Case 3
            HideGadget(buy,0)
            HideGadget(Buy_Text,0)
            tip("Вам дали ссылку на биржу контента. Теперь вы можете покупать тексты")
          Case 4
            HideGadget(Buy_Html,0)
            tip("Вам дали ссылку на фриланс. Вы можете покупать html. Это дешевле чем делать самому")
          Case 5
            HideGadget(Buy_Design,0)
            tip("Теперь вы можете покупать дизайн. ")
          Case 6
            tip("Снижение цен на покупку дизайна, текстов и кода!")
            Buy_Text_Price = 90
            Buy_Html_Price = 450
            Buy_Design_Price = 750
        EndSelect
        tip("Вы почитали форум "+Str(how_many_forum)+" раз")
        
      Case stack
        how_many_stack = how_many_stack + 1
        tip("Вы поискали на stackowerflow "+Str(how_many_stack)+" раз")
        Select how_many_stack
          Case 1
            HideGadget(Make_Design,0)
            tip("Вы изучили как делать дизайн")
          Case 2
            HideGadget(Sell_Design,0)
            tip("Вы познали как продать ваш дизайн")
          Case 3
            HideGadget(McDonut,0)
            tip("Вам посоветовали сходить в McDonuts вместо вечного поедания дошираков")
        EndSelect
        
      Case friend
        how_many_friend = how_many_friend + 1
        Select how_many_friend
          Case 1
            HideGadget(Noodles,0)
            Lives(10)
            tip("Друг принёс вам запас дошираков. И посоветовал следить за сытостью")
          Case 2
            HideGadget(Make_Backup,0)
            tip("Друг рассказал вам о пользе резервного копирования")
          Case 3
            tip("Вы напились с другом. Не можете работать 2 дня")
          Case 4
            tip("Вы снова напились с другом. Код/текст/дизайн x2")
        EndSelect
        tip("Вы поговорили с другом "+Str(how_many_friend)+" раз")
        
      Case github
        how_many_github = how_many_github + 1
        Select how_many_github
          Case 1
            HideGadget(Make_Html,0)
            tip("Знания html вёрстки снизошли на вас")
          Case 2
            HideGadget(Sell_Html,0)
            tip("Как деньги получить за говнокод свой познали")
          Case 3
            HideGadget(Conference,0)
            tip("Читая чей-то код на github вы узнали что можно сходить на конференцию")
        EndSelect
        tip("Вы покурили github "+Str(how_many_github)+" раз")
        
      Case Make_Text
        add_text(1)
        tip("Вы написали "+Str(Text_cnt)+" текст")
      Case Make_Html
        add_html(1)
        tip("Вы наверстали "+Str(Html_cnt)+" html")
      Case Make_Design
        add_design(1)
        tip("Вы нарисовали "+Str(Design_cnt)+" psd")
      Case Make_Backup
        SetGadgetText(Make_Backup,"Backup: Y")
        DisableGadget(Make_Backup,1)
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
        If Money >= Buy_Hosting_Price
          Money(-Buy_Hosting_Price)
          SetGadgetText(Buy_Hosting,"Hosting: Y")
          DisableGadget(Buy_Hosting,1)
          tip("Вы купили хостинг за "+Str(Buy_Hosting_Price))
        ElseIf Money < Buy_Hosting_Price
          tip("Недостаточно денег. Нужно "+Str(Buy_Hosting_Price))
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
      Case WeGotWinner ; не работает
        Debug "Win btn pressed"
        If trigger
          ForEach all_btn()
            DisableGadget(all_btn(),1)
          Next
          trigger = 0
        Else
          ForEach all_btn()
            DisableGadget(all_btn(),0)
          Next
        EndIf
    EndSelect
  EndIf
  
Until event = #PB_Event_CloseWindow
