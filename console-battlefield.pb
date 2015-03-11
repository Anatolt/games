v$ = "v0.1"
If OpenConsole("Одноклеточный морской бой "+v$) 
  While Not Input() = "exit"
    Input()
  Wend
  CloseConsole()
EndIf
