01 SC-Log-Error.
  05 BLANK SCREEN.
  05 LINE 3 COL 3 VALUE "Unexpected Error Writing to Debug File"
    REVERSE-VIDEO
    BLINK.
  05 LINE 4 COL 3 VALUE "--------------------------------------".
  05 LINE 6 COL 3 VALUE "File Status: ".
  05 LINE 6 COL + 1 PIC XX FROM WS-Debug-File-Status.
  05 LINE 8 COL 3 VALUE "Press Enter to close this screen.".
