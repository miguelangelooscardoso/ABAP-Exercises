*&---------------------------------------------------------------------*
*& Report ZBC420_XD01_00_MC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc420_xd01_00_mc.

INCLUDE bdcrecx1.

PARAMETERS: dataset(132) LOWER CASE.

TYPES: BEGIN OF ty_struc,
         nome     TYPE kna1-name1, "Nome 1
         camp_sel TYPE kna1-sortl, "Campo de seleção
         local    TYPE kna1-ort01, "Local
         pais     TYPE kna1-land1, "Chave do país
         idioma   TYPE kna1-spras, "Idioma
         cod_post TYPE kna1-pstlz, "Código postal
*         num_cont TYPE kna1-stcd1, "nº contribuinte
         transp   TYPE kna1-lzone, "Zona de transporte para a qual ou da qual é fornecido
       END OF ty_struc.

PARAMETERS: loc_dir TYPE string DEFAULT 'C:\Users\Miguel Cardoso\Downloads\Exercicios BI\Ficheiro Cliente BI.txt'.

DATA: lt_itab  TYPE TABLE OF ty_struc,
      ls_struc TYPE ty_struc.

START-OF-SELECTION. "required


  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename                = loc_dir
*     FILETYPE                = 'ASC'
      has_field_separator     = 'X'
    TABLES
      data_tab                = lt_itab
    EXCEPTIONS
      file_open_error         = 1
      file_read_error         = 2
      no_batch                = 3
      gui_refuse_filetransfer = 4
      invalid_type            = 5
      no_authority            = 6
      unknown_error           = 7
      bad_data_format         = 8
      header_not_allowed      = 9
      separator_not_allowed   = 10
      header_too_long         = 11
      unknown_dp_error        = 12
      access_denied           = 13
      dp_out_of_memory        = 14
      disk_full               = 15
      dp_timeout              = 16
      OTHERS                  = 17.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  LOOP AT lt_itab INTO  ls_struc.
    WRITE: / ls_struc-nome, ls_struc-camp_sel, ls_struc-local, ls_struc-cod_post, ls_struc-pais, ls_struc-idioma, ls_struc-transp.
  ENDLOOP.

  DATA: BEGIN OF record,
          ktokd_001(004),
          name1_002(035),
          sortl_003(010),
          ort01_004(035),
          pstlz_005(010),
          land1_006(003),
          spras_007(002),
          lzone_008(010),
        END OF record.

  LOOP AT lt_itab INTO ls_struc.

    IF sy-tabix <> 1.

      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = ls_struc-transp
        IMPORTING
          output = ls_struc-transp.

      record-ktokd_001(004) = '0002'.
      record-name1_002(035) = ls_struc-nome.
      record-sortl_003(010) = ls_struc-camp_sel.
      record-ort01_004(035) = ls_struc-local.
      record-pstlz_005(010) = ls_struc-cod_post.
      record-land1_006(003) = ls_struc-pais.
      record-spras_007(002) = ls_struc-idioma.
      record-lzone_008(010) = ls_struc-transp.
    ENDIF.

    CALL TRANSACTION 'XD01' using bdcdata.

    PERFORM open_dataset USING dataset.
    PERFORM open_group.

    DO.

      READ DATASET dataset INTO record.
      IF sy-subrc <> 0. EXIT. ENDIF.

      PERFORM bdc_dynpro      USING 'SAPMF02D' '0100'.
      PERFORM bdc_field       USING 'BDC_CURSOR'
                                    'RF02D-KTOKD'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '/00'.
      PERFORM bdc_field       USING 'RF02D-KTOKD'
                                    record-ktokd_001.
      PERFORM bdc_dynpro      USING 'SAPMF02D' '0110'.
      PERFORM bdc_field       USING 'BDC_CURSOR'
                                    'KNA1-PSTLZ'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '/00'.
      PERFORM bdc_field       USING 'KNA1-NAME1'
                                    record-name1_002.
      PERFORM bdc_field       USING 'KNA1-SORTL'
                                    record-sortl_003.
      PERFORM bdc_field       USING 'KNA1-ORT01'
                                    record-ort01_004.
      PERFORM bdc_field       USING 'KNA1-PSTLZ'
                                    record-pstlz_005.
      PERFORM bdc_field       USING 'KNA1-LAND1'
                                    record-land1_006.
      PERFORM bdc_field       USING 'KNA1-SPRAS'
                                    record-spras_007.
      PERFORM bdc_dynpro      USING 'SAPMF02D' '0120'.
      PERFORM bdc_field       USING 'BDC_CURSOR'
                                    'KNA1-LZONE'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=UPDA'.
      PERFORM bdc_field       USING 'KNA1-LZONE'
                                    record-lzone_008.
      PERFORM bdc_transaction USING 'XD01'.

    ENDDO.

  ENDLOOP.

  PERFORM close_group.
  PERFORM close_dataset USING dataset.
