; 4 подход
; вынес тексты, деньги и код в отдельные процедуры. 
; MDL переделал в DL (дни и жизни). 
; Не просто в Lives потому что тогда забуду, что вместе с жизнями идут дни.
; прикрутил проверку жизней

; планы
; проверка денег
; смена задач
; вывод финального сообщения с показателями всех индикаторов
; переделать всё в Enumeration?


Global Day, Money, Lives, money_indik, days_indik, lives_indik, Text, Code, btn_aks_fr, log

Window_0 = OpenWindow(#PB_Any, 200, 200, 570, 660, "Симулятор", #PB_Window_SystemMenu)

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
  texts_indic$ = "Текстов: " + Text
  SetGadgetText(texts_indic,texts_indic$)
EndProcedure

Procedure Code(numcode)
  Code + numcode
  cod_indik$ = "Кода: " + Code
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
  money_indik = TextGadget(#PB_Any, 210, 30, 100, 20, "Денег: 300р")
  days_indik = TextGadget(#PB_Any, 10, 50, 200, 20, "День: 1")
  lives_indik = TextGadget(#PB_Any, 10, 30, 200, 20, "❤ 10/10")
  tip_poluch_znania = TextGadget(#PB_Any, 10, 70, 200, 20, "Получить знания")
  btn_aks_fr = ButtonGadget(#PB_Any, 10, 90, 130, 25, "Спросить друга")
  tip_ask = TextGadget(#PB_Any, 10, 120, 130, 20, "-❤ +знания")
  log = EditorGadget(#PB_Any, 10, 430, 550, 200)
  goal = TextGadget(#PB_Any, 10, 10, 260, 20, "Задача: Создать полноценный сайт")
;Задача: Поправить здоровье
;Задача: Нажимать на кнопки
;Задача: Создать полноценный сайт
EndProcedure
Start_indic()

Repeat
  Select Lives
    Case 0
      Result = MessageRequester("Вы погибли","У вас кончились жизни. Нажмите Ok чтобы начать заново")
      endlives + 1
      If Result
        start_indic()
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
                AddGadgetItem(log,-1,"Вы спросили у друга как жить дальше.")
                AddGadgetItem(log,-1,"Друг рассказал вам о существовании алкоголя")
                tip_buy = TextGadget(#PB_Any, 10, 240, 200, 20, "Потратить деньги")
                btn_drink = ButtonGadget(#PB_Any, 10, 260, 130, 25, "Бухать")
                tip_drink = TextGadget(#PB_Any, 10, 290, 130, 20, "- деньги +❤❤❤")
              Case 2
                DL(-1)
                AddGadgetItem(log,-1,"Друг рассказал вам, что можно заработать деньжат написанием текстов")
                texts_indic = TextGadget(#PB_Any, 330, 30, 100, 20, "Текстов: 0")
                tip_umenia = TextGadget(#PB_Any, 10, 150, 200, 20, "Умения")
                btn_mk_txt = ButtonGadget(#PB_Any, 10, 170, 130, 25, "Написать текст")
                tip_mk_txt = TextGadget(#PB_Any, 10, 200, 130, 20, "-❤ +текст")
                tip_sell = TextGadget(#PB_Any, 10, 320, 200, 20, "Заработать деньги")
                btn_sell_txt = ButtonGadget(#PB_Any, 10, 340, 130, 25, "Продать текст")
                tip_sell_txt = TextGadget(#PB_Any, 10, 370, 130, 20, "-текст +деньги")
              Case 3
                DL(-1)
                AddGadgetItem(log,-1,"Друг поведал вам о существовании форума")
                btn_read_forum = ButtonGadget(#PB_Any, 150, 90, 130, 25, "Читать форум")
                tip_read = TextGadget(#PB_Any, 150, 120, 130, 20, "-❤ +знания")
              Case 4
                DL(-1)
                DisableGadget(btn_aks_fr,1)
                AddGadgetItem(log,-1,"Вы заебали своего друга")
                AddGadgetItem(log,-1,"Вы больше не можете задавать другу вопросы")
            EndSelect
          Case btn_drink
            Money(-100)
            DL(3)
          Case btn_read_forum
            how_many_tread+1
            Select how_many_tread
              Case 1
                DL(-1)
                AddGadgetItem(log,-1,"Вы спросили на форуме как жить дальше")
                AddGadgetItem(log,-1,"На форуме вам рассказали как писать простейший html код")
                btn_mk_cod = ButtonGadget(#PB_Any, 150, 170, 170, 25, "Сделать html страничку")
                tip_mk_cod = TextGadget(#PB_Any, 150, 200, 130, 20, "-❤ +код")
                btn_sell_cod = ButtonGadget(#PB_Any, 150, 340, 130, 25, "Продать код")  
                tip_sell_cod = TextGadget(#PB_Any, 150, 370, 130, 20, "-код +деньги")
                cod_indik = TextGadget(#PB_Any, 330, 50, 100, 20, "Кода: 0")
              Case 2
                DL(-1)
                AddGadgetItem(log,-1,"На форуме вам предложили загуглить")
                btn_google = ButtonGadget(#PB_Any, 290, 90, 130, 25, "Загуглить")
                tip_google = TextGadget(#PB_Any, 290, 120, 130, 20, "-❤ +знания")
              Case 3
                DL(-1)
                AddGadgetItem(log,-1,"Вас забанили на форуме")
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
                AddGadgetItem(log,-1,"Вы изучили: Купить текст")
                btn_buy_txt = ButtonGadget(#PB_Any, 150, 260, 130, 25, "Купить текст")
                tip_buy_txt = TextGadget(#PB_Any, 150, 290, 130, 20, "-деньги +текст")
              Case 2
                DL(-1)
                AddGadgetItem(log,-1,"Вы изучили: Купить код")
                btn_buy_cod = ButtonGadget(#PB_Any, 290, 260, 130, 25, "Купить код")  
                tip_buy_cod = TextGadget(#PB_Any, 290, 290, 130, 20, "-деньги +код")
              Case 3
                DL(-1)
                AddGadgetItem(log,-1,"Вы изучили: Купить домен")
                btn_buy_domain = ButtonGadget(#PB_Any, 430, 260, 130, 25, "Купить домен") 
                domain_indik = TextGadget(#PB_Any, 210, 50, 110, 20, "SetGadgetText")
              Case 4
                DL(-1)
                AddGadgetItem(log,-1,"Вы изучили: Как вообще делается сайт")
                tip_craft = TextGadget(#PB_Any, 10, 400, 260, 20, "Код*10 + текст*10 + домен*1 = сайт")
                btn_win = ButtonGadget(#PB_Any, 270, 400, 170, 25, "Скрафтить и выиграть")
              Case 5
                DL(-1)
                AddGadgetItem(log,-1,"Вас забанили в гугле")
                DisableGadget(btn_google,1)
            EndSelect
          Case btn_mk_cod
            Code(1)
            DL(-1)
          Case btn_buy_txt
            Text(1)
            Money(-80)
          Case btn_buy_cod
            Code(1)
            Money(-80)
          Case btn_buy_domain
            SetGadgetText(domain_indik,"Домен: есть")
            Money(-600)
          Case btn_sell_txt
            Text(-1)
            Money(100)
          Case btn_sell_cod
            Code(-1)
            Money(500)
          Case btn_win
            
        EndSelect
      EndIf
    Case 10 To 20
      Result = MessageRequester("Вы погибли","Перебор. Нажмите Ok чтобы начать заново")
      overdrink + 1
      If Result
        Start_indic()
      EndIf
  EndSelect
Until event = #PB_Event_CloseWindow
