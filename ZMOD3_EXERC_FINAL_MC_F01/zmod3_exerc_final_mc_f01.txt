*&---------------------------------------------------------------------*
*& Include          ZMOD3_EXERC_FINAL_MC_F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form SELECIONAR_DADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM selecionar_dados.
  SELECT a~id_pessoa a~nome b~codigo_funcao b~ordenado
         FROM zpessoas_mc AS a
         INNER JOIN zpess_funcao_mc AS b
         ON a~id_pessoa = b~id_pessoa
         INTO CORRESPONDING FIELDS OF TABLE gt_dados_pessoas
         WHERE a~id_pessoa IN so_pess.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form TRATAR_DADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM tratar_dados .

  FIELD-SYMBOLS: <fs_dados_pessoas> TYPE ty_dados_pessoas.

  LOOP AT gt_dados_pessoas ASSIGNING <fs_dados_pessoas>.
    <fs_dados_pessoas>-ordenado_anual = <fs_dados_pessoas>-ordenado * 12.
  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form EXIBIR_DADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM exibir_dados .

  DATA: lt_fieldcat TYPE TABLE OF slis_fieldcat_alv,
        ls_layout   TYPE slis_layout_alv,
        lv_title    TYPE lvc_title.

  lv_title = 'Dados Pessoais'.
  ls_layout-zebra = 'X'.

  PERFORM build_fieldcat TABLES lt_fieldcat.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK                 = ' '
*     I_BYPASSING_BUFFER                = ' '
*     I_BUFFER_ACTIVE                   = ' '
*     I_CALLBACK_PROGRAM                = ' '
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND           = ' '
*     I_CALLBACK_TOP_OF_PAGE            = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME                  =
*     I_BACKGROUND_ID                   = ' '
      i_grid_title  = lv_title
*     I_GRID_SETTINGS                   =
      is_layout     = ls_layout
      it_fieldcat   = lt_fieldcat
*     IT_EXCLUDING  =
*     IT_SPECIAL_GROUPS                 =
*     IT_SORT       =
*     IT_FILTER     =
*     IS_SEL_HIDE   =
*     I_DEFAULT     = 'X'
*     I_SAVE        = ' '
*     IS_VARIANT    =
*     IT_EVENTS     =
*     IT_EVENT_EXIT =
*     IS_PRINT      =
*     IS_REPREP_ID  =
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE                 = 0
*     I_HTML_HEIGHT_TOP                 = 0
*     I_HTML_HEIGHT_END                 = 0
*     IT_ALV_GRAPHICS                   =
*     IT_HYPERLINK  =
*     IT_ADD_FIELDCAT                   =
*     IT_EXCEPT_QINFO                   =
*     IR_SALV_FULLSCREEN_ADAPTER        =
* IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab      = gt_dados_pessoas
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDFORM.

FORM build_fieldcat TABLES t_fieldcat TYPE slis_t_fieldcat_alv.


  DATA: ls_fieldcat LIKE LINE OF t_fieldcat.

  CLEAR: ls_fieldcat.
  ls_fieldcat-col_pos = 1.
  ls_fieldcat-fieldname = 'ID_Pessoa'.
  ls_fieldcat-outputlen = 10.
  ls_fieldcat-seltext_l = 'Id'.
  APPEND ls_fieldcat TO t_fieldcat.


  CLEAR: ls_fieldcat.
  ls_fieldcat-col_pos = 2.
  ls_fieldcat-fieldname = 'Nome'.
  ls_fieldcat-outputlen = 20.
  ls_fieldcat-seltext_l = 'Nome'.
  APPEND ls_fieldcat TO t_fieldcat.


  CLEAR: ls_fieldcat.
  ls_fieldcat-col_pos = 3.
  ls_fieldcat-fieldname = 'Codigo_Funcao'.
  ls_fieldcat-outputlen = 20.
  ls_fieldcat-seltext_l = 'Funcao da pessoa'.
  APPEND ls_fieldcat TO t_fieldcat.

  IF p_mensal EQ 'X'.
    CLEAR: ls_fieldcat.
    ls_fieldcat-col_pos = 4.
    ls_fieldcat-fieldname = 'Ordenado'.
    ls_fieldcat-outputlen = 20.
    ls_fieldcat-seltext_l = 'Ordenado Mensal'.
    APPEND ls_fieldcat TO t_fieldcat.
  ELSE.
    CLEAR: ls_fieldcat.
    ls_fieldcat-col_pos = 5.
    ls_fieldcat-fieldname = 'Ordenado_Anual'.
    ls_fieldcat-outputlen = 20.
    ls_fieldcat-seltext_l = 'Ordenado Anual'.
    APPEND ls_fieldcat TO t_fieldcat.
  ENDIF.
ENDFORM.
