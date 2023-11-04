*&---------------------------------------------------------------------*
*& Report ZBC20_FILE_02_MC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc20_file_02_mc.

PARAMETERS: p_up TYPE string DEFAULT 'C:\Users\Miguel Cardoso\Downloads\novos_bps.txt' OBLIGATORY LOWER CASE.

TYPES: BEGIN OF ty_upload,
         categoria  TYPE bu_type,
         firstname  TYPE bu_namep_f,
         lastname   TYPE bu_namep_l,
         searchterm TYPE bu_sort1,
         language   TYPE bu_langu,
         postalcode TYPE ad_pstcd1,
         city       TYPE ad_city1,
         country    TYPE land1,
       END OF ty_upload.

DATA: itab TYPE STANDARD TABLE OF ty_upload
WITH KEY firstname WITH HEADER LINE.

DATA: strut TYPE ty_upload.

CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename            = p_up
    has_field_separator = 'X'
  TABLES
    data_tab            = itab.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.


DATA:
  bp_cat            TYPE bapibus1006_head-partn_cat,
  bp_central        TYPE bapibus1006_central,
  bp_central_person TYPE bapibus1006_central_person,
  bp_address_data   TYPE bapibus1006_address.

LOOP AT itab INTO strut.
  IF sy-tabix <> 1.
    WRITE: / strut-categoria, strut-firstname, strut-lastname, strut-searchterm, strut-language, strut-postalcode, strut-city, strut-country.

    bp_cat = strut-categoria.

    bp_central-searchterm1 = strut-searchterm.
    bp_central-partnerlanguage = strut-country.

    bp_central_person-firstname = strut-firstname.
    bp_central_person-lastname = strut-lastname.

    bp_address_data-postl_cod1 = strut-postalcode.
    bp_address_data-city = strut-city.
    bp_address_data-country = strut-country.

    CALL FUNCTION 'BAPI_BUPA_CREATE_FROM_DATA'
      EXPORTING
        partnercategory   = bp_cat
        centraldata       = bp_central
        centraldataperson = bp_central_person
        addressdata       = bp_address_data.

    IF sy-subrc <> 0.
      WRITE: / 'ERRADO!'.
    ENDIF.

    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.

  ENDIF.

ENDLOOP.
