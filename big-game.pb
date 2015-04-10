;>8 подход
;запись в логе о домене
;сделал вывод главного и window_win окна посередине. Сделал им одинаковый размер.

;>Планы
;нарисовать новый интерфейс
;переделать интерфейс в колонки и чтобы окно само подстраивалось под количество кнопок
;смена целей
;отправлять весь лог
;прикрутить отправку почты

;>Баги
;сделал вывод в лог дни и деньги. сразу вылез баг, что выводится с запозданием на одну операцию
;не пропадают пояснения к кнопкам после смерти

;>Просчёты в дизайне
;нужно пояснить игроку что умирать не страшно
;не понятно что нужно догуглить
;пояснение к кнопке выигрыш
;журнал наверх

;>Вопрос
;выводить в лог больше инфы: деньги, жизни, тексты и тп. все переменные. не дохуя ли?
;переделать процедуру денег, текстов, кода и тп в одну процедуру?

;>Оверкил
;сделать рандомные фразы на разные действия в лог
;написать парсер лога. если скормить ему лог - он сделает то, что написано в логе

Global Day, Money, Lives, Text, Code
Global money_indik, days_indik, lives_indik, texts_indic, cod_indik, btn_aks_fr, zhurnal, tip_poluch_znania, tip_ask, goal

Window_0 = OpenWindow(#PB_Any, 100, 100, 570, 660, "Симулятор", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)

money_indik = TextGadget(#PB_Any, 210, 30, 100, 20, "")
days_indik = TextGadget(#PB_Any, 10, 50, 200, 20, "")
lives_indik = TextGadget(#PB_Any, 10, 30, 200, 20, "")
tip_poluch_znania = TextGadget(#PB_Any, 10, 70, 200, 20, "Получить знания")
btn_aks_fr = ButtonGadget(#PB_Any, 10, 90, 130, 25, "Спросить друга")
tip_ask = TextGadget(#PB_Any, 10, 120, 130, 20, "-❤ +знания")
zhurnal = EditorGadget(#PB_Any, 10, 430, 550, 200)
goal = TextGadget(#PB_Any, 10, 10, 260, 20, "")
; постепенная смена задач!  
;Задача: Нажимать на кнопки
;Задача: Поправить здоровье
;Задача: Создать полноценный сайт

Procedure setgoal(goal_txt$)
  SetGadgetText(goal,"Задача: "+goal_txt$)
EndProcedure

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
  setgoal("Нажимать на кнопки")
EndProcedure

Procedure tip(txt$)
  AddGadgetItem(zhurnal,0,FormatDate("%yyyy.%mm.%dd %hh:%ii:%ss", Date())+ " День: " + Str(Day) +" "+ txt$ +" "+"Денег: " + Str(Money) + "р")
EndProcedure

Procedure DisBat(name_of_btn,param)
  If name_of_btn
    DisableGadget(name_of_btn,param)
  EndIf
EndProcedure

Procedure HidGad(name_of_btn,param)
  If name_of_btn
    HideGadget(name_of_btn,param)
  EndIf
EndProcedure

NewList ab() ;all btn

Procedure add_btn(List lname(), name_of_btn)
  AddElement(lname())
  lname() = name_of_btn
EndProcedure
Start_indic()

Repeat
  ;некрасиво - текст подрагивает, потому что процесс выполняется. как поставить текст и забыть?

  ; проверка, не готовы ли мы выиграть
  If Code = 10 And Text = 10 And Domain
    DisBat(btn_win,0)
  EndIf
  ;проверяем не мертвы ли мы
  If Result
    start_indic()
    ; восстановить все кнопки в начальное состояние
    ForEach ab()
      HidGad(ab(),1)
    Next
    how_many_question = 0
    how_many_tread = 0
    how_many_google = 0
    Text = 0
    Code = 0
    Result = 0
    DisableGadget(btn_aks_fr,0)
  EndIf
  ; отключаем кнопки, которые расходуют деньги, если денег нет
  If money <= 0
    DisBat(btn_buy_cod,1)
    DisBat(btn_buy_domain,1)
    DisBat(btn_buy_txt,1)
    DisBat(btn_drink,1)
  Else
    DisBat(btn_buy_cod,0)
    DisBat(btn_buy_domain,0)
    DisBat(btn_buy_txt,0)
    DisBat(btn_drink,0)
  EndIf 
  ;проверяем, можем ли мы продавать тексты
  If Text <=0
    DisBat(btn_sell_txt,1)
  Else 
    DisBat(btn_sell_txt,0)
  EndIf
  ; проверяем, может ли мы продавать код
  If Code <=0
    DisBat(btn_sell_cod,1)
  Else 
    DisBat(btn_sell_cod,0)
  EndIf
  ; проверка жизней и основной цикл
  Select Lives
    Case 0
      Result = MessageRequester("Вы погибли","У вас кончились жизни. Ничего страшного! Нажмите OK чтобы начать заново")
      tip("Вы погибли ибо у вас кончились жизни. Вы нажали OK дабы заново начать")
      endlives + 1
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
                add_btn(ab(),btn_drink)
                tip_drink = TextGadget(#PB_Any, 10, 290, 130, 20, "- деньги +❤❤❤")
              Case 2
                DL(-1)
                tip("Друг рассказал вам, что можно заработать деньжат написанием текстов")
                texts_indic = TextGadget(#PB_Any, 330, 30, 100, 20, "Текстов: 0")
                tip_umenia = TextGadget(#PB_Any, 10, 150, 200, 20, "Умения")
                btn_mk_txt = ButtonGadget(#PB_Any, 10, 170, 130, 25, "Написать текст")
                add_btn(ab(),btn_mk_txt)
                tip_mk_txt = TextGadget(#PB_Any, 10, 200, 130, 20, "-❤ +текст")
                tip_sell = TextGadget(#PB_Any, 10, 320, 200, 20, "Заработать деньги")
                btn_sell_txt = ButtonGadget(#PB_Any, 10, 340, 130, 25, "Продать текст")
                add_btn(ab(),btn_sell_txt)
                tip_sell_txt = TextGadget(#PB_Any, 10, 370, 130, 20, "-текст +деньги")
              Case 3
                DL(-1)
                tip("Друг поведал вам о существовании форума")
                btn_read_forum = ButtonGadget(#PB_Any, 150, 90, 130, 25, "Читать форум")
                add_btn(ab(),btn_read_forum)
                tip_read = TextGadget(#PB_Any, 150, 120, 130, 20, "-❤ +знания")
              Case 4
                DL(-1)
                DisableGadget(btn_aks_fr,1)
                tip("Вы заебали своего друга")
                tip("Вы больше не можете задавать другу вопросы")
            EndSelect
          Case btn_drink
            ;читы
            If GetGadgetItemText(zhurnal,0) = "666"
              btn_win = ButtonGadget(#PB_Any, 270,400, 170, 25, "Скрафтить и выиграть")
              setgoal("Скрафтить полноценный сайт") 
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
                add_btn(ab(),btn_mk_cod)
                tip_mk_cod = TextGadget(#PB_Any, 150, 200, 130, 20, "-❤ +html")
                btn_sell_cod = ButtonGadget(#PB_Any, 150, 340, 130, 25, "Продать html")  
                add_btn(ab(),btn_sell_cod)
                tip_sell_cod = TextGadget(#PB_Any, 150, 370, 130, 20, "-html +500р")
                cod_indik = TextGadget(#PB_Any, 330, 50, 100, 20, "html: 0")
              Case 2
                DL(-1)
                tip("На форуме вам предложили загуглить")
                btn_google = ButtonGadget(#PB_Any, 290, 90, 130, 25, "Загуглить")
                add_btn(ab(),btn_google)
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
                add_btn(ab(),btn_buy_txt)
                tip_buy_txt = TextGadget(#PB_Any, 150, 290, 130, 20, "-80р +текст")
              Case 2
                DL(-1)
                tip("Вы изучили: Купить html")
                btn_buy_cod = ButtonGadget(#PB_Any, 290, 260, 130, 25, "Купить html")  
                add_btn(ab(),btn_buy_cod)
                tip_buy_cod = TextGadget(#PB_Any, 290, 290, 130, 20, "-400р +html")
              Case 3
                DL(-1)
                tip("Вы изучили: Купить домен")
                btn_buy_domain = ButtonGadget(#PB_Any, 430, 260, 130, 25, "Купить домен") 
                add_btn(ab(),btn_buy_domain)
                tip_buy_domain = TextGadget(#PB_Any, 430, 290, 130, 20, "-600р +домен")
                domain_indik = TextGadget(#PB_Any, 210, 50, 110, 20, "Домен: отсутствует")
              Case 4
                DL(-1)
                tip("Вы изучили: Как вообще делается сайт")
                tip_craft = TextGadget(#PB_Any, 10, 400, 260, 20, "Код*10 + текст*10 + домен*1 = сайт")
                btn_win = ButtonGadget(#PB_Any, 270,400, 170, 25, "Скрафтить и выиграть")
                setgoal("Скрафтить полноценный сайт") 
                add_btn(ab(),btn_win)
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
            tip("Вы купилит текст -80р")
            Text(1)
            Money(-80)
          Case btn_buy_cod
            tip("Вы купили html -400р")
            Code(1)
            Money(-400)
          Case btn_buy_domain
            Domain = 1
            tip("Вы купили домен -600р")
            DisBat(btn_buy_domain,1)
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
            tip("Вы создали полноценный сайт! Победа!")
            Window_Win = OpenWindow(#PB_Any, 200, 200, 570, 660, "Победа", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
            TextGadget(#PB_Any,10,10,180,90,"Вы выиграли! Поздравляю. Скопируйте пожалуйста результат и отправьте на почту."+
                                            "Это необходимо для разработки следующей игры")
            win_log = EditorGadget(#PB_Any,10,100,180,90)
            AddGadgetItem(win_log,-1,"mailto:tolik@at02.ru")
            AddGadgetItem(win_log,-1,"subj:webmaster-sim-1")
            AddGadgetItem(win_log,-1,"EndLives "+Str(endlives)+" "+
                                     "Over Drink "+Str(overdrink)+" "+
                                     "Day: "+Str(Day)+" "+
                                     "Text: "+Str(Text)+" "+
                                     "Code: "+Str(Code))
            AddGadgetItem(win_log,-1,"Stop: "+GetGadgetItemText(zhurnal,0))
            AddGadgetItem(win_log,-1,"Start: "+GetGadgetItemText(zhurnal,CountGadgetItems(zhurnal)-2))
        EndSelect
      EndIf
    Case 10 To 20
      Result = MessageRequester("Вы погибли","Ничего страшного! Нажмите OK чтобы начать заново")
      overdrink + 1
      tip("Вы погибли. Перебор. Вы нажали OK чтобы начать заново")
  EndSelect
Until event = #PB_Event_CloseWindow
