*&---------------------------------------------------------------------*
*& Report ZBC490_SQL1_ARRAY_FETCH_MC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc490_sql1_array_fetch_mc.

DATA: g_itab_kna1 TYPE TABLE OF kna1,
      itab_kna1 TYPE TABLE OF kna1,
      g_wa_kna1 TYPE kna1,
      lv_runtime TYPE i.

GET RUN TIME FIELD lv_runtime.
WRITE:/ lv_runtime.

SELECT kunnr adrnr
  FROM kna1
  INTO CORRESPONDING FIELDS OF g_wa_kna1.
  APPEND g_wa_kna1 TO g_itab_kna1.
ENDSELECT.

GET RUN TIME FIELD lv_runtime.
WRITE:/ lv_runtime.

*CLEAR lv_runtime.

SELECT kunnr adrnr
  FROM kna1
  INTO CORRESPONDING FIELDS OF TABLE itab_kna1.

GET RUN TIME FIELD lv_runtime.
WRITE:/ lv_runtime.
