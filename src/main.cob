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
      05 WS-Menu-Choice PIC 9 VALUE 0.
        88 ValidMenuChoice VALUE 1 THRU 4.
      *> Option on settings screen to return to the menu screen
      05 WS-Settings-GoBack PIC A VALUE "N".
      05 WS-Settings-Choices.
        10 WS-Logging-Enabled PIC A VALUE "Y".

    01 WS-Log-Level PIC A(4).
    01 WS-Message PIC X(80).

    01 WS-Temp-Msg PIC X(80).

  *> Menus and other screens
  SCREEN SECTION.
    COPY "Debug.cpy". *> Debug menu
    COPY "Menu.cpy". *> Main Menu

PROCEDURE DIVISION.
  MainCode.
    DISPLAY SC-Menu.

    MOVE "INF" TO WS-Log-Level.
    MOVE "Program Started" TO WS-Message.
    CALL "WriteDebugLog" USING WS-Log-Level WS-Message.

    ACCEPT SC-Menu.

    MOVE "INF" TO WS-Log-Level.
    STRING
      "User picked menu item: " DELIMITED BY SIZE
      WS-Menu-Choice DELIMITED BY SIZE
      INTO WS-Temp-Msg
    END-STRING.
    MOVE WS-Temp-Msg TO WS-Message.
    CALL "WriteDebugLog" USING WS-Log-Level WS-Message.

    EVALUATE WS-Menu-Choice
      WHEN 1 THRU 3
        PERFORM ShowDebugScreen
        PERFORM CloseProgram
      WHEN 4
        PERFORM CloseProgram
      WHEN OTHER
        MOVE "ERR" TO WS-Log-Level
        STRING
          "Invalid Menu choice: " DELIMITED BY SIZE
          WS-Menu-Choice DELIMITED BY SIZE

          INTO WS-Message
        END-STRING
        CALL "WriteDebugLog" USING WS-Log-Level WS-Message
        STOP RUN WITH ERROR 404 *> TODO => Add documentation for error codes
    END-EVALUATE.

    *> Should not hit this
    STOP RUN WITH ERROR 1.

  CloseProgram.
    MOVE "INF" TO WS-Log-Level.
    MOVE "Program Closing with Status 0" TO WS-Message.
    CALL "WriteDebugLog" USING WS-Log-Level WS-Message.

  ShowDebugScreen.
    DISPLAY SC-Debug.

    MOVE "DBG" TO WS-Log-Level.
    MOVE "Debug Screen Shown" TO WS-Message.
    CALL "WriteDebugLog" USING WS-Log-Level WS-Message.

    ACCEPT OMITTED.

END PROGRAM CobAll.
