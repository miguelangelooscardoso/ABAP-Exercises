*&---------------------------------------------------------------------*
*& Report ZBC490_SQL1_UP_TO_ROWS_MC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc490_sql1_up_to_rows_mc.

DATA: g_itab_kna1 TYPE TABLE OF kna1,
      g_wa_kna1   TYPE kna1,
      lv_runtime  TYPE i,
      g_limit     TYPE i VALUE '5'.

GET RUN TIME FIELD lv_runtime.
WRITE: / lv_runtime.

SELECT kunnr ort01 adrnr
 FROM kna1 INTO CORRESPONDING FIELDS OF g_wa_kna1
 WHERE land1 = 'PT'.
  IF sy-dbcnt GT g_limit.
    EXIT.
  ENDIF.
  APPEND g_wa_kna1 TO g_itab_kna1.
ENDSELECT.

GET RUN TIME FIELD lv_runtime.
WRITE: / lv_runtime.

CLEAR g_itab_kna1.

GET RUN TIME FIELD lv_runtime.
WRITE: / lv_runtime.

SELECT kunnr ort01 adrnr
  FROM kna1
  INTO TABLE g_itab_kna1
  UP TO g_limit ROWS
  WHERE land1 = 'PT'.

GET RUN TIME FIELD lv_runtime.
WRITE: / lv_runtime.
