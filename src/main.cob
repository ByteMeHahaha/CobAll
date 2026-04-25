IDENTIFICATION DIVISION.
  PROGRAM-ID. CobAll.

DATA DIVISION.
  WORKING-STORAGE SECTION.
    *> Log levels for debug file
    01 WS-Log-Levels.
      05 WS-Log-Debug PIC X(3) VALUE "DBG".
      05 WS-Log-Info PIC X(3) VALUE "INF".
      05 WS-Log-Warn PIC X(4) VALUE "WARN".
      05 WS-Log-Error PIC X(3) VALUE "ERR".

    *> User-provided values for use
    *> throughout the program
    01 WS-User-Input.
      *> Choice of which screen to go to on the main menu
      05 WS-Main-Menu-Choice PIC 9 VALUE 0.
        88 ValidMenuChoice VALUE 1 THRU 4.
      *> Option on settings screen to return to the menu screen
      05 WS-Settings-GoBack PIC A VALUE "N".

    01 WS-Log-Level PIC A(4).
    01 WS-Message PIC X(80).

  *> Menus and other screens
  SCREEN SECTION.
    COPY "Debug.cpy". *> Debug menu
    COPY "Menu.cpy". *> Main Menu
    COPY "Settings.cpy". *> Settings Menu (WIP)

PROCEDURE DIVISION.
  MainCode.
    MOVE "INF" TO WS-Log-Level.
    MOVE "Test" TO WS-Message.
    CALL "WriteDebugLog" USING WS-Log-Level WS-Message.

    STOP RUN.

END PROGRAM CobAll.
