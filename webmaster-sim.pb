;===Сверх-Задачи===
;нарисовать интерфейс
;автоматическая отправка лога по http

===Идеи
;Написать функцию, которая бы выбирала рандомное слово из перечня rand("сделали, сваяли, сотворили, скрафтили") -> "сваяли"
;Выключатель рандома, переключатель сложности (нельзя умереть на лёгком) 10 жизней и настроения на харде
;Мультиязычность. Сделать полностью русскую и полностью английскую версию.
;при вирусной атаке избавиться от добавления дня, проверять какие открыты кнопки и обнулять именно их, натравить вирусы на хостинг и домен тоже
;ачивка: здоровье 99

===Рандом
;украли деньги
;повтор забухания с другом в любой момент
;не может работать, но только если есть хоть что-то продать
;Буст и кентворк не только от друга
;добавить небольшой рандом в кол-во добавляющегося настроения и сытости

;мелкие правки кода
;избавился от процедуры mood
;избавился от переменной "цена хостинга"

Global Text_cnt, Html_cnt, Design_cnt, Money, Day, Lives_cnt, Mood, version$ = "v0.2.5"
Global last_btn, now_btn, cant_work_days_end, boost_days_end
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
  #Boost
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
  ButtonGadget(#forum, 10, 60, 100, 25, "Читать форум")
  ButtonGadget(#stack, 10, 90, 100, 25, "Stackoverflow")
  ButtonGadget(#friend, 10, 120, 100, 25, "Помощь друга")
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
  ButtonGadget(#Noodles, 450, 30, 100, 25, "Доширолтон")
  ButtonGadget(#McDonut, 450, 60, 100, 25, "McDonut")
  ButtonGadget(#Home_Food, 450, 90, 100, 25, "Домашняя еда")
  ButtonGadget(#Walk, 560, 30, 100, 25, "Гулять")
  ButtonGadget(#Conference, 560, 90, 100, 25, "Конференция")
  ButtonGadget(#Club, 560, 60, 100, 25, "Клуб")
  EditorGadget(#journal, 10, 180, 650, 210)
  TextGadget(#knowledge, 10, 10, 100, 20, "Знания")
  TextGadget(#knowhow, 120, 10, 100, 20, "Умения")
  TextGadget(#buy, 230, 10, 100, 20, "Купить")
  TextGadget(#sell, 340, 10, 100, 20, "Заработать")
  TextGadget(#eat, 450, 10, 100, 20, "Кушать")
  TextGadget(#buzz, 560, 10, 100, 20, "Развлекаться")
  TextGadget(#comment, 340, 150, 310, 20, "Здоровье, настрой и деньги в журнале ↓") ; убрать в финальном релизе
  ButtonGadget(#WeGotWinner, 560, 150, 100, 25, "Win")
  ButtonGadget(#Boost, 560, 120, 100, 25, "Boost: N")
EndProcedure

OpenWindow_0()

Procedure tip(txt$)
  say$ = FormatDate("%yyyy.%mm.%dd %hh:%ii:%ss",Date()) + " День:"+Str(Day)+" $:"+Str(Money)+" ☯:"+
         Str(Mood)+" ♥:"+Str(Lives_cnt)+" "+txt$
  AddGadgetItem(#journal,0,say$)
  Debug say$ 
EndProcedure

Procedure zeroTDK()
  Text_cnt = 0
  Html_cnt = 0
  Design_cnt = 0
  SetGadgetText(#Make_Text, "Text: 0")
  SetGadgetText(#Make_Html, "Html: 0")
  SetGadgetText(#Make_Design, "Design: 0")
EndProcedure

Procedure start()
  For i = #forum To #comment
    DisableGadget(i,0)
  Next
  Day = 0
  cant_work_days_end = 1 ; чтобы после смерти включались обратно кнопки работы
  boost_days_end = 1
  Lives_cnt = 10
  Mood = 10
  Money = 0
  zeroTDK()
  SetGadgetText(#Make_Backup,"Backup: N")
  SetGadgetText(#Buy_Domain,"Domain: N")
  SetGadgetText(#Buy_Hosting,"Hosting: N")
  how_many_conference = 0
  how_many_google = 0
  how_many_forum = 0
  how_many_friend = 0
  how_many_stack = 0
  how_many_github = 0
  AddGadgetItem(#journal,0,"Тема: webmaster-sim "+version$)
  AddGadgetItem(#journal,0,"tolik@at02.ru")
  AddGadgetItem(#journal,0,"Пожалуйста, даже если не доиграете до конца, отправьте мне журнал игры на почту")
  tip("Просыпаемся за компом и решаем загуглить, как стать вебмастером")
EndProcedure

Procedure.s randomize(txt$) ;рандомизатор фраз журнала
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
  ProcedureReturn output$
EndProcedure

Procedure Boost()
  If boost_days_end >= Day
    ProcedureReturn 2
  Else
    ProcedureReturn 1
  EndIf
EndProcedure

Procedure add_text(numtext)
  plus = numtext*Boost()
  Text_cnt + plus
  SetGadgetText(#Make_Text,"Text: "+Str(Text_cnt))
  ProcedureReturn plus
EndProcedure

Procedure add_html(numhtml)
  plus = numhtml*Boost()
  Html_cnt + plus
  SetGadgetText(#Make_Html,"Html: "+Str(Html_cnt))
  ProcedureReturn plus
EndProcedure

Procedure add_design(numdes)
  plus = numdes*Boost()
  Design_cnt + plus
  SetGadgetText(#Make_Design,"Design: "+Str(Design_cnt))
  ProcedureReturn plus
EndProcedure

Procedure Money(num)
  If num < 0
    If Money < -num
      tip("Недостаточно денег нужно $"+Str(-num))
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

Procedure boring()
  Day+1
  Lives_cnt-1
  last_btn = now_btn
  now_btn = EventGadget()
  If last_btn = now_btn
    Mood-1
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

Buy_Text_Price = 100
Buy_Html_Price = 500
Buy_Design_Price = 800
Buy_Hosting_Price = 700

dead = 1 ; (стартовое состояние)
Repeat 
  event = WaitWindowEvent()
  
  If Day > 0 And Day%30 = 0 
    If GetGadgetText(#Make_Backup) = "Backup: N"
      Day + 1
      zeroTDK()
      AddGadgetItem(#journal,0,"Злобные вирусы уничтожили все результаты вашей работы: тексты, дизайн, код")
    Else
      Day + 1
      AddGadgetItem(#journal,0,"У вас есть бекап. Вирусы ничего вам не сделали")
    EndIf
    
  EndIf
  
  If Lives_cnt <= 2 ;помощь друга в первый раз, близко к смерти (может вырубить при этом все кнопки?)
    Show(#friend)
  EndIf
  
  If cant_work_days_end ;выключает кнопки работы, когда набухался с другом
    If Day >= cant_work_days_end
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
  
  If Mood <= 0 ;проверка жизней
    Result = MessageRequester("Костлявая","Сдохли от скуки. Это вот такой значек: ☯ Ничего страшного в смерти нет, каждый вебмастер знает о реинкарнации. Начните заново")
    dead = 1
    dead_bored + 1
    tip("Сдохли от скуки")
    AddGadgetItem(#journal,0,"=============")
  ElseIf Mood >= 101
    Result = MessageRequester("Костлявая","Умерли от передоза положительных эмоций. Каждый вебмастер желает знать где сидит фазан. Начните заново")
    tip("Умерли со смеху")
    AddGadgetItem(#journal,0,"=============")
    dead = 1
    dead_fun + 1
  Else
    If Lives_cnt <= 0
      Result = MessageRequester("Костлявая","Погибли от голода. Don't starve. Ничего страшного, каждый вебмастер знает о реинкарнации. Начните заново")
      dead = 1
      dead_starving + 1
      tip("Погибли от голода")
      AddGadgetItem(#journal,0,"=============")
    ElseIf Lives_cnt >= 101
      Result = MessageRequester("Костлявая","Куда столько жрать? Загнулись от разрыва желудка. Ничего страшного, каждый вебмастер знает о реинкарнации. Начните заново")
      dead = 1
      dead_overeat + 1
      tip("Загнулись от переедания")
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
                tip("погуглили 1 раз. Узнали что можно писать тексты на продажу")
              Case 2
                Show(#forum)
                tip("Погуглили 2 раза. Наткнулись_на форум вебмастеров")
              Case 3 To 4
                tip("Погуглили "+Str(how_many_google)+" раза. Кажется гугл кончился")
              Case 5 To 9
                tip(randomize("Погуглили "+Str(how_many_google)+" раз"))
              Case 10
                tip("Погуглили 10 раз. Заработали достижение Гуглер. Распечатайте и повесьте на стену")
              Case 13
                tip("Нагуглили полный мануал как делать всё от начала и до конца")
                For i = #forum To #comment
                  Show(i)
                Next
              Case 11 To 999
                tip("Погуглили "+Str(how_many_google)+" раз")
            EndSelect
            
          Case #forum
            boring()
            how_many_forum = how_many_forum + 1
            Select how_many_forum
              Case 1
                Show(#stack)
                tip("Почитали форум 1 раз. На форуме вам дали ссылку на stackowerflow")
              Case 2
                Show(#github)
                tip("Почитали форум 2 раза. Вам посоветовали покурить исходники Github")
              Case 3
                Show(#buy)
                Show(#Buy_Text)
                tip("Получаем ссылку на биржу контента. Теперь можете покупать тексты")
              Case 4
                Show(#Buy_Html)
                tip("Получаем ссылку на фриланс. Можете покупать html. Это дешевле чем делать самому")
              Case 5
                Show(#Buy_Design)
                tip("Почитали форум 5 раз. Теперь можете покупать дизайн. ")
              Case 6
                If Not how_many_friend
                  Show(#friend)
                  tip("Вы нашли друга на форуме. Он будет снабжать вас ценнейшей информацией")
                Else
                  tip(randomize("Почитали форум "+Str(how_many_forum)+"_раз"))  
                EndIf
              Case 7 To 8
                tip(randomize("Почитали форум "+Str(how_many_forum)+"_раз"))  
              Case 9
                tip("Снижение цен на покупку дизайна, текстов и кода!")
                Buy_Text_Price = 90
                Buy_Html_Price = 450
                Buy_Design_Price = 750
              Case 10
                DisableGadget(#forum,1)
                tip("забанили на форуме")
            EndSelect
            
          Case #stack
            boring()
            how_many_stack = how_many_stack + 1
            Select how_many_stack
              Case 1
                Show(#Make_Design)
                tip(randomize("Изучили как_делать дизайн"))
              Case 2
                Show(#Sell_Design)
                tip(randomize("Познали как_продать дизайн"))
              Case 3
                Show(#McDonut)
                tip("Получили совет сходить в_McDonuts вместо поедания лапши")
              Case 4
                tip("Поискали на stackowerflow 4 раза")
              Case 5 To 999
                tip("Stackowerflow "+Str(how_many_stack)+" раз")
            EndSelect
            
          Case #friend
            boring()
            how_many_friend = how_many_friend + 1
            Select how_many_friend
              Case 1
                Show(#Noodles)
                Lives_cnt + 10
                tip("Друг принёс запас лапши и посоветовал следить за сытостью")
              Case 2
                Show(#Make_Backup)
                tip("Друг рассказал о пользе резервного копирования")
              Case 3
                cant_work_days_end = Day+10
                Debug cant_work_days_end
                tip("Напились с другом. Не можете работать 10 дней")
              Case 4
                Show(#Club)
                tip("Друг поведал о существовании клуба. Подымает настроение")
              Case 5
                tip("Снова напились с другом. Код/текст/дизайн x2")
                boost_days_end = Day+10
              Case 6 To 999
                tip("Поговорили с другом "+Str(how_many_friend)+" раз")
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
                tip("Читая чей-то код на github узнали что можно сходить на конференцию")
              Case 4
                tip(randomize("Покурили github 4_раза"))
              Case 5
                If Not how_many_friend
                  Show(#friend)
                  tip("Вы подружились с автором github кода. Он будет снабжать вас ценнейшей информацией")
                Else
                  tip(randomize("Покурили форум "+Str(how_many_forum)+"_раз"))  
                EndIf
              Case 6 To 999
                tip("Это не те дроиды, которых ищете")
            EndSelect
            
          Case #Make_Text
            If boring()
              tip(randomize("Написали "+Str(add_text(2))+" текста за_раз")+" Всего текстов:"+Str(Text_cnt))
            Else
              tip(randomize("Написали "+Str(add_text(1))+" текст")+" Всего текстов:"+Str(Text_cnt))
            EndIf
          Case #Make_Html
            If boring()
              tip("Наверстали "+Str(add_html(2))+" html страницы за один присест."+" Всего html:"+Str(Html_cnt))
            Else
              tip(randomize("Сверстали "+Str(add_html(1))+" html")+" Всего html:"+Str(Html_cnt))
            EndIf
          Case #Make_Design
            If boring()
              tip(randomize("Наваяли аж "+Str(add_design(2))+" PSD")+" Всего дизайна:"+Str(Design_cnt))
            Else
              tip(randomize("Нарисовали "+Str(add_design(1))+" PSD")+" Всего дизайна:"+Str(Design_cnt))
            EndIf
          Case #Make_Backup
            boring()
            SetGadgetText(#Make_Backup,"Backup: Y")
            DisableGadget(#Make_Backup,1)
            tip(randomize("Сделали бекап"))
            
          Case #Buy_Text
            boring()
            If Money(-Buy_Text_Price)
              tip(randomize("Купили "+Str(add_text(1))+"текст за_$"+Str(Buy_Text_Price)))
            EndIf
          Case #Buy_Html
            If Money(-Buy_Html_Price)
              tip(randomize("Купили "+Str(add_html(1))+"html за_$"+Str(Buy_Html_Price)))
            EndIf
          Case #Buy_Design
            boring()
            If Money(-Buy_Design_Price)
              tip(randomize("Купили "+Str(add_design(1))+"дизайн за_$"+Str(Buy_Design_Price)))
            EndIf
          Case #Buy_Domain
            boring()
            If Money(-600)
              SetGadgetText(#Buy_Domain,"Domain: Y")
              DisableGadget(#Buy_Domain,1)
              tip("Купили домен за_$600")
            EndIf
          Case #Buy_Hosting
            boring()
            If Money(-700)
              SetGadgetText(#Buy_Hosting,"Hosting: Y")
              DisableGadget(#Buy_Hosting,1)
              tip("Купили хостинг за_$"+Str(700))
            EndIf

          Case #Sell_Text
            boring()
            If Text_cnt <= 0
              tip(randomize("Никак_не продать текст")+randomize("У_вас его нет"))
            ElseIf Text_cnt > 0
              Money(200*Boost())
              tip(randomize("Продали текст "+Str(-add_text(-1)))+" $+"+Str(200*Boost()))
            EndIf
          Case #Sell_Html
            boring()
            If Html_cnt <= 0
              tip(randomize("Не_можете продать html")+randomize("У_вас его нет"))
            ElseIf Html_cnt > 0
              Money(1000*Boost())
              tip(randomize("Продали html "+Str(-add_html(-1)))+" $+"+Str(1000*Boost()))
            EndIf
          Case #Sell_Design
            boring()
            If Design_cnt <= 0
              tip(randomize("Не_в_состоянии продать дизайн")+randomize("У_вас его нет"))
            ElseIf Design_cnt > 0
              Money(1200*Boost())
              tip(randomize("Продали дизайн "+Str(-add_design(-1)))+" $+"+Str(1200*Boost()))
            EndIf
            
          Case #Noodles
            boring()
            If Money(-100)
              Lives_cnt+20
              tip(randomize("Поели макарон")+" ♥+20 -$100")
            EndIf
          Case #McDonut
            boring()
            If Money(-500)
              Lives_cnt+40
              tip(randomize("Перекусили в_Макдаке")+" ♥+40 -$500")
            Else
              Lives_cnt+1
              tip(randomize("Недостаточно денег на_макдак")+" Надо_$500")
            EndIf
          Case #Home_Food
            boring()
            If Money(-1000)
              Lives_cnt = 100
              Mood+10
              tip(randomize("Насладились домашней едой")+" ♥full ☯+10 -$1000")
            Else
              Lives_cnt+1
              tip(randomize("Недостаточно денег на домашнюю еду")+" Надо_$1000")
            EndIf
            
          Case #Walk
            boring()
            Mood+10
            tip("Прогулялись ☯+10")
          Case #Conference
            boring()
            how_many_conference = how_many_conference + 1
            Mood+40
            Money(-1500)
            Select how_many_conference
              Case 1
                Show(#Buy_Hosting)
                tip("Посетили конференцию. Узнали как купить хостинг. -$1500 ☯+40")
              Case 2
                Show(#Buy_Domain)
                tip("Посетили конференцию. Узнали как купить домен. -$1500 ☯+40")
              Case 4
                Money(2500) ;1500 чтобы компенсировать затраты
                tip("Так часто посещаете конференции, что пригласили спикером. +$1000 ☯+40")
              Case 3 To 999
                tip("Посетили конференцию. ☯+40 -$1500")
            EndSelect
          Case #Club
            boring()
            If Money(-5000)
              how_many_club = how_many_club + 1
              Mood = 100
              Select how_many_club
                Case 1
                  tip("Потусили в клубе. ☯full -$5000")
                Case 2
                  Show(#Home_Food)
                  tip("Познакомились с девушкой в клубе. Доступна домашняя еда")
                Case 3 To 999
                  tip("Потусили в клубе. ☯full -$5000")
              EndSelect
            EndIf
          Case #WeGotWinner
            boring()
            If Text_cnt >= 50 And Html_cnt >= 3 And Design_cnt >= 3 And GetGadgetText(#Buy_Domain) = "Domain: Y" And GetGadgetText(#Buy_Hosting) = "Hosting: Y"
              Result = MessageRequester("Финиш","Сделали полноценный сайт и выиграли. Отправьте пожалуйста журнал мне на почту (указана в журнале)")
              AddGadgetItem(#journal,0,"Сделали полноценный сайт и выиграли. Отправьте пожалуйста журнал мне на почту")
              AddGadgetItem(#journal,0,"dead_bored="+Str(dead_bored)+" dead_fun="+Str(dead_fun)+" dead_overeat="+Str(dead_overeat)+" dead_starving="+Str(dead_starving))
              AddGadgetItem(#journal,0,"Тема: webmaster-sim "+version$)
              AddGadgetItem(#journal,0,"tolik@at02.ru")
            Else
              tip("Чтобы выиграть нужно 50 текстов, 3 дизайна, 3 html, домен и хостинг")
            EndIf
          Case #Boost
            If Not boost_trigger
              SetGadgetText(#Boost,"Boost: Y")
              boost_days_end = Day+10
              boost_trigger = 1
            Else
              SetGadgetText(#Boost,"Boost: N")
              boost_trigger = 0
            EndIf
        EndSelect
      EndIf
    EndIf
  EndIf
Until event = #PB_Event_CloseWindow
