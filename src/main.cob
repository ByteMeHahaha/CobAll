IDENTIFICATION DIVISION.
  PROGRAM-ID. CobAll.

ENVIRONMENT DIVISION.
  INPUT-OUTPUT SECTION.
    FILE-CONTROL.
      *> Debug log file
      SELECT Debug-Log-File ASSIGN TO "Debug.log"
      ORGANISATION LINE SEQUENTIAL
      ACCESS MODE SEQUENTIAL
      FILE STATUS WS-Debug-File-Status.

DATA DIVISION.
  FILE SECTION.
    FD Debug-Log-File.
      *> One line in the debug file.
      01 DLF-Debug-Line PIC X(80).

  WORKING-STORAGE SECTION.
    01 WS-Debug-File-Status PIC XX.
    01 WS-Debug-File-Writing.
      05 WS-Debug-Line PIC X(80).
      05 WS-Debug-Message PIC X(40).
      05 WS-Debug-Level PIC A(4).
    01 WS-Date.
      05 WS-Year PIC 9999.
      05 FILLER PIC X VALUE "-".
      05 WS-Month PIC 99.
      05 FILLER PIC X VALUE "-".
      05 WS-Day PIC 99.
    01 WS-Time.
      05 WS-Hour PIC 99.
      05 FILLER PIC X VALUE ":".
      05 WS-Minute PIC 99.
    01 WS-User-Input.
      05 WS-Main-Menu-Choice PIC X VALUE "0".

  *> Menus and other screens
  SCREEN SECTION.
    COPY "Debug.cpy". *> Debug menu
    COPY "Menu.cpy". *> Main Menu

PROCEDURE DIVISION.
  MainCode.
    MOVE "INF" TO WS-Debug-Level.
    MOVE "Program Started" TO WS-Debug-Message.
    PERFORM WriteDebugMessage.

    DISPLAY SC-Main-Menu.

    MOVE "DBG" TO WS-Debug-Level.
    MOVE "Main Menu Screen Shown" TO WS-Debug-Message.
    PERFORM WriteDebugMessage.

    ACCEPT SC-Main-Menu.

    MOVE "INF" TO WS-Debug-Level.
    STRING
      "User picked menu item: " DELIMITED BY SIZE
      WS-Main-Menu-Choice DELIMITED BY SIZE

      INTO WS-Debug-Message
    END-STRING.
    PERFORM WriteDebugMessage.

    DISPLAY SC-Debug-Screen.

    MOVE "DBG" TO WS-Debug-Level.
    MOVE "Debug screen shown" TO WS-Debug-Message.
    PERFORM WriteDebugMessage.

    ACCEPT OMITTED.

    MOVE "INF" TO WS-Debug-Level.
    MOVE "Program Closing" TO WS-Debug-Message.
    PERFORM WriteDebugMessage.

    STOP RUN.

  *> Writes debug info to the log file
  WriteDebugMessage.
    PERFORM InitialiseDate.

    *> Attempt to open the debug file to append to it
    OPEN EXTEND Debug-Log-File.

    *> If it can't open successfully
    IF WS-Debug-File-Status NOT EQUAL "00" THEN
      *> Store a message for the new log file
      MOVE "WARN" TO WS-Debug-Level
      MOVE "Debug File Recreated" TO WS-Debug-Message
      *> Overwrite the file (or create it)
      OPEN OUTPUT Debug-Log-File
    END-IF.

    *> Initialise the debug log line
    MOVE SPACES TO WS-Debug-Line.

    *> Build the debug log line
    STRING
      WS-Date DELIMITED BY SIZE
      ", " DELIMITED BY SIZE
      WS-Time DELIMITED BY SIZE
      " [" DELIMITED BY SIZE
      FUNCTION TRIM(WS-Debug-Level) DELIMITED BY SIZE
      "] " DELIMITED BY SIZE
      FUNCTION TRIM(WS-Debug-Message) DELIMITED BY SIZE

      *> e.g.: 2026-04-20, 10:24 [DEBUG] Test
      INTO WS-Debug-Line
    END-STRING.

    *> Write the debug line to the debug file and close it.
    MOVE WS-Debug-Line TO DLF-Debug-Line.
    WRITE DLF-Debug-Line.
    CLOSE Debug-Log-File.

    *> Initialise the debug variables
    PERFORM InitialiseDebugInfo.

  *> Initialises the date for the log file.
  InitialiseDate.
    MOVE FUNCTION CURRENT-DATE(1:4) TO WS-Year.
    MOVE FUNCTION CURRENT-DATE(5:2) TO WS-Month.
    MOVE FUNCTION CURRENT-DATE(7:2) TO WS-Day.

    MOVE FUNCTION CURRENT-DATE(9:2) TO WS-Hour.
    MOVE FUNCTION CURRENT-DATE(11:2) TO WS-Minute.

  InitialiseDebugInfo.
    MOVE SPACES TO WS-Debug-Level.
    MOVE SPACES TO WS-Debug-Message.
    MOVE SPACES TO WS-Debug-Line.

END PROGRAM CobAll.
