;5 подход. 
;Теперь можно дойти игру до конца. Правда не так как я задумывал.
;Сделал
;+вынес log в отдельную процедуру
;+прописал вывод комментариев в журнал при нажатии каждой кнопки
;+добавил time stamp в лог
;+точное пояснение под бухать, купить текст, код, домен
;+кнопка скрафтить и выиграть работает
;+купить домен не работает бесконечно
;+переименовал везде код в html

;Исправить
;если нажать что-то что требует денег в момент, когда их 0 - кнопка больше не включится
;проверка условий при нажатии кнопки выигрыша. до этого она не активна, но вид;на
;под продать текст не написано сколько денег
;под купить домен ничего не написано

;План
;в самом конце - сделать проверку на наличие денег
;смена задач
;вывод финального сообщения с показателями всех индикаторов
;переделать всё в Enumeration?
;при смерти восстановить все кнопки в начальное состояние?

Global Day, Money, Lives, money_indik, days_indik, lives_indik, texts_indic, cod_indik, Text, Code, btn_aks_fr, log, tip_poluch_znania, tip_ask, goal

Window_0 = OpenWindow(#PB_Any, 200, 200, 570, 660, "Симулятор", #PB_Window_SystemMenu)

money_indik = TextGadget(#PB_Any, 210, 30, 100, 20, "")
days_indik = TextGadget(#PB_Any, 10, 50, 200, 20, "")
lives_indik = TextGadget(#PB_Any, 10, 30, 200, 20, "")
tip_poluch_znania = TextGadget(#PB_Any, 10, 70, 200, 20, "Получить знания")
btn_aks_fr = ButtonGadget(#PB_Any, 10, 90, 130, 25, "Спросить друга")
tip_ask = TextGadget(#PB_Any, 10, 120, 130, 20, "-❤ +знания")
log = EditorGadget(#PB_Any, 10, 430, 550, 200)
goal = TextGadget(#PB_Any, 10, 10, 260, 20, "")
; постепенная смена задач?  
;Задача: Нажимать на кнопки
;Задача: Поправить здоровье
;Задача: Создать полноценный сайт

Procedure DL(numlives)
  Lives+numlives
  Day+1
  days_indik$ = "День: " + Str(Day)
  lives_indik$ = "❤ "+ Str(Lives) + "/10" 
  SetGadgetText(days_indik,days_indik$)
  SetGadgetText(lives_indik,lives_indik$)
EndProcedure

Procedure Text(numtext)
  Text + numtext
  texts_indic$ = "Текстов: " + Str(Text)
  SetGadgetText(texts_indic,texts_indic$)
EndProcedure

Procedure Code(numcode)
  Code + numcode
  cod_indik$ = "html: " + Code
  SetGadgetText(cod_indik,cod_indik$)
EndProcedure

Procedure Money(nummoney)
  Money+nummoney
  money_indik$ = "Денег: " + Str(Money) + "р"
  SetGadgetText(money_indik,money_indik$)
EndProcedure

Procedure Start_indic()
  Money = 300
  Day = 1
  Lives = 3
  SetGadgetText(money_indik,"Денег: 300р")
  SetGadgetText(days_indik, "День: 1")
  SetGadgetText(lives_indik, "❤ 3/10")
  SetGadgetText(goal, "Задача: Создать полноценный сайт")
EndProcedure

Procedure tip(txt$)
  AddGadgetItem(log,0,FormatDate("%yyyy.%mm.%dd %hh:%ii:%ss", Date())  + " " + txt$)
EndProcedure

Start_indic()

Repeat
  Select Lives
    Case 0
      Result = MessageRequester("Вы погибли","У вас кончились жизни. Нажмите Ok чтобы начать заново")
      event = #PB_Event_CloseWindow
      endlives + 1
      If Result
        start_indic()
        ; восстановить все кнопки в начальное состояние?
        how_many_question = 0
        how_many_tread = 0
        how_many_google = 0
        ;ForEach i in AllGadgetList
        ;HideGadget(i,1)
      EndIf
    Case 1 To 10
      event = WaitWindowEvent()
      If event = #PB_Event_Gadget 
        Select EventGadget() 
          Case btn_aks_fr
            how_many_question+1
            Select how_many_question
              Case 1
                DL(-1)
                tip("Вы спросили у друга как жить дальше.")
                tip("Друг рассказал вам о существовании алкоголя")
                tip_buy = TextGadget(#PB_Any, 10, 240, 200, 20, "Потратить деньги")
                btn_drink = ButtonGadget(#PB_Any, 10, 260, 130, 25, "Бухать")
                tip_drink = TextGadget(#PB_Any, 10, 290, 130, 20, "- деньги +❤❤❤")
              Case 2
                DL(-1)
                tip("Друг рассказал вам, что можно заработать деньжат написанием текстов")
                texts_indic = TextGadget(#PB_Any, 330, 30, 100, 20, "Текстов: 0")
                tip_umenia = TextGadget(#PB_Any, 10, 150, 200, 20, "Умения")
                btn_mk_txt = ButtonGadget(#PB_Any, 10, 170, 130, 25, "Написать текст")
                tip_mk_txt = TextGadget(#PB_Any, 10, 200, 130, 20, "-❤ +текст")
                tip_sell = TextGadget(#PB_Any, 10, 320, 200, 20, "Заработать деньги")
                btn_sell_txt = ButtonGadget(#PB_Any, 10, 340, 130, 25, "Продать текст")
                tip_sell_txt = TextGadget(#PB_Any, 10, 370, 130, 20, "-текст +деньги")
              Case 3
                DL(-1)
                tip("Друг поведал вам о существовании форума")
                btn_read_forum = ButtonGadget(#PB_Any, 150, 90, 130, 25, "Читать форум")
                tip_read = TextGadget(#PB_Any, 150, 120, 130, 20, "-❤ +знания")
              Case 4
                DL(-1)
                DisableGadget(btn_aks_fr,1)
                tip("Вы заебали своего друга")
                tip("Вы больше не можете задавать другу вопросы")
            EndSelect
          Case btn_drink
            If Money <= 0
              tip("Нет денег")
              DisableGadget(btn_drink,1)
            Else
              DisableGadget(btn_drink,0)
            EndIf
            tip("Вы восполнили здоровье на 3 и потратили 100р. Не пейте много")
            Money(-100)
            DL(3)
          Case btn_read_forum
            how_many_tread+1
            Select how_many_tread
              Case 1
                DL(-1)
                tip("Вы спросили на форуме как жить дальше")
                tip("На форуме вам рассказали как писать простейший html код")
                btn_mk_cod = ButtonGadget(#PB_Any, 150, 170, 170, 25, "Сделать html страничку")
                tip_mk_cod = TextGadget(#PB_Any, 150, 200, 130, 20, "-❤ +html")
                btn_sell_cod = ButtonGadget(#PB_Any, 150, 340, 130, 25, "Продать html")  
                tip_sell_cod = TextGadget(#PB_Any, 150, 370, 130, 20, "-html +100р")
                cod_indik = TextGadget(#PB_Any, 330, 50, 100, 20, "html: 0")
              Case 2
                DL(-1)
                tip("На форуме вам предложили загуглить")
                btn_google = ButtonGadget(#PB_Any, 290, 90, 130, 25, "Загуглить")
                tip_google = TextGadget(#PB_Any, 290, 120, 130, 20, "-❤ +знания")
              Case 3
                DL(-1)
                tip("Вас забанили на форуме")
                DisableGadget(btn_read_forum,1)
            EndSelect
          Case btn_mk_txt
            DL(-1)
            Text(1)
          Case btn_google
            how_many_google+1
            Select how_many_google
              Case 1
                DL(-1)
                tip("Вы изучили: Купить текст")
                btn_buy_txt = ButtonGadget(#PB_Any, 150, 260, 130, 25, "Купить текст")
                tip_buy_txt = TextGadget(#PB_Any, 150, 290, 130, 20, "-80р +текст")
              Case 2
                DL(-1)
                tip("Вы изучили: Купить html")
                btn_buy_cod = ButtonGadget(#PB_Any, 290, 260, 130, 25, "Купить html")  
                tip_buy_cod = TextGadget(#PB_Any, 290, 290, 130, 20, "-600р +html")
              Case 3
                DL(-1)
                tip("Вы изучили: Купить домен")
                btn_buy_domain = ButtonGadget(#PB_Any, 430, 260, 130, 25, "Купить домен") 
                tip_buy_domain = TextGadget(#PB_Any, 430, 290, 130, 20, "-600р +домен")
                domain_indik = TextGadget(#PB_Any, 210, 50, 110, 20, "Домен: отсутствует")
              Case 4
                DL(-1)
                tip("Вы изучили: Как вообще делается сайт")
                tip_craft = TextGadget(#PB_Any, 10, 400, 260, 20, "Код*10 + текст*10 + домен*1 = сайт")
                btn_win = ButtonGadget(#PB_Any, 270,400, 170, 25, "Скрафтить и выиграть")
                DisableGadget(btn_win,1)
              Case 5
                DL(-1)
                tip("Вас забанили в гугле")
                DisableGadget(btn_google,1)
            EndSelect
          Case btn_mk_cod
            tip("Вы накоди")
            Code(1)
            DL(-1)
          Case btn_buy_txt
            If Money <= 0
              tip("Нет денег")
              DisableGadget(btn_buy_txt,1)
            Else
              DisableGadget(btn_buy_txt,0)
            EndIf
            tip("Вы купилит текст")
            Text(1)
            Money(-80)
          Case btn_buy_cod
            If Money <= 0
              tip("Нет денег")
              DisableGadget(btn_buy_cod,1)
            Else
              DisableGadget(btn_buy_cod,0)
            EndIf
            tip("Вы купили html")
            Code(1)
            Money(-80)
          Case btn_buy_domain
            If Money <= 0
              tip("Нет денег")
              DisableGadget(btn_buy_domain,1)
            Else
              If domain = 1
              Else
                DisableGadget(btn_buy_domain,0)
              EndIf
            EndIf
            DisableGadget(btn_buy_domain,1)
            SetGadgetText(domain_indik,"Домен: есть")
            Money(-600)
          Case btn_sell_txt
            tip("Вы продали текст. +100р")
            Text(-1)
            Money(100)
          Case btn_sell_cod
            tip("Вы продали html +500р")
            Code(-1)
            Money(500)
          Case btn_win
            tip("Вы создали полноценный сайт!")
            Result = MessageRequester("Вы выиграли!","Поздравляем. Скопируйте пожалуйста результат и отправьте на почту. Это необходимо для разработки следующей игры")
            Debug endlives
            Debug overdrink
            Debug Day
            event = #PB_Event_CloseWindow
        EndSelect
      EndIf
    Case 10 To 20
      Result = MessageRequester("Вы погибли","Перебор. Нажмите Ok чтобы начать заново")
      overdrink + 1
      event = #PB_Event_CloseWindow
      If Result
        Start_indic()
      EndIf
  EndSelect
Until event = #PB_Event_CloseWindow
