IDENTIFICATION DIVISION.
  PROGRAM-ID. WriteDebugLog.

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
    *> Today's date in ISO Format, used in the log file
    01 WS-Date.
      05 WS-Year PIC 9999.
      05 FILLER PIC X VALUE "-".
      05 WS-Month PIC 99.
      05 FILLER PIC X VALUE "-".
      05 WS-Day PIC 99.

    *> Log file status
    01 WS-Debug-File-Status PIC XX.
      88 Opened-Successfully VALUE "00".
      88 File-Not-Found VALUE "35".

    *> Current time, used for the log file
    01 WS-Time.
      05 WS-Hour PIC 99.
      05 FILLER PIC X VALUE ":".
      05 WS-Minute PIC 99.

  LOCAL-STORAGE SECTION.
    01 LS-Log-Line PIC X(120).

  *> Subroutine Parameters
  LINKAGE SECTION.
    01 LK-Log-Level PIC A(4).
    01 LK-Message PIC X(80).

  SCREEN SECTION.
    COPY "LogError.cpy". *> Debug Log Writing Error Screen

PROCEDURE DIVISION USING LK-Log-Level LK-Message.
  *> Store the current date in the respective variables
  MOVE FUNCTION CURRENT-DATE(1:4) TO WS-Year.
  MOVE FUNCTION CURRENT-DATE(5:2) TO WS-Month.
  MOVE FUNCTION CURRENT-DATE(7:2) TO WS-Day.

  *> Store the current time in the respective variables
  MOVE FUNCTION CURRENT-DATE(9:2) TO WS-Hour.
  MOVE FUNCTION CURRENT-DATE(11:2) TO WS-Minute.

  *> Open the debug file to append to it
  OPEN EXTEND Debug-Log-File.

  IF File-Not-Found THEN
      OPEN OUTPUT Debug-Log-File
  ELSE
      IF NOT Opened-Successfully THEN
          DISPLAY SC-Log-Error
          ACCEPT OMITTED
          GOBACK
      END-IF
  END-IF.

  *> Build the debug log line
  STRING
    WS-Date DELIMITED BY SIZE
    ", " DELIMITED BY SIZE
    WS-Time DELIMITED BY SIZE
    " [" DELIMITED BY SIZE
    FUNCTION TRIM(LK-Log-Level) DELIMITED BY SIZE
    "] " DELIMITED BY SIZE
    FUNCTION TRIM(LK-Message) DELIMITED BY SIZE

    *> e.g.: 2026-04-20, 10:24 [DBG] Test
    INTO LS-Log-Line
  END-STRING.

  *> Write the debug line to the debug file and close it.
  MOVE LS-Log-Line TO DLF-Debug-Line.
  WRITE DLF-Debug-Line.
  CLOSE Debug-Log-File.

  GOBACK.

END PROGRAM WriteDebugLog.
