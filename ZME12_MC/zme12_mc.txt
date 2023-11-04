report ZME12_MC
       no standard page heading line-size 255.

include bdcrecx1.

start-of-selection.

perform open_group.

perform bdc_dynpro      using 'SAPMM06I' '0100'.
perform bdc_field       using 'BDC_CURSOR'
                              'EINE-WERKS'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'EINA-LIFNR'
                              '100005'.
perform bdc_field       using 'EINA-MATNR'
                              '24'.
perform bdc_field       using 'EINE-EKORG'
                              '1000'.
perform bdc_field       using 'EINE-WERKS'
                              '1000'.
perform bdc_field       using 'RM06I-NORMB'
                              'X'.
perform bdc_dynpro      using 'SAPMM06I' '0101'.
perform bdc_field       using 'BDC_CURSOR'
                              'EINA-MAHN1'.
perform bdc_field       using 'BDC_OKCODE'
                              '=KO'.
perform bdc_dynpro      using 'SAPLV14A' '0102'.
perform bdc_field       using 'BDC_CURSOR'
                              'VAKE-DATAB(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=PICK'.
perform bdc_dynpro      using 'SAPMV13A' '0201'.
perform bdc_field       using 'BDC_CURSOR'
                              'KONP-KBETR(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=SICH'.
perform bdc_field       using 'KONP-KBETR(01)'
                              '          30,88'.
perform bdc_transaction using 'ME12'.

perform close_group.
