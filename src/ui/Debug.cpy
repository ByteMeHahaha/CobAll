*> Debug screen
01 SC-Debug-Screen
  BACKGROUND-COLOUR 7 *> White
  FOREGROUND-COLOUR 0. *> Black
  *> Clear the terminal screen.
  05 BLANK SCREEN.
  *> Heading
  05 LINE 3 COL 3 VALUE "CobAll Debug Screen".
  05 LINE 4 COL 3 VALUE "-------------------".
  05 LINE 6 COL 3 VALUE "WIP Screen. Press Enter to Exit.".
