**&---------------------------------------------------------------------*
**& Report ZBC490_SQL1_INSERT_MC
**&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc490_sql1_insert_mc.
*
*DATA: g_itab_vbak TYPE TABLE OF vbak,
*      g_wa_vbak TYPE vbak,
*      g_count TYPE i VALUE 5.
*
*DO g_count TIMES.
*
*INSERT INTO g_itab_vbak VALUES g_wa_vbak.
**  INSERT INTO vbak VALUES g_wa_vbak.
*ENDDO.
*
*GET RUN TIME FIELD lv_runtime.
*WRITE: /lv_runtime.
*
*DO g_count TIMES.
*
*  APPEND g_wa_vbak TO g_itab_vbak.
*ENDDO.
*
**INSERT vbak
**FROM TABLE g_itab_vbak.
*
*GET RUN TIME FIELD lv_runtime.
*WRITE: /lv_runtime.
