*&---------------------------------------------------------------------*
*& Report ZBC420_FILE_MC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc420_file_mc.

PARAMETERS: lv_leit    TYPE string DEFAULT 'C:\Users\Miguel Cardoso\Downloads\Exercicios BI\Ficheiro Cliente BI.txt',
            tmp_dir TYPE string DEFAULT '/usr/sap/tmp/zbc420_file_mc.txt' LOWER CASE,
            lv_escr TYPE string DEFAULT 'zbc420_file_mc.txt',
            lv_down    TYPE string DEFAULT 'C:\Users\Miguel Cardoso\Downloads'.

TYPES: BEGIN OF ty_est,
         nome(15)     TYPE c,
         pesquisa(16) TYPE c,
         cidade(15)   TYPE c,
         postal(10)   TYPE c,
       END OF ty_est.

DATA: lt_tab    TYPE TABLE OF ty_est,
      ls_tab    TYPE ty_est,
      lv_string TYPE string.

CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename            = lv_leit
*   FILETYPE            = 'ASC'
    has_field_separator = 'X'
*   HEADER_LENGTH       = 0
*   READ_BY_LINE        = 'X'
*   DAT_MODE            = ' '
*   CODEPAGE            = ' '
*   IGNORE_CERR         = ABAP_TRUE
*   REPLACEMENT         = '#'
*   CHECK_BOM           = ' '
*   VIRUS_SCAN_PROFILE  =
*   NO_AUTH_CHECK       = ' '
* IMPORTING
*   FILELENGTH          =
*   HEADER              =
  TABLES
    data_tab            = lt_tab
* CHANGING
*   ISSCANPERFORMED     = ' '
* EXCEPTIONS
*   FILE_OPEN_ERROR     = 1
*   FILE_READ_ERROR     = 2
*   NO_BATCH            = 3
*   GUI_REFUSE_FILETRANSFER       = 4
*   INVALID_TYPE        = 5
*   NO_AUTHORITY        = 6
*   UNKNOWN_ERROR       = 7
*   BAD_DATA_FORMAT     = 8
*   HEADER_NOT_ALLOWED  = 9
*   SEPARATOR_NOT_ALLOWED         = 10
*   HEADER_TOO_LONG     = 11
*   UNKNOWN_DP_ERROR    = 12
*   ACCESS_DENIED       = 13
*   DP_OUT_OF_MEMORY    = 14
*   DISK_FULL           = 15
*   DP_TIMEOUT          = 16
*   OTHERS              = 17
  .

DATA: msg TYPE string .

*OPEN DATASET tmp_dir FOR OUTPUT IN TEXT MODE ENCODING DEFAULT MESSAGE msg.

OPEN DATASET tmp_dir FOR APPENDING IN TEXT MODE ENCODING DEFAULT MESSAGE msg.

IF sy-subrc <> 0.
* Implement suitable error handling here
  WRITE: msg.
ELSE.
  LOOP AT lt_tab INTO ls_tab.
    IF sy-tabix = 1. " removes header
      CONTINUE.
    ENDIF.
    CONCATENATE ls_tab-nome ls_tab-pesquisa ls_tab-cidade ls_tab-postal INTO lv_string SEPARATED BY ' '.
    TRANSFER lv_string TO tmp_dir.
  ENDLOOP.
  CLOSE DATASET tmp_dir.
ENDIF.
