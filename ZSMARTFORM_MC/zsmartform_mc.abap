*&---------------------------------------------------------------------*
*& Report ZSMARTFORM_MC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsmartform_mc.

DATA: lt_ekko  TYPE TABLE OF ekko,
      ls_ekko  TYPE          ekko,
      lv_local TYPE         kna1-stras.

SELECT SINGLE stras
  FROM kna1
  INTO lv_local
  WHERE ort01 = 'México'.

SELECT ebeln bukrs lifnr
  FROM ekko
  INTO CORRESPONDING FIELDS OF TABLE lt_ekko
  UP TO 10 ROWS.


CALL FUNCTION '/1BCDWB/SF00000139'
  EXPORTING
*   ARCHIVE_INDEX              =
*   ARCHIVE_INDEX_TAB          =
*   ARCHIVE_PARAMETERS         =
*   CONTROL_PARAMETERS         =
*   MAIL_APPL_OBJ              =
*   MAIL_RECIPIENT             =
*   MAIL_SENDER                =
*   OUTPUT_OPTIONS             =
*   USER_SETTINGS              = 'X'
    i_data_dia = sy-datum
    i_local    = lv_local
* IMPORTING
*   DOCUMENT_OUTPUT_INFO       =
*   JOB_OUTPUT_INFO            =
*   JOB_OUTPUT_OPTIONS         =
TABLES
   lt_ekko    = lt_ekko
* EXCEPTIONS
*   FORMATTING_ERROR           = 1
*   INTERNAL_ERROR             = 2
*   SEND_ERROR = 3
*   USER_CANCELED              = 4
*   OTHERS     = 5
  .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
