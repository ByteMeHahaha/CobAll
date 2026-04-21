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
    01 WS-Date.
      05 WS-Year PIC 9999.
      05 FILLER VALUE "-".
      05 WS-Month PIC 99.
      05 FILLER VALUE "-".
      05 WS-Day PIC 99.
    01 WS-Time.
      05 WS-Hour PIC 99.
      05 FILLER VALUE ":".
      05 WS-Minute PIC 99.

  *> Menus and
  SCREEN SECTION.
    *> Debug menu
    COPY "Debug.cpy".

PROCEDURE DIVISION.
  MainCode.
    MOVE "Heyo" TO WS-Debug-Message.
    PERFORM WriteDebugMessage.

    STOP RUN.

  *> Writes debug info to the log file
  WriteDebugMessage.
    PERFORM InitialiseDate.

    *> Attempt to open the debug file to append to it
    OPEN EXTEND Debug-Log-File.

    *> If it can't open successfully
    IF WS-Debug-File-Status NOT EQUAL "00" THEN
      *> Overwrite the file (or create it)
      OPEN OUTPUT Debug-Log-File
    END-IF.

    *> Initialise the debug log line
    MOVE SPACES TO WS-Debug-Line.

    *> Build the debug log line
    STRING
      WS-Date DELIMITED BY SIZE
      " at " DELIMITED BY SIZE
      WS-Time DELIMITED BY SIZE
      " - " DELIMITED BY SIZE
      FUNCTION TRIM(WS-Debug-Message) DELIMITED BY SIZE

      *> e.g.: 2026-04-20 at 10:24 - Heyo
      INTO WS-Debug-Line
    END-STRING.

    *> Write the debug line to the debug file.
    MOVE WS-Debug-Line TO DLF-Debug-Line.
    WRITE DLF-Debug-Line.

    CLOSE Debug-Log-File.

  *> Initialises the date for the log file.
  InitialiseDate.
    MOVE FUNCTION CURRENT-DATE(1:4) TO WS-Year.
    MOVE FUNCTION CURRENT-DATE(5:2) TO WS-Month.
    MOVE FUNCTION CURRENT-DATE(7:2) TO WS-Day.

    MOVE FUNCTION CURRENT-DATE(9:2) TO WS-Hour.
    MOVE FUNCTION CURRENT-DATE(11:2) TO WS-Minute.

END PROGRAM CobAll.
