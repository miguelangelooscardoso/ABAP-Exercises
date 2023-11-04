*&---------------------------------------------------------------------*
*& Include          ZMOD3_EXERC_FINAL_MC_SCR
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK block1 WITH FRAME TITLE TEXT-001.

SELECT-OPTIONS: so_pess FOR zpessoas_mc-id_pessoa.

PARAMETERS: p_mensal RADIOBUTTON GROUP grp1 DEFAULT 'X',
            p_anual  RADIOBUTTON GROUP grp1.

SELECTION-SCREEN END OF BLOCK block1.
