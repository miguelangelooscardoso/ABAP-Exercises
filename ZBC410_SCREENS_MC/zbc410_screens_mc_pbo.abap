*&---------------------------------------------------------------------*
*& Include          ZBC410_SCREENS_MC_PBO
*&---------------------------------------------------------------------*
 MODULE zbc410_screens_mc_pbo.

 ENDMODULE.

*&SPWIZARD: OUTPUT MODULE FOR TC 'SFLIGHTS'. DO NOT CHANGE THIS LINE!
*&SPWIZARD: COPY DDIC-TABLE TO ITAB
 MODULE sflights_init OUTPUT.
   IF g_sflights_copied IS INITIAL.
*&SPWIZARD: COPY DDIC-TABLE 'SFLIGHT'
*&SPWIZARD: INTO INTERNAL TABLE 'g_SFLIGHTS_itab'
     SELECT * FROM sflight
        INTO CORRESPONDING FIELDS
        OF TABLE g_sflights_itab
       WHERE carrid EQ lv_carrid AND connid EQ lv_connid.
     g_sflights_copied = 'X'.
     REFRESH CONTROL 'SFLIGHTS' FROM SCREEN '0002'.
   ENDIF.
 ENDMODULE.

*&SPWIZARD: OUTPUT MODULE FOR TC 'SFLIGHTS'. DO NOT CHANGE THIS LINE!
*&SPWIZARD: MOVE ITAB TO DYNPRO
 MODULE sflights_move OUTPUT.
   MOVE-CORRESPONDING g_sflights_wa TO sflight.
 ENDMODULE.

*&SPWIZARD: OUTPUT MODULE FOR TC 'SFLIGHTS'. DO NOT CHANGE THIS LINE!
*&SPWIZARD: GET LINES OF TABLECONTROL
 MODULE sflights_get_lines OUTPUT.
   g_sflights_lines = sy-loopc.
 ENDMODULE.
*&---------------------------------------------------------------------*
*& Module ZBC410_SCREENS_MC_PBO OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE zbc410_screens_mc_pbo OUTPUT.
 SET PF-STATUS 'STANDARD_FULLSCREEN'.
 SET TITLEBAR 'STANDARD_TITLEBAR'.
ENDMODULE.
