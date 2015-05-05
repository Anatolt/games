; попробовал EnableExplicit - ругается на необъявленные в  Define, Global, Protected или Static переменные. Мне не подходит, ибо у меня таких переменных много
; переделал всё на Enumeration. Проверил. Работает.

;план
;1 — 6 дни оживляем каждый столбец кнопок (2 мая)
;7 день тестим, правим косяки(3 мая)
;8 день придумываем десяток рандомных событий(4 мая)
;9 — 10 дни вносим рандом в игру(6 мая)
;11 тестим, даём тестить друзьям, правим косяки(7 мая)

;текущие задачи
;просклонять разы
;сделать чтобы появлялись подсказки к кнопкам после их использования
;контроль настроения (сейчас оно ни на что не влияет)
;убрать жизни из процедуры tip 
;убрать двойные tip (напр. пригуглении вылазит сразу 2 строки. это неправильно)
;уменьшать настроение только если пользователь несколько раз жмёт на одну и ту же кнопку
;научиться привязывать события к количеству прошедших дней (напр. не может работать 2 дня)
;применить ProcedureReturn на проверке денег. Убрать проверку денег из кода кнопок
;переписать все Enumeration

;сверх-задачи
;нарисовать интерфейс
;автоматическая отправка лога по http

Global Text_cnt, Html_cnt, Design_cnt, Money, Day, Lives_cnt, Mood_cnt
Global how_many_conference, how_many_forum, how_many_friend, how_many_github, how_many_google, how_many_stack ;нужно для работы start()

Enumeration
  #Wnd
  #forum
  #stack
  #friend
  #github
  #Make_Text
  #Make_Html
  #Make_Design
  #Make_Backup
  #Buy_Text
  #Buy_Html
  #Buy_Design
  #Buy_Domain
  #Buy_Hosting
  #Sell_Text
  #Sell_Html
  #Sell_Design
  #McDonut
  #Home_Food
  #Conference
  #knowhow
  #buy
  #sell
  #Club ;все что ниже - не прячется при смерти
  #google
  #Walk
  #Noodles
  #knowledge
  #eat
  #buzz
  #comment ;удалить
  #journal
  #WeGotWinner ;переместить наверх, чтобы скрыть
EndEnumeration

Procedure OpenWindow_0(width = 670, height = 400)
  OpenWindow(#Wnd, #PB_Ignore, #PB_Ignore, width, height, "Лялялятор вебмастера v0.2", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
  ButtonGadget(#google, 10, 30, 100, 25, "Google")
  ButtonGadget(#forum, 10, 60, 100, 25, "Read Forum")
  ButtonGadget(#stack, 10, 90, 100, 25, "Stackoverflow")
  ButtonGadget(#friend, 10, 120, 100, 25, "Friend")
  ButtonGadget(#github, 10, 150, 100, 25, "Github")
  ButtonGadget(#Make_Text, 120, 30, 100, 25, "Text: 0")
  ButtonGadget(#Make_Html, 120, 60, 100, 25, "Html: 0")
  ButtonGadget(#Make_Design, 120, 90, 100, 25, "Design: 0")
  ButtonGadget(#Make_Backup, 120, 120, 100, 25, "Backup: N")
  ButtonGadget(#Buy_Text, 230, 30, 100, 25, "Buy Text")
  ButtonGadget(#Buy_Html, 230, 60, 100, 25, "Buy Html")
  ButtonGadget(#Buy_Design, 230, 90, 100, 25, "Buy Design")
  ButtonGadget(#Buy_Domain, 230, 120, 100, 25, "Domain: N")
  ButtonGadget(#Buy_Hosting, 230, 150, 100, 25, "Hosting: N")
  ButtonGadget(#Sell_Text, 340, 30, 100, 25, "Sell Text")
  ButtonGadget(#Sell_Html, 340, 60, 100, 25, "Sell Html")
  ButtonGadget(#Sell_Design, 340, 90, 100, 25, "Sell Design")
  ButtonGadget(#Noodles, 450, 30, 100, 25, "Noodles")
  ButtonGadget(#McDonut, 450, 60, 100, 25, "McDonut")
  ButtonGadget(#Home_Food, 450, 90, 100, 25, "Home Food")
  ButtonGadget(#Walk, 560, 30, 100, 25, "Walk")
  ButtonGadget(#Conference, 560, 90, 100, 25, "Conference")
  ButtonGadget(#Club, 560, 60, 100, 25, "Club")
  EditorGadget(#journal, 10, 180, 650, 210)
  TextGadget(#knowledge, 10, 10, 100, 20, "Знания")
  TextGadget(#knowhow, 120, 10, 100, 20, "Умения")
  TextGadget(#buy, 230, 10, 100, 20, "Купить")
  TextGadget(#sell, 340, 10, 100, 20, "Заработать")
  TextGadget(#eat, 450, 10, 100, 20, "Кушать")
  TextGadget(#buzz, 560, 10, 100, 20, "Развлекаться")
  TextGadget(#comment, 340, 150, 310, 20, "Здоровье, настрой и деньги в журнал ↓") ; убрать в финальном релизе
  ButtonGadget(#WeGotWinner, 560, 150, 100, 25, "Win")
EndProcedure

OpenWindow_0()

Procedure tip(txt$)
  Day+1
  Lives_cnt-1
  Mood_cnt-1
  say$ = FormatDate("%yyyy.%mm.%dd %hh:%ii:%ss",Date()) + " День:"+Str(Day)+" $:"+Str(Money)+" ☯:"+
         Str(Mood_cnt)+" ♥:"+Str(Lives_cnt)+" "+txt$
  AddGadgetItem(#journal,0,say$)
  Debug say$ 
EndProcedure

; в процедуру попадает несколько слов. все с маленькой буквы. 
; она выстраивает их в произвольном порядке, а для первого слова делает большой первую букву
Procedure.s rtip(txt$)
  Day+1
  Lives_cnt-1
  Mood_cnt-1
  txt$ = LCase(Mid(txt$,0,1))+Mid(txt$,2)
  Debug txt$
  NewList words.s()
  ;
  LenghWord = FindString(txt$," ")
  word$ = Mid(txt$,startSearch,LenghWord-startSearch-1)
  AddElement(words())
  words() = word$
  word_cnt + 1
  startSearch = LenghWord + 1
  ; если удалить кусок кода выше - прога добавляет лишний пробел после первого слова
  While Not LenghWord = 0
    word$ = Mid(txt$,startSearch,LenghWord-startSearch)
    AddElement(words())
    words() = word$
    word_cnt + 1
    startSearch = LenghWord + 1
    LenghWord = FindString(txt$," ",startSearch)
  Wend
  ;
  word$ = Mid(txt$,startSearch,Len(txt$)-1)
  AddElement(words())
  words() = word$
  word_cnt + 1
  ;если удалить кусок кода выше - то пропадает последнее слово
  RandomizeList(words())
  ForEach words()
    output$ + words() + " "; а вот эта зараза добавляет лишнюю _ куда-попало.
  Next
  output$ = FormatDate("%yyyy.%mm.%dd %hh:%ii:%ss",Date()) + " День:"+Str(Day)+" $:"+Str(Money)+" ☯:"+
            Str(Mood_cnt)+" ♥:"+Str(Lives_cnt)+" "+UCase(Mid(output$,0,1))+Mid(output$,2)
  AddGadgetItem(#journal,0,output$)
EndProcedure

Procedure add_text(numtext)
  Text_cnt + numtext
  SetGadgetText(#Make_Text,"Text: " + Str(Text_cnt))
EndProcedure

Procedure add_html(numhtml)
  Html_cnt + numhtml
  SetGadgetText(#Make_Html,"Html: " + Str(Html_cnt))
EndProcedure

Procedure add_design(numdes)
  Design_cnt + numdes
  SetGadgetText(#Make_Design,"Design: " + Str(Design_cnt))
EndProcedure

Procedure Money(num)
  If num < 0
    If Money < -num
      tip("Недостаточно денег")
      Debug "Недостаточно денег"
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
    Debug "No btn to hide" + Str(name_of_btn)
  EndIf
EndProcedure

Procedure Show(name_of_btn)
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
  Text_cnt = 0
  Html_cnt = 0
  Design_cnt = 0
  how_many_conference = 0
  how_many_google = 0
  how_many_forum = 0
  how_many_friend = 0
  how_many_stack = 0
  how_many_github = 0
  tip("Let get this party started")
EndProcedure
dead = 1 ; (стартовое состояние)
start()

Repeat 
  event = WaitWindowEvent()
  ;помощ друга в первый раз, близко к смерти (может вырубить при этом все кнопки?)
  If Lives_cnt <= 1
    Show(#friend)
  EndIf
  
  ; если умер - спрятать все кнопки
  If dead
    For i = #forum To #Club
      Hide(i)
    Next
    dead = 0
  EndIf
  
  ;проверка жизней
  If Lives_cnt <= 0
    Result = MessageRequester("Костлявая","Вы погибли от голода")
    dead = 1
    starving = starving + 1
    tip("Вы погибли от голода")
    start()
  ElseIf Lives_cnt >= 101
    Result = MessageRequester("Костлявая","Куда столько жрать?")
    dead = 1
    overeat = overeat + 1
    tip("Вы погибли от переедания")
    start()
  Else ;если жизни есть запускаем основной цикл
    If event = #PB_Event_Gadget
      Select EventGadget()
        Case #google
          how_many_google + 1
          Select how_many_google
            Case 1
              Show(#sell)
              Show(#Make_Text)
              Show(#knowhow)
              Show(#Sell_Text)
              tip("Вы узнали что можно писать тексты на продажу")
            Case 2
              Show(#forum)
              tip("Вы наткнулись_на форум вебмастеров")
            Case 3 To 9
              tip("Гугл кончился")
            Case 10
              tip("Вы заработали достижение Гуглер. Распечатайте и повесьте на стену")
            Case 11
              tip("Дальше ничего не произойдёт. Правда")
          EndSelect
          rtip("Вы погуглили "+Str(how_many_google)+" раз")
          
        Case #forum
          how_many_forum = how_many_forum + 1
          Select how_many_forum
            Case 1
              Show(#stack)
              tip("На форуме вам дали ссылку на stackowerflow")
            Case 2
              Show(#github)
              tip("Вам посоветовали почитать исходники на github")
            Case 3
              Show(#buy)
              Show(#Buy_Text)
              tip("Вам дали ссылку на биржу контента. Теперь вы можете покупать тексты")
            Case 4
              Show(#Buy_Html)
              tip("Вам дали ссылку на фриланс. Вы можете покупать html. Это дешевле чем делать самому")
            Case 5
              Show(#Buy_Design)
              tip("Теперь вы можете покупать дизайн. ")
            Case 6
              tip("Снижение цен на покупку дизайна, текстов и кода!")
              Buy_Text_Price = 90
              Buy_Html_Price = 450
              Buy_Design_Price = 750
          EndSelect
          rtip("Вы почитали форум "+Str(how_many_forum)+" раз")
          
        Case #stack
          how_many_stack = how_many_stack + 1
          tip("Вы поискали на stackowerflow "+Str(how_many_stack)+" раз")
          Select how_many_stack
            Case 1
              Show(#Make_Design)
              rtip("Вы изучили как_делать дизайн")
            Case 2
              Show(#Sell_Design)
              rtip("Вы познали как_продать ваш дизайн")
            Case 3
              Show(#McDonut)
              rtip("Вам посоветовали сходить в_McDonuts вместо вечного поедания дошираков")
          EndSelect
          
        Case #friend
          how_many_friend = how_many_friend + 1
          Select how_many_friend
            Case 1
              Show(#Noodles)
              Lives(10)
              tip("Друг принёс вам запас дошираков. И посоветовал следить за сытостью")
            Case 2
              Show(#Make_Backup)
              tip("Друг рассказал вам о пользе резервного копирования")
            Case 3
              tip("Вы напились с другом. Не можете работать 2 дня")
            Case 4
              tip("Вы снова напились с другом. Код/текст/дизайн x2")
            Case 5
              Show(#Club)
              tip("Друг поведал вам о существовании клуба. Подымает настроение")
          EndSelect
          tip("Вы поговорили с другом "+Str(how_many_friend)+" раз")
          
        Case #github
          how_many_github = how_many_github + 1
          Select how_many_github
            Case 1
              Show(#Make_Html)
              tip("Знания html вёрстки снизошли на вас")
            Case 2
              Show(#Sell_Html)
              tip("Как деньги получить за говнокод свой познали")
            Case 3
              Show(#Conference)
              tip("Читая чей-то код на github вы узнали что можно сходить на конференцию")
          EndSelect
          tip("Вы покурили github "+Str(how_many_github)+" раз")
          
        Case #Make_Text
          add_text(1)
          rtip("Вы написали "+Str(Text_cnt)+" текст")
        Case #Make_Html
          add_html(1)
          rtip("Вы наверстали "+Str(Html_cnt)+" html")
        Case #Make_Design
          add_design(1)
          rtip("Вы нарисовали "+Str(Design_cnt)+" psd")
        Case #Make_Backup
          SetGadgetText(#Make_Backup,"Backup: Y")
          DisableGadget(#Make_Backup,1)
          rtip("Вы сделали бекап")
          
        Case #Buy_Text
          If Money >= Buy_Text_Price
            Money(-Buy_Text_Price)
            add_text(1)
            tip("Вы купили текст за "+Str(Buy_Text_Price))
          ElseIf Money < Buy_Text_Price
            tip("Недостаточно денег. Нужно "+Str(Buy_Text_Price))
          EndIf
        Case #Buy_Html
          If Money >= Buy_Html_Price
            Money(-Buy_Html_Price)
            add_html(1)
            tip("Вы купили html за "+Str(Buy_Html_Price))
          ElseIf Money < Buy_Html_Price
            tip("Недостаточно денег. Нужно "+Str(Buy_Html_Price))
          EndIf
        Case #Buy_Design
          If Money >= Buy_Design_Price
            Money(-Buy_Design_Price)
            add_design(1)
            tip("Вы купили дизайн за "+Str(Buy_Design_Price))
          ElseIf Money < Buy_Design_Price
            tip("Недостаточно денег. Нужно "+Str(Buy_Design_Price))
          EndIf
        Case #Buy_Domain
          If Money >= 600
            Money(-600)
            SetGadgetText(#Buy_Domain,"Domain: Y")
            DisableGadget(#Buy_Domain,1)
            tip("Вы купили домен за 600")
          ElseIf Money < 600
            tip("Недостаточно денег. Нужно 600")
          EndIf
        Case #Buy_Hosting
          If Money >= Buy_Hosting_Price
            Money(-Buy_Hosting_Price)
            SetGadgetText(#Buy_Hosting,"Hosting: Y")
            DisableGadget(#Buy_Hosting,1)
            tip("Вы купили хостинг за "+Str(Buy_Hosting_Price))
          ElseIf Money < Buy_Hosting_Price
            tip("Недостаточно денег. Нужно "+Str(Buy_Hosting_Price))
          EndIf
          
        Case #Sell_Text
          If Text_cnt <= 0
            tip("Вы не можете продать текст. У вас его нет")
          ElseIf Text_cnt > 0
            add_text(-1)
            Money(Sell_Text_Price)
            tip("Вы продали текст. +"+Str(Sell_Text_Price))
          EndIf
        Case #Sell_Html
          If Html_cnt <= 0
            tip("Вы не можете продать html. У вас его нет")
          ElseIf Html_cnt > 0
            add_html(-1)
            Money(1000)
            tip("Вы продали html. $ +1000")
          EndIf
        Case #Sell_Design
          If Design_cnt <= 0
            tip("Вы не можете продать дизайн. У вас его нет")
          ElseIf Design_cnt > 0
            add_design(-1)
            Money(1200)
            tip("Вы продали дизайн. $ +1200")
          EndIf
          
        Case #Noodles
          If Money > 100
            Money(-100)
            Lives(20)
            tip("Вы поели макарон. ♥ +20")
          Else
            Lives(1)
            rtip("Недостаточно денег. Надо 100")
          EndIf
        Case #McDonut
          If Money > 200
            Money(-200)
            Lives(40)
            tip("Вы перекусили в Макдаке. ♥ +40")
          Else
            Lives(1)
            tip("Недостаточно денег на макдак. Надо 200")
          EndIf
        Case #Home_Food
          If Money > 300
            Money(-300)
            Lives_cnt = 100
            Mood(1)
            tip("Вы насладились домашней едой. ♥ full")
          Else
            Lives(1)
            tip("Недостаточно денег на домашнюю еду. Надо 300")
          EndIf
          
        Case #Walk
          Mood(2)
          tip("Вы прогулялись")
        Case #Conference
          how_many_conference = how_many_conference + 1
          Select how_many_conference
            Case 1
              Show(#Buy_Hosting)
              Mood(40)
              tip("Вы посетили конференцию. Узнали как купить хостинг. ☯ +40")
            Case 2
              Show(#Buy_Domain)
              Mood(40)
              tip("Вы посетили конференцию. Узнали как купить домен. ☯ +40")
            Case 3 To 999
              Mood(40)
              tip("Вы посетили конференцию. ☯ +40")
          EndSelect
        Case #Club
          If Money > 5000
            how_many_club = how_many_club + 1
            Mood_cnt = 100
            Money(-5000)
            Select how_many_club
              Case 1
                tip("Вы потусили в клубе. ☯ full")
              Case 2
                Show(#Home_Food)
                tip("Вы познакомились с девушкой в клубе. Доступна домашняя еда")
              Case 3 To 999
                tip("Вы потусили в клубе. ☯ full")
            EndSelect
          Else
            tip("Недостаточно денег на клуб. Надо 5000.")
          EndIf
          
        Case #WeGotWinner
          If Text_cnt >= 50 And Html_cnt >= 3 And Design_cnt >= 3 And GetGadgetText(#Buy_Domain) = "Domain: Y" And GetGadgetText(#Buy_Hosting) = "Hosting: Y"
            Result = MessageRequester("Финиш","Вы сделали полноценный сайт и выиграли. Отправьте пожалуйста журнал мне на почту (указана в журнале)")
            AddGadgetItem(#journal,0,"Вы сделали полноценный сайт и выиграли. Отправьте пожалуйста журнал мне на почту")
            AddGadgetItem(#journal,0,"tolik@at02.ru")
          Else
            tip("Чтобы выиграть нужно 50 текстов, 3 дизайна, 3 html, домен и хостинг")
          EndIf
      EndSelect
    EndIf
  EndIf
Until event = #PB_Event_CloseWindow
