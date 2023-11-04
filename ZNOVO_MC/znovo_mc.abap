report ZNOVO_MC
       no standard page heading line-size 255.

include bdcrecx1.

parameters: dataset(132) lower case.
***    DO NOT CHANGE - the generated data section - DO NOT CHANGE    ***
*
*   If it is nessesary to change the data section use the rules:
*   1.) Each definition of a field exists of two lines
*   2.) The first line shows exactly the comment
*       '* data element: ' followed with the data element
*       which describes the field.
*       If you don't have a data element use the
*       comment without a data element name
*   3.) The second line shows the fieldname of the
*       structure, the fieldname must consist of
*       a fieldname and optional the character '_' and
*       three numbers and the field length in brackets
*   4.) Each field must be type C.
*
*** Generated data section with specific formatting - DO NOT CHANGE  ***
data: begin of record,
* data element: KTOKD
        KTOKD_001(004),
* data element: NAME1_GP
        NAME1_002(035),
* data element: SORTL
        SORTL_003(010),
* data element: ORT01_GP
        ORT01_004(035),
* data element: PSTLZ
        PSTLZ_005(010),
* data element: LAND1_GP
        LAND1_006(003),
* data element: SPRAS
        SPRAS_007(002),
* data element: LZONE
        LZONE_008(010),
      end of record.

*** End generated data section ***

start-of-selection.

perform open_dataset using dataset.
perform open_group.

do.

read dataset dataset into record.
if sy-subrc <> 0. exit. endif.

perform bdc_dynpro      using 'SAPMF02D' '0100'.
perform bdc_field       using 'BDC_CURSOR'
                              'RF02D-KTOKD'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'RF02D-KTOKD'
                              record-KTOKD_001.
perform bdc_dynpro      using 'SAPMF02D' '0110'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNA1-SPRAS'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'KNA1-NAME1'
                              record-NAME1_002.
perform bdc_field       using 'KNA1-SORTL'
                              record-SORTL_003.
perform bdc_field       using 'KNA1-ORT01'
                              record-ORT01_004.
perform bdc_field       using 'KNA1-PSTLZ'
                              record-PSTLZ_005.
perform bdc_field       using 'KNA1-LAND1'
                              record-LAND1_006.
perform bdc_field       using 'KNA1-SPRAS'
                              record-SPRAS_007.
perform bdc_dynpro      using 'SAPMF02D' '0120'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNA1-LZONE'.
perform bdc_field       using 'BDC_OKCODE'
                              '=UPDA'.
perform bdc_field       using 'KNA1-LZONE'
                              record-LZONE_008.
perform bdc_transaction using 'XD01'.

enddo.

perform close_group.
perform close_dataset using dataset.
