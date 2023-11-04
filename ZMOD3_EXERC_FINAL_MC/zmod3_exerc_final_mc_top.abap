*&---------------------------------------------------------------------*
*& Include ZMOD3_EXERC_FINAL_MC_TOP
*&---------------------------------------------------------------------*

TABLES: ZPESSOAS_MC,
        ZPESS_FUNCAO_MC.

TYPES:
  BEGIN OF ty_dados_pessoas,
    id_pessoa      TYPE zpessoas_mc-id_pessoa,
    nome           TYPE zpessoas_mc-nome,
    codigo_funcao  TYPE zpess_funcao_mc-codigo_funcao,
    ordenado       TYPE zpess_funcao_mc-ordenado,
    ordenado_anual TYPE p DECIMALS 2,
  END OF ty_dados_pessoas.

  DATA: gt_dados_pessoas TYPE TABLE OF ty_dados_pessoas,
        gs_dados_pessoas TYPE ty_dados_pessoas.
