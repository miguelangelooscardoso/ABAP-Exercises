*&---------------------------------------------------------------------*
*& Report ZCOCKPIT_MC_AUX
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcockpit_mc_aux.

DATA:
  frgc  TYPE string,
  index TYPE numc1,
  frgci TYPE string.

TYPES: BEGIN OF ty_frgci,
         frgco TYPE frgco,
       END OF ty_frgci.

DATA:
  gt_frgci TYPE TABLE OF ty_frgci,
  gs_frgci TYPE ty_frgci.

index = 0.

DATA:
  lv_frggr TYPE string,
  lv_frgsx TYPE string.

lv_frggr = '01'.
lv_frgsx = '03'.

*WHILE index < 3.
*  frgc = 'frgc'.
*  index = index + 1.
*  CONCATENATE frgc index INTO frgci.
*
*  IF frgci = 'frgc1'.
*
*    SELECT frgc1 FROM t16fs
*      WHERE ( frggr = @lv_frggr AND frgsx = @lv_frgsx )
*      APPENDING TABLE @gt_frgci.
*
*  ELSEIF frgci = 'frgc2'.
*
*    SELECT frgc2 FROM t16fs
*  WHERE ( frggr = @lv_frggr AND frgsx = @lv_frgsx )
*      APPENDING TABLE @gt_frgci.
*
*  ELSEIF frgci = 'frgc3'.
*
*    SELECT frgc3 FROM t16fs
*  WHERE ( frggr = @lv_frggr AND frgsx = @lv_frgsx )
*      APPENDING TABLE @gt_frgci.
*
*  ENDIF.
*
*  WRITE: / frgci.
*
*ENDWHILE.

DATA:
  lv TYPE frgco,
  gt TYPE TABLE OF t16fs,
  gs TYPE t16fs.

SELECT * FROM t16fs
    WHERE ( frggr = @lv_frggr AND frgsx = @lv_frgsx )
  INTO CORRESPONDING FIELDS OF TABLE @gt.

LOOP AT gt INTO gs.
  WHILE index < 3.

    frgc = 'frgc'.
    index = index + 1.
    CONCATENATE frgc index INTO frgci.

    CASE frgci.
      WHEN 'frgc1'.
        lv = gs-frgc1.
      WHEN 'frgc2'.
        lv = gs-frgc2.
      WHEN 'frgc3'.
        lv = gs-frgc3.
    ENDCASE.

    APPEND lv TO gt_frgci.
  ENDWHILE.
ENDLOOP.
