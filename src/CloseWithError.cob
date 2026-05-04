IDENTIFICATION DIVISION.
PROGRAM-ID. CloseWithError.

DATA DIVISION.
  LOCAL-STORAGE SECTION.
    01 LS-Log-Level PIC A(4).
    01 LS-Log-Msg PIC X(80).

  LINKAGE SECTION.
    01 LK-Error-Code PIC 999.
    01 LK-Error-Msg PIC X(40).

  SCREEN SECTION.
    COPY "ErrorCloseScr.cpy". *> Error Screen
    COPY "MenuChoiceErr.cpy".

PROCEDURE DIVISION USING LK-Error-Code LK-Error-Msg.
  MOVE "ERR" TO LS-Log-Level.

  STRING
    FUNCTION TRIM(LK-Error-Msg) DELIMITED BY SIZE
    " (Closing with Err#" DELIMITED BY SIZE
    LK-Error-Code DELIMITED BY SIZE
    ")" DELIMITED BY SIZE

    INTO LS-Log-Msg
  END-STRING.

  CALL "WriteDebugLog" USING LS-Log-Level LS-Log-Msg.

  EVALUATE LK-Error-Code
    WHEN 595
      DISPLAY SC-Menu-Error
      ACCEPT OMITTED
    WHEN OTHER
      DISPLAY SC-Err-Close
      ACCEPT OMITTED
  END-EVALUATE.

  STOP RUN WITH ERROR LK-Error-Code.

END PROGRAM CloseWithError.
