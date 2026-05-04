01 SC-Menu-Error.
  05 BLANK SCREEN.
  05 LINE 3 COL 3 VALUE "Menu Choice Error!"
    FOREGROUND-COLOR 4 *> Red text
    BACKGROUND-COLOR 14 *> Yellow background
    BLINK.
  05 LINE 4 COL 3 VALUE "------------------"
    *> Red text
    FOREGROUND-COLOR 4
    *> Yellow Background
    BACKGROUND-COLOR 14.
  05 LINE 6 COL 3 VALUE "Err#: ".
  05 LINE 6 COL + 1 PIC 999 FROM LK-Error-Code.
  05 LINE 7 COL 3 VALUE "Message: ".
  05 LINE 7 COL + 1 PIC X(40) FROM LK-Error-Msg.
  05 LINE 10 COL 3 VALUE "Press Enter to Exit.".
