*&---------------------------------------------------------------------*
*& Include          ZBC410_SCREENS_MC_PAI
*&---------------------------------------------------------------------*

MODULE zbc410_screens_mc_pai.

  IF sy-ucomm = 'SAVE'.

    AUTHORITY-CHECK OBJECT 'S_CARRID'
     ID 'CARRID' FIELD lv_carrid
     ID 'ACTVT' FIELD '03'.

    IF sy-subrc <> 0.
      MESSAGE i045(bc410).
    ENDIF.

    SELECT carrid connid FROM sflight
       INTO CORRESPONDING FIELDS
       OF TABLE lt_tab
      WHERE carrid EQ lv_carrid AND connid EQ lv_connid.

    IF lt_tab[] IS NOT INITIAL. " não vazia
      CALL SCREEN '0002'.
    ELSE.
      MESSAGE: 'No flights found!'TYPE 'I'.

    ENDIF.

  ELSEIF sy-ucomm = '&F03'.
    LEAVE PROGRAM.
  ENDIF.

ENDMODULE.

*&SPWIZARD: INPUT MODULE FOR TC 'SFLIGHTS'. DO NOT CHANGE THIS LINE!
*&SPWIZARD: PROCESS USER COMMAND
MODULE sflights_user_command INPUT.
  ok_code = sy-ucomm.
  PERFORM user_ok_tc USING    'SFLIGHTS'
                              'G_SFLIGHTS_ITAB'
                              'FLAG'
                     CHANGING ok_code.
  sy-ucomm = ok_code.

  IF sy-ucomm = '&F03'.
    LEAVE PROGRAM.
  ENDIF.
ENDMODULE.
