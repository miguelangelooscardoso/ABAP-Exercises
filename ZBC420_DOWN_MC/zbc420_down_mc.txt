*&---------------------------------------------------------------------*
*& Report ZBC420_DOWN_MC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc420_down_mc.

PARAMETERS: p_down TYPE string DEFAULT 'C:\Users\Miguel Cardoso\Desktop\teste.txt' OBLIGATORY LOWER CASE.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_down.

  CALL FUNCTION 'WS_FILENAME_GET'
* EXPORTING
*   DEF_FILENAME           = ' '
*   DEF_PATH               = ' '
*   MASK                   = ' '
*   MODE                   = ' '
*   TITLE                  = ' '
    IMPORTING
      filename = p_down
*     RC       =
* EXCEPTIONS
*     INV_WINSYS             = 1
*     NO_BATCH = 2
*     SELECTION_CANCEL       = 3
*     SELECTION_ERROR        = 4
*     OTHERS   = 5
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


  TYPES: BEGIN OF ty_download,
           kunnr LIKE kna1-kunnr,
           land1 LIKE kna1-land1,
           name1 LIKE kna1-name1,
           stras LIKE kna1-stras,
           ort01 LIKE kna1-ort01,
           pstlz LIKE kna1-pstlz,
         END OF ty_download.

  DATA: itab TYPE STANDARD TABLE OF ty_download
  WITH KEY kunnr WITH HEADER LINE.

  SELECT kunnr land1 name1 stras ort01 pstlz
  FROM kna1 INTO CORRESPONDING FIELDS OF TABLE itab.

  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
*     BIN_FILESIZE                    =
      filename = p_down
*     FILETYPE = 'ASC'
*     APPEND   = ' '
*     WRITE_FIELD_SEPARATOR           = ' '
*     HEADER   = '00'
*     TRUNC_TRAILING_BLANKS           = ' '
*     WRITE_LF = 'X'
*     COL_SELECT                      = ' '
*     COL_SELECT_MASK                 = ' '
*     DAT_MODE = ' '
*     CONFIRM_OVERWRITE               = ' '
*     NO_AUTH_CHECK                   = ' '
*     CODEPAGE = ' '
*     IGNORE_CERR                     = ABAP_TRUE
*     REPLACEMENT                     = '#'
*     WRITE_BOM                       = ' '
*     TRUNC_TRAILING_BLANKS_EOL       = 'X'
*     WK1_N_FORMAT                    = ' '
*     WK1_N_SIZE                      = ' '
*     WK1_T_FORMAT                    = ' '
*     WK1_T_SIZE                      = ' '
*     WRITE_LF_AFTER_LAST_LINE        = ABAP_TRUE
*     SHOW_TRANSFER_STATUS            = ABAP_TRUE
*     VIRUS_SCAN_PROFILE              = '/SCET/GUI_DOWNLOAD'
*   IMPORTING
*     FILELENGTH                      =
    TABLES
      data_tab = itab
*     FIELDNAMES                      =
*   EXCEPTIONS
*     FILE_WRITE_ERROR                = 1
*     NO_BATCH = 2
*     GUI_REFUSE_FILETRANSFER         = 3
*     INVALID_TYPE                    = 4
*     NO_AUTHORITY                    = 5
*     UNKNOWN_ERROR                   = 6
*     HEADER_NOT_ALLOWED              = 7
*     SEPARATOR_NOT_ALLOWED           = 8
*     FILESIZE_NOT_ALLOWED            = 9
*     HEADER_TOO_LONG                 = 10
*     DP_ERROR_CREATE                 = 11
*     DP_ERROR_SEND                   = 12
*     DP_ERROR_WRITE                  = 13
*     UNKNOWN_DP_ERROR                = 14
*     ACCESS_DENIED                   = 15
*     DP_OUT_OF_MEMORY                = 16
*     DISK_FULL                       = 17
*     DP_TIMEOUT                      = 18
*     FILE_NOT_FOUND                  = 19
*     DATAPROVIDER_EXCEPTION          = 20
*     CONTROL_FLUSH_ERROR             = 21
*     OTHERS   = 22
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
