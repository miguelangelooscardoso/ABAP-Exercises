*&---------------------------------------------------------------------*
*& Include          ZBC410_SCREENS_MC_TOP
*&---------------------------------------------------------------------*

DATA:
      lv_carrid  TYPE sflight-carrid,
      lv_connid  TYPE sflight-connid,
      lt_tab TYPE TABLE OF sflights.

***&SPWIZARD: DATA DECLARATION FOR TABLECONTROL 'SFLIGHTS'
*&SPWIZARD: DEFINITION OF DDIC-TABLE
TABLES:   sflight.

*&SPWIZARD: TYPE FOR THE DATA OF TABLECONTROL 'SFLIGHTS'
TYPES: BEGIN OF t_sflights,
         carrid   LIKE sflight-carrid,
         connid   LIKE sflight-connid,
         price    LIKE sflight-price,
         currency LIKE sflight-currency,
         seatsmax LIKE sflight-seatsmax,
         seatsocc LIKE sflight-seatsocc,
       END OF t_sflights.

*&SPWIZARD: INTERNAL TABLE FOR TABLECONTROL 'SFLIGHTS'
DATA: g_sflights_itab TYPE t_sflights OCCURS 0,
      g_sflights_wa   TYPE t_sflights. "work area
DATA:     g_sflights_copied.           "copy flag

*&SPWIZARD: DECLARATION OF TABLECONTROL 'SFLIGHTS' ITSELF
CONTROLS: sflights TYPE TABLEVIEW USING SCREEN 0002.

*&SPWIZARD: LINES OF TABLECONTROL 'SFLIGHTS'
DATA:     g_sflights_lines  LIKE sy-loopc.

DATA:     ok_code LIKE sy-ucomm.
