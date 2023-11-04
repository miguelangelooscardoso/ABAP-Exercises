*&---------------------------------------------------------------------*
*& Report ZTEST_CREATE_BP_WITH_BAPI_MC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_create_bp_with_bapi_mc.

DATA:
  bp_cat            TYPE bapibus1006_head-partn_cat,
  bp_central        TYPE bapibus1006_central,
  bp_central_person TYPE bapibus1006_central_person,
  bp_address_data   TYPE bapibus1006_address.

bp_cat = '1'.

*partn_cat-partn_typ = '0001'.

bp_central-searchterm1 = 'termo_pesquisa'.
bp_central-partnerlanguage = 'PT'.

bp_central_person-firstname = 'Miguel'.

bp_address_data-postl_cod1 = '3060-586'.
bp_address_data-city = 'Tocha'.
bp_address_data-country = 'PT'.

CALL FUNCTION 'BAPI_BUPA_CREATE_FROM_DATA'
  EXPORTING
*   BUSINESSPARTNEREXTERN              =
    partnercategory   = bp_cat
*   PARTNERGROUP      =
    centraldata       = bp_central
    centraldataperson = bp_central_person
*   CENTRALDATAORGANIZATION            =
*   CENTRALDATAGROUP  =
    addressdata       = bp_address_data
*   DUPLICATE_MESSAGE_TYPE             =
*   ACCEPT_ERROR      = ' '
* IMPORTING
*   BUSINESSPARTNER   =
* TABLES
*   TELEFONDATA       =
*   FAXDATA           =
*   TELETEXDATA       =
*   TELEXDATA         =
*   E_MAILDATA        =
*   RMLADDRESSDATA    =
*   X400ADDRESSDATA   =
*   RFCADDRESSDATA    =
*   PRTADDRESSDATA    =
*   SSFADDRESSDATA    =
*   URIADDRESSDATA    =
*   PAGADDRESSDATA    =
*   ADDRESSNOTES      =
*   COMMUNICATIONNOTES                 =
*   COMMUNICATIONUSAGE                 =
*   TELEFONDATANONADDRESS              =
*   FAXDATANONADDRESS =
*   TELETEXDATANONADDRESS              =
*   TELEXDATANONADDRESS                =
*   E_MAILDATANONADDRESS               =
*   RMLADDRESSDATANONADDRESS           =
*   X400ADDRESSDATANONADDRESS          =
*   RFCADDRESSDATANONADDRESS           =
*   PRTADDRESSDATANONADDRESS           =
*   SSFADDRESSDATANONADDRESS           =
*   URIADDRESSDATANONADDRESS           =
*   PAGADDRESSDATANONADDRESS           =
*   COMMUNICATIONNOTESNONADDRESS       =
*   COMMUNICATIONUSAGENONADDRESS       =
*   RETURN            =
*   ADDRESSDUPLICATES =
  .

IF sy-subrc <> 0.
  WRITE: / 'ERRADO!'.
  ELSE.
    MESSAGE 'SUCESSO!' TYPE 'I'.
ENDIF.

CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
* EXPORTING
*   WAIT          =
* IMPORTING
*   RETURN        =
          .

*CALL FUNCTION 'BUP_BUPA_DELETE'
*  EXPORTING
*    iv_partner                 = '2200021'
**   IV_TESTRUN                 = 'X'
**   IV_XDELE                   = 'X'
**   IV_WITH_LOG                = 'X'
** TABLES
**   ET_RESULTS                 =
** EXCEPTIONS
**   DELETION_NOT_ALLOWED       = 1
**   FATAL_ERROR                = 2
**   OTHERS                     = 3
*          .
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.
