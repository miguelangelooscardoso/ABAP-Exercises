*&---------------------------------------------------------------------*
*& Report ZBC490_SQL1_FOR_ALL_ENTRIES_MC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc490_sql1_for_all_entries_mc.

TABLES: vbak.

DATA: g_itab_vbak TYPE TABLE OF vbak,
      g_itab_kna1 TYPE TABLE OF kna1,
      g_wa_vbak   TYPE vbak,
      g_wa_kna1   TYPE kna1,
      lv_runtime  TYPE i.

START-OF-SELECTION.

  SELECT-OPTIONS: so_vbeln  FOR vbak-vbeln.

  GET RUN TIME FIELD lv_runtime.
  WRITE: / lv_runtime.

* "O campo do banco de dados ERDAT ou o tipo de resultado da função agregada
*  o componente "VBELN" de "G_ITAB_VBAK" não é compatível."

  SELECT vbeln kunnr FROM vbak " vbeln erdat kunnr
    INTO CORRESPONDING FIELDS OF TABLE g_itab_vbak
    WHERE vbeln IN so_vbeln.

  LOOP AT g_itab_vbak INTO g_wa_vbak.
    SELECT kunnr adrnr FROM kna1
    APPENDING TABLE g_itab_kna1
    WHERE kunnr = g_wa_vbak-kunnr.
  ENDLOOP.

  GET RUN TIME FIELD lv_runtime.
  WRITE: / lv_runtime.

  CLEAR g_itab_kna1.

  SELECT kunnr adrnr FROM kna1
    INTO CORRESPONDING FIELDS OF TABLE g_itab_kna1
    FOR ALL ENTRIES IN g_itab_vbak
    WHERE kunnr = g_itab_vbak-kunnr.

  GET RUN TIME FIELD lv_runtime.
  WRITE: / lv_runtime.

END-OF-SELECTION.
