*&---------------------------------------------------------------------*
*& Report ZMOD3_EXERC_FINAL_MC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmod3_exerc_final_mc.

INCLUDE zmod3_exerc_final_mc_top                .    " Global Data
INCLUDE zmod3_exerc_final_mc_scr                .    " Screens
INCLUDE zmod3_exerc_final_mc_f01                .    " FORM-Routines

* INCLUDE ZMOD3_EXERC_FINAL_MC_O01                .  " PBO-Modules
* INCLUDE ZMOD3_EXERC_FINAL_MC_I01                .  " PAI-Modules

START-OF-SELECTION.

  PERFORM selecionar_dados.

END-OF-SELECTION.

  PERFORM tratar_dados.
  PERFORM exibir_dados.
