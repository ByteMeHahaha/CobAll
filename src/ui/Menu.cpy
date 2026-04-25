*> Menu Screen
01 SC-Main-Menu
  BACKGROUND-COLOUR 7
  FOREGROUND-COLOUR 0.
  05 BLANK SCREEN.
  05 LINE 3 COL 3 VALUE "CobAll Prototype".
  05 LINE 4 COL 3 VALUE "------------------".
  05 LINE 5 COL 3 VALUE "The Multi-purpose COBOL App.".
  05 LINE 6 COL 3 VALUE "----------------------------".
  05 LINE 8 COL 7 VALUE '1. "Sort ''n'' Report"'.
  05 LINE 9 COL 7 VALUE '2. Sort and Merge Files'.
  05 LINE 10 COL 7 VALUE "3. Settings".
  05 LINE 11 COL 7 VALUE "4. Exit".

  05 LINE 13 COL 3 VALUE "Your choice: ".
  05 LINE 13 COL + 1 PIC 9 USING WS-Main-Menu-Choice
    REVERSE-VIDEO
    REQUIRED.
