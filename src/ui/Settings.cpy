01 SC-Settings
  BACKGROUND-COLOUR 7
  FOREGROUND-COLOUR 0.
  05 BLANK SCREEN.
  05 LINE 3 COL 3 VALUE "Settings [WIP]".
  05 LINE 4 COL 3 VALUE "--------------".
  *> TODO => Replace values below with input fields
  05 LINE 7 COL 3 VALUE "Debug Logging: On".
  05 LINE 8 COL 3 VALUE "Back? (Y/N) ".
  05 LINE 8 COL + 1 PIC A USING WS-Settings-GoBack.
