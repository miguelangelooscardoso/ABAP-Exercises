*&---------------------------------------------------------------------*
*& Report ZBC420_UPLOAD_MC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc420_upload_mc.

PARAMETERS: p_up TYPE string DEFAULT 'C:\Users\Miguel Cardoso\Desktop\teste.txt' OBLIGATORY LOWER CASE.

TYPES: BEGIN OF ty_upload,
         kunnr LIKE kna1-kunnr,
         land1 LIKE kna1-land1,
         name1 LIKE kna1-name1,
         stras LIKE kna1-stras,
         ort01 LIKE kna1-ort01,
         pstlz LIKE kna1-pstlz,
       END OF ty_upload.

DATA: itab TYPE STANDARD TABLE OF ty_upload
WITH KEY kunnr WITH HEADER LINE.

DATA: strut TYPE ty_upload.

CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename = p_up
*   FILETYPE = 'ASC'
*   HAS_FIELD_SEPARATOR           = ' '
*   HEADER_LENGTH                 = 0
*   READ_BY_LINE                  = 'X'
*   DAT_MODE = ' '
*   CODEPAGE = ' '
*   IGNORE_CERR                   = ABAP_TRUE
*   REPLACEMENT                   = '#'
*   CHECK_BOM                     = ' '
*   VIRUS_SCAN_PROFILE            =
*   NO_AUTH_CHECK                 = ' '
* IMPORTING
*   FILELENGTH                    =
*   HEADER   =
  TABLES
    data_tab = itab
* CHANGING
*   ISSCANPERFORMED               = ' '
* EXCEPTIONS
*   FILE_OPEN_ERROR               = 1
*   FILE_READ_ERROR               = 2
*   NO_BATCH = 3
*   GUI_REFUSE_FILETRANSFER       = 4
*   INVALID_TYPE                  = 5
*   NO_AUTHORITY                  = 6
*   UNKNOWN_ERROR                 = 7
*   BAD_DATA_FORMAT               = 8
*   HEADER_NOT_ALLOWED            = 9
*   SEPARATOR_NOT_ALLOWED         = 10
*   HEADER_TOO_LONG               = 11
*   UNKNOWN_DP_ERROR              = 12
*   ACCESS_DENIED                 = 13
*   DP_OUT_OF_MEMORY              = 14
*   DISK_FULL                     = 15
*   DP_TIMEOUT                    = 16
*   OTHERS   = 17
  .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

SORT itab ASCENDING by kunnr.

LOOP AT itab INTO strut.

  WRITE: / strut-kunnr, strut-land1, strut-name1, strut-stras, strut-ort01, strut-pstlz.

ENDLOOP.
