;===Сделал===
;Убрал отключение кнопок работы в отдельную процедуру. Придумал как обойтись без двойного повторения цикла for.
;Пофиксил баг, который вчера нашла Маша. Оказалось, что забыл запустить процедуру start когда игрок умирает от передоза положительного настроения
;Вынес start в проверку dead. -5 строк кода
;Можно умереть от скуки тыкая в кнопку win
;Теперь если тыкать на кнопку создания дизайна/текста/кода больше одного раза - растёт производительность
;Обнулил деньги в start
;Рост производительности при тыкании на одну и ту же кнопку "Делать"
;Вывел в конце переедание, недоедание, смерть от скуки и веселья. Усложнил финальные фразы

;===Текущие задачи===
;при вирусной атаке избавиться от добавления дня, проверять какие открыты кнопки и обнулять именно их, натравить вирусы на хостинг и домен тоже
;нарисовать и внедрить иконку в приложение (процедурное сердечко или знак дзен?)
;добавить небольшой рандом в кол-во добавляющегося настроения и сытости
;ачивка: здоровье 99
;событие завязанное на бекап
;рост производительности после забухания с другом
;научиться делать фразы состоящие из рандома и из не рандома

;===Сверх-Задачи===
;нарисовать интерфейс
;автоматическая отправка лога по http

Global version$, Text_cnt, Html_cnt, Design_cnt, Money, Day, Lives_cnt, Mood_cnt
Global last_btn, now_btn, days_end
Global how_many_conference, how_many_forum, how_many_friend, how_many_github, how_many_google, how_many_stack ;нужно для работы start()
version$ = "v0.2.3"

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
  #comment ;удалить?
  #journal
  #WeGotWinner
EndEnumeration

Procedure OpenWindow_0(width = 670, height = 400)
  OpenWindow(#Wnd, #PB_Ignore, #PB_Ignore, width, height, "Симулятор вебмастера "+version$, #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
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
  TextGadget(#comment, 340, 150, 310, 20, "Здоровье, настрой и деньги в журнале ↓") ; убрать в финальном релизе
  ButtonGadget(#WeGotWinner, 560, 150, 100, 25, "Win")
EndProcedure

OpenWindow_0()

Procedure tip(txt$)
  say$ = FormatDate("%yyyy.%mm.%dd %hh:%ii:%ss",Date()) + " День:"+Str(Day)+" $:"+Str(Money)+" ☯:"+
         Str(Mood_cnt)+" ♥:"+Str(Lives_cnt)+" "+txt$
  AddGadgetItem(#journal,0,say$)
  Debug say$ 
EndProcedure

Procedure.s rtip(txt$) ;рандомизатор фраз журнала
  txt$ = LCase(txt$)
  NewList words.s()
  For i = 1 To CountString(txt$," ")+1
    AddElement(words())
    words() = StringField(txt$,i," ")
  Next
  RandomizeList(words())
  ForEach words() 
    output$ + words() + " "
  Next
  output$ = UCase(Mid(output$,0,1))+Mid(output$,2) ; делаем первую букву большой
  tip(output$)
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
      tip("Недостаточно денег нужно "+Str(-num))
      ProcedureReturn #False 
    Else
      Money + num
      ProcedureReturn #True
    EndIf
  Else
    Money + num
    ProcedureReturn #True
  EndIf  
EndProcedure

Procedure Mood(num)
  Mood_cnt + num
EndProcedure

Procedure boring()
  Day+1
  Lives_cnt-1
  last_btn = now_btn
  now_btn = EventGadget()
  If last_btn = now_btn
    Mood(-1)
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
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

Procedure cant_work(trigger)
  For i = #Make_Text To #Make_Backup
    DisableGadget(i,trigger)
  Next
EndProcedure

Sell_Text_Price = 200

Buy_Text_Price = 100
Buy_Html_Price = 500
Buy_Design_Price = 800
Buy_Hosting_Price = 700
Buy_Domain_Price = 600

Procedure start()
  Day = 0
  days_end = 1 ; чтобы после смерти включались обратно кнопки работы
  Lives_cnt = 10
  Mood_cnt = 10
  Money = 0
  SetGadgetText(#Make_Backup,"Backup: N")
  SetGadgetText(#Buy_Domain,"Domain: N")
  SetGadgetText(#Buy_Hosting,"Hosting: N")
  add_text(-Text_cnt)
  add_html(-Html_cnt)
  add_design(-Design_cnt)
  how_many_conference = 0
  how_many_google = 0
  how_many_forum = 0
  how_many_friend = 0
  how_many_stack = 0
  how_many_github = 0
  AddGadgetItem(#journal,0,"Тема: webmaster-sim v0.2.3")
  AddGadgetItem(#journal,0,"tolik@at02.ru")
  AddGadgetItem(#journal,0,"Пожалуйста, даже если не доиграете до конца, отправьте мне журнал игры на почту")
  tip("Вы проснулись за компом и решили загуглить, как стать вебмастером")
EndProcedure

dead = 1 ; (стартовое состояние)
Repeat 
  event = WaitWindowEvent()
  
  If Day > 0 And Day%20 = 0 And GetGadgetText(#Make_Backup) = "Backup: N"
    Day + 1
    add_text(-Text_cnt)
    add_html(-Html_cnt)
    add_design(-Design_cnt)
    AddGadgetItem(#journal,0,"Злобные вирусы уничтожили все результаты вашей работы: тексты, дизайн, код")
    ;Delay(100) ; это ппц опасная штука. не даёт нажимать другие кнопки тоже!
  EndIf
  
  If Lives_cnt <= 2 ;помощь друга в первый раз, близко к смерти (может вырубить при этом все кнопки?)
    Show(#friend)
  EndIf
  
  If days_end ;выключает кнопки работы, когда набухался с другом
    If Day >= days_end
      cant_work(0)
    Else
      cant_work(1)
    EndIf
  EndIf
  
  If dead ;если умер - спрятать все кнопки
    For i = #forum To #Club
      Hide(i)
    Next
    dead = 0
    start()
  EndIf
  
  If Mood_cnt <= 0 ;проверка жизней
    Result = MessageRequester("Костлявая","Вы погибли от скуки. Это вот такой значек: ☯ Ничего страшного в смерти нет, каждый вебмастер знает о реинкарнации. Начните заново")
    dead = 1
    dead_bored + 1
    tip("Вы погибли от скуки")
    AddGadgetItem(#journal,0,"=============")
  ElseIf Mood_cnt >= 101
    Result = MessageRequester("Костлявая","Вы умерли от передоза положительных эмоций. Каждый вебмастер знает о реинкарнации. Начните заново")
    tip("Вы умерли со смеху")
    AddGadgetItem(#journal,0,"=============")
    dead = 1
    dead_fun + 1
  Else
    If Lives_cnt <= 0
      Result = MessageRequester("Костлявая","Вы погибли от голода. Don't starve. Ничего страшного, каждый вебмастер знает о реинкарнации. Начните заново")
      dead = 1
      dead_starving + 1
      tip("Вы погибли от голода")
      AddGadgetItem(#journal,0,"=============")
    ElseIf Lives_cnt >= 101
      Result = MessageRequester("Костлявая","Куда столько жрать? Вы погибли от разрыва желудка. Ничего страшного, каждый вебмастер знает о реинкарнации. Начните заново")
      dead = 1
      dead_overeat + 1
      tip("Вы погибли от переедания")
      AddGadgetItem(#journal,0,"=============")
    Else ;если жизни есть запускаем основной цикл
      If event = #PB_Event_Gadget
        Select EventGadget()
          Case #google
            boring()
            how_many_google + 1
            Select how_many_google
              Case 1
                Show(#sell)
                Show(#Make_Text)
                Show(#knowhow)
                Show(#Sell_Text)
                tip("Вы погуглили 1 раз. Узнали что можно писать тексты на продажу")
              Case 2
                Show(#forum)
                tip("Вы погуглили 2 раза. Наткнулись_на форум вебмастеров")
              Case 3 To 4
                tip("Вы погуглили "+Str(how_many_google)+" раза. Гугл кончился")
              Case 5 To 9
                tip("Вы погуглили "+Str(how_many_google)+" раз. Гугл кончился")
              Case 10
                tip("Вы погуглили 10 раз. Заработали достижение Гуглер. Распечатайте и повесьте на стену")
              Case 11 To 999
                tip("Вы погуглили "+Str(how_many_google)+" раз. Дальше ничего. Правда")
            EndSelect
            
          Case #forum
            boring()
            how_many_forum = how_many_forum + 1
            Select how_many_forum
              Case 1
                Show(#stack)
                tip("Вы почитали форум 1 раз. На форуме вам дали ссылку на stackowerflow")
              Case 2
                Show(#github)
                tip("Вы почитали форум 2 раза. Вам посоветовали покурить исходники Github")
              Case 3
                Show(#buy)
                Show(#Buy_Text)
                tip("Вам дали ссылку на биржу контента. Теперь вы можете покупать тексты")
              Case 4
                Show(#Buy_Html)
                tip("Вам дали ссылку на фриланс. Можете покупать html. Это дешевле чем делать самому")
              Case 5
                Show(#Buy_Design)
                tip("Вы почитали форум 5 раз. Теперь вы можете покупать дизайн. ")
              Case 6
                tip("Снижение цен на покупку дизайна, текстов и кода!")
                Buy_Text_Price = 90
                Buy_Html_Price = 450
                Buy_Design_Price = 750
              Case 7 To 9
                rtip("Вы почитали форум "+Str(how_many_forum)+"_раз")
              Case 10
                DisableGadget(#forum,1)
                tip("Вас забанили на форуме")
            EndSelect
            
          Case #stack
            boring()
            how_many_stack = how_many_stack + 1
            Select how_many_stack
              Case 1
                Show(#Make_Design)
                rtip("Вы изучили как_делать дизайн")
              Case 2
                Show(#Sell_Design)
                rtip("Вы познали как_продать дизайн")
              Case 3
                Show(#McDonut)
                tip("Вам посоветовали сходить в_McDonuts вместо вечного поедания дошираков")
              Case 4
                tip("Вы поискали на stackowerflow 4 раза")
              Case 5 To 999
                tip("stackowerflow "+Str(how_many_stack)+" раз")
            EndSelect
            
          Case #friend
            boring()
            how_many_friend = how_many_friend + 1
            Select how_many_friend
              Case 1
                Show(#Noodles)
                Lives_cnt + 10
                tip("Друг принёс вам запас дошираков. И посоветовал следить за сытостью")
              Case 2
                Show(#Make_Backup)
                tip("Друг рассказал вам о пользе резервного копирования")
              Case 3
                days_end = Day+10
                Debug days_end
                tip("Вы напились с другом. Не можете работать 10 дней")
              Case 4
                Show(#Club)
                tip("Друг поведал вам о существовании клуба. Подымает настроение")
              Case 5
                tip("Вы снова напились с другом. Код/текст/дизайн x2")
                days_boost = Day+10
              Case 6 To 999
                tip("Вы поговорили с другом "+Str(how_many_friend)+" раз")
            EndSelect
            
          Case #github
            boring()
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
              Case 4
                rtip("Вы покурили github 4_раза")
              Case 5 To 999
                rtip("Это не те дроиды, которых вы ищете")
            EndSelect
            
          Case #Make_Text
            If boring()
              add_text(2)
              tip("Вы написали 2 текста за раз. Всего текстов:"+Str(Text_cnt))
            Else
              add_text(1)
              tip("Вы написали 1 текст. Всего текстов:"+Str(Text_cnt))
            EndIf
          Case #Make_Html
            If boring()
              add_html(2)
              tip("Вы наверстали 2 html страницы за один присест. Всего html:"+Str(Html_cnt))
            Else
              add_html(1)
              tip("Вы наверстали 1 html. Всего html:"+Str(Html_cnt))
            EndIf
          Case #Make_Design
            If boring()
              add_design(2)
              tip("Вы нарисовали 2 PSD. Всего дизайна:"+Str(Design_cnt))
            Else
              add_design(1)
              tip("Вы нарисовали 1 PSD. Всего дизайна:"+Str(Design_cnt))
            EndIf
          Case #Make_Backup
            SetGadgetText(#Make_Backup,"Backup: Y")
            DisableGadget(#Make_Backup,1)
            rtip("Вы сделали бекап")
            
          Case #Buy_Text
            boring()
            If Money(-Buy_Text_Price)
              rtip("Вы купили текст за_$"+Str(Buy_Text_Price))
              add_text(1)
            EndIf
          Case #Buy_Html
            boring()
            If Money(-Buy_Html_Price)
              add_html(1)
              rtip("Вы купили html за_$"+Str(Buy_Html_Price))
            EndIf
          Case #Buy_Design
            boring()
            If Money(-Buy_Design_Price)
              add_design(1)
              tip("Вы купили дизайн за "+Str(Buy_Design_Price))  
            EndIf
          Case #Buy_Domain
            boring()
            If Money(-600)
              SetGadgetText(#Buy_Domain,"Domain: Y")
              DisableGadget(#Buy_Domain,1)
              tip("Вы купили домен за 600")
            EndIf
          Case #Buy_Hosting
            boring()
            If Money(-Buy_Hosting_Price)
              SetGadgetText(#Buy_Hosting,"Hosting: Y")
              DisableGadget(#Buy_Hosting,1)
              tip("Вы купили хостинг за "+Str(Buy_Hosting_Price))
            EndIf
            
          Case #Sell_Text
            boring()
            If Text_cnt <= 0
              tip("Вы не можете продать текст. У вас его нет")
            ElseIf Text_cnt > 0
              add_text(-1)
              Money(Sell_Text_Price)
              tip("Вы продали текст. +"+Str(Sell_Text_Price))
            EndIf
          Case #Sell_Html
            boring()
            If Html_cnt <= 0
              tip("Вы не можете продать html. У вас его нет")
            ElseIf Html_cnt > 0
              add_html(-1)
              Money(1000)
              tip("Вы продали html. $ +1000")
            EndIf
          Case #Sell_Design
            boring()
            If Design_cnt <= 0
              tip("Вы не можете продать дизайн. У вас его нет")
            ElseIf Design_cnt > 0
              add_design(-1)
              Money(1200)
              tip("Вы продали дизайн. $ +1200")
            EndIf
            
          Case #Noodles
            boring()
            If Money(-100)
              Lives_cnt+20
              tip("Вы поели макарон. ♥+20 -$100")
            EndIf
          Case #McDonut
            boring()
            If Money > 200
              Money(-200)
              Lives_cnt+40
              tip("Вы перекусили в_Макдаке. ♥+40 -$200")
            Else
              Lives_cnt+1
              rtip("Недостаточно денег на макдак Надо_$200")
            EndIf
          Case #Home_Food
            boring()
            If Money > 300
              Money(-300)
              Lives_cnt = 100
              Mood(10)
              tip("Вы насладились домашней едой ♥full -$300")
            Else
              Lives_cnt+1
              tip("Недостаточно денег на домашнюю еду Надо_$300")
            EndIf
            
          Case #Walk
            boring()
            Mood(10)
            tip("Вы прогулялись ☯+10")
          Case #Conference
            boring()
            how_many_conference = how_many_conference + 1
            Mood(40)
            Money(-1500)
            Select how_many_conference
              Case 1
                Show(#Buy_Hosting)
                tip("Вы посетили конференцию. Узнали как купить хостинг. -$1500 ☯+40")
              Case 2
                Show(#Buy_Domain)
                tip("Вы посетили конференцию. Узнали как купить домен. -$1500 ☯+40")
              Case 4
                Money(2500) ;1500 чтобы компенсировать затраты
                tip("Вы так часто посещаете конференции, что вас пригласили спикером. +$1000 ☯+40")
              Case 3 To 999
                tip("Вы посетили конференцию. ☯+40 -$1500")
            EndSelect
          Case #Club
            boring()
            If Money(-5000)
              how_many_club = how_many_club + 1
              Mood_cnt = 100
              Select how_many_club
                Case 1
                  tip("Вы потусили в клубе. ☯full")
                Case 2
                  Show(#Home_Food)
                  tip("Вы познакомились с девушкой в клубе. Доступна домашняя еда")
                Case 3 To 999
                  tip("Вы потусили в клубе. ☯full")
              EndSelect
            EndIf
            
          Case #WeGotWinner
            boring()
            If Text_cnt >= 50 And Html_cnt >= 3 And Design_cnt >= 3 And GetGadgetText(#Buy_Domain) = "Domain: Y" And GetGadgetText(#Buy_Hosting) = "Hosting: Y"
              Result = MessageRequester("Финиш","Вы сделали полноценный сайт и выиграли. Отправьте пожалуйста журнал мне на почту (указана в журнале)")
              AddGadgetItem(#journal,0,"Вы сделали полноценный сайт и выиграли. Отправьте пожалуйста журнал мне на почту")
              AddGadgetItem(#journal,0,"dead_bored="+Str(dead_bored)+" dead_fun="+Str(dead_fun)+" dead_overeat="+Str(dead_overeat)+" dead_starving="+Str(dead_starving))
              AddGadgetItem(#journal,0,"Тема: webmaster-sim "+version$)
              AddGadgetItem(#journal,0,"tolik@at02.ru")
            Else
              tip("Чтобы выиграть нужно 50 текстов, 3 дизайна, 3 html, домен и хостинг")
            EndIf
        EndSelect
      EndIf
    EndIf
  EndIf
  
Until event = #PB_Event_CloseWindow
