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
      01 DLF-Debug-Line PIC X(120).

  WORKING-STORAGE SECTION.
    *> Log file status
    01 WS-Debug-File-Status PIC XX.
      88 Opened-Successfully VALUE "00".
      88 File-Not-Found VALUE "35".

    *> Log levels for debug file
    01 WS-Log-Levels.
      05 WS-Log-Debug PIC X(3) VALUE "DBG".
      05 WS-Log-Info PIC X(3) VALUE "INF".
      05 WS-Log-Warn PIC X(4) VALUE "WARN".
      05 WS-Log-Error PIC X(3) VALUE "ERR".

    *> Temp storage for writing to the debug file
    01 WS-Debug-File-Writing.
      05 WS-Debug-Line PIC X(120).
      05 WS-Debug-Message PIC X(80).
      05 WS-Debug-Level PIC A(4).

    *> Today's date in ISO Format, used in the log file
    01 WS-Date.
      05 WS-Year PIC 9999.
      05 FILLER PIC X VALUE "-".
      05 WS-Month PIC 99.
      05 FILLER PIC X VALUE "-".
      05 WS-Day PIC 99.

    *> Current time, used for the log file
    01 WS-Time.
      05 WS-Hour PIC 99.
      05 FILLER PIC X VALUE ":".
      05 WS-Minute PIC 99.

    *> User-provided values for use
    *> throughout the program
    01 WS-User-Input.
      05 WS-Main-Menu-Choice PIC 9 VALUE 0.

  *> Menus and other screens
  SCREEN SECTION.
    COPY "Debug.cpy". *> Debug menu
    COPY "Menu.cpy". *> Main Menu

PROCEDURE DIVISION.
  MainCode.
    *> Log the program start to the debug file
    MOVE "INF" TO WS-Debug-Level.
    MOVE "Program Started" TO WS-Debug-Message.
    PERFORM WriteDebugMessage.

    *> Show the main menu screen
    DISPLAY SC-Main-Menu.

    *> Write a debug log for the menu being shown
    MOVE "DBG" TO WS-Debug-Level.
    MOVE "Main Menu Screen Shown" TO WS-Debug-Message.
    PERFORM WriteDebugMessage.

    *> Accept input for the main menu screen
    ACCEPT SC-Main-Menu.

    *> Determine what to do depending on the menu choice
    EVALUATE WS-Main-Menu-Choice
      *> TODO -> Change Temp Logic
      WHEN 1 THRU 3
        DISPLAY SC-Debug-Screen

        *> Write to the debug log
        MOVE "DBG" TO WS-Debug-Level
        MOVE "Debug screen shown" TO WS-Debug-Message
        PERFORM WriteDebugMessage

        ACCEPT OMITTED

        PERFORM CloseProgram
      *> User chose to exit
      WHEN 4
        MOVE "INF" TO WS-Debug-Level
        MOVE "Exiting with status 0 (menu option 4)" TO WS-Debug-Message
        PERFORM WriteDebugMessage
        STOP RUN WITH NORMAL STATUS 0

      WHEN OTHER
        MOVE "ERR" TO WS-Debug-Level
        STRING
          "Invalid menu option: " DELIMITED BY SIZE
          WS-Main-Menu-Choice DELIMITED BY SIZE
          ". Exiting with code 404" DELIMITED BY SIZE

          INTO WS-Debug-Message
        END-STRING

        PERFORM WriteDebugMessage
        STOP RUN WITH ERROR 404

    END-EVALUATE.

  *> Writes debug info to the log file
  WriteDebugMessage.
    *> Initialise the date variables for the new log file entry
    PERFORM InitialiseDate.

    *> Open the debug file to append to it
    OPEN EXTEND Debug-Log-File.

    *> If it can't open successfully
    IF NOT Opened-Successfully THEN
      *> Store a message for the new log file
      MOVE "WARN" TO WS-Debug-Level
      MOVE "Debug File Recreated" TO WS-Debug-Message
      *> Overwrite the file (or create it)
      OPEN OUTPUT Debug-Log-File
    END-IF.

    *> Initialise the temporary debug log variable
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

      *> e.g.: 2026-04-20, 10:24 [DBG] Test
      INTO WS-Debug-Line
    END-STRING.

    *> Write the debug line to the debug file and close it.
    MOVE WS-Debug-Line TO DLF-Debug-Line.
    WRITE DLF-Debug-Line.
    CLOSE Debug-Log-File.

    *> Initialise the debug variables
    PERFORM InitialiseDebugInfo.

  *> Initialises the date variables for the log file.
  InitialiseDate.
    *> Store the current date in the respective variables
    MOVE FUNCTION CURRENT-DATE(1:4) TO WS-Year.
    MOVE FUNCTION CURRENT-DATE(5:2) TO WS-Month.
    MOVE FUNCTION CURRENT-DATE(7:2) TO WS-Day.

    *> Store the current time in the respective variables
    MOVE FUNCTION CURRENT-DATE(9:2) TO WS-Hour.
    MOVE FUNCTION CURRENT-DATE(11:2) TO WS-Minute.

  *> Initialise the debug log's temporary variables
  InitialiseDebugInfo.
    MOVE SPACES TO WS-Debug-Level.
    MOVE SPACES TO WS-Debug-Message.
    MOVE SPACES TO WS-Debug-Line.

  CloseProgram.
    MOVE "INF" TO WS-Debug-Level.
    MOVE "Exiting with status 0" TO WS-Debug-Message.
    PERFORM WriteDebugMessage.
    STOP RUN WITH NORMAL STATUS 0.

END PROGRAM CobAll.
