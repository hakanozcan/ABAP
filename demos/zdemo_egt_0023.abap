REPORT zdemo_egt_0023.

TABLES: scarr.
*DATA: gs_scarr TYPE scarr.

START-OF-SELECTION.

  SELECT * FROM scarr WHERE currcode EQ 'EUR'.
  ENDSELECT.
  BREAK-POINT.
*SELECT * FROM scarr INTO gs_scarr.
*
*ENDSELECT.

*DATA: gt_scarr TYPE TABLE OF scarr,
*      gs_scarr TYPE scarr.
*
*FIELD-SYMBOLS: <gfs_scarr> TYPE scarr.
*
*

*
*  SELECT * FROM scarr
*    INTO TABLE gt_scarr.

*  LOOP AT gt_scarr INTO gs_scarr.
*    IF gs_scarr-carrid EQ 'LH'.
*      gs_scarr-carrname = 'Hakan'.
*      MODIFY gt_scarr FROM gs_scarr.
*    ENDIF.
*  ENDLOOP.

*  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
*    IF <gfs_scarr>-carrid EQ 'LH'.
*      <gfs_scarr>-carrname = 'Hakan Özcan'.
*    ENDIF.
*  ENDLOOP.

*READ TABLE gt_scarr INTO gs_scarr WITH KEY carrid = 'LH'.
*gs_scarr-carrname = 'Hakan Özcan'.

*  READ TABLE gt_scarr ASSIGNING <gfs_scarr> WITH KEY carrid = 'LH'.
*  <gfs_scarr>-carrname = 'Hakan Özcan'.
*
*  BREAK-POINT.

*TYPES: BEGIN OF gty_type1,
*         col1 TYPE char10,
*         col2 TYPE char10,
*         col3 TYPE char10,
*         col4 TYPE char10,
*       END OF gty_type1.
*
*TYPES: BEGIN OF gty_type2,
*         col2 TYPE char10,
*         col3 TYPE char10,
*       END OF gty_type2.
*
*DATA:gs_st1 TYPE gty_type1,
*     gs_st2 TYPE gty_type2.
*
*
*
*  gs_st1-col1 = 'aaaa'.
*  gs_st1-col2 = 'bbbb'.
*  gs_st1-col3 = 'cccc'.
*  gs_st1-col4 = 'dddd'.
*
**  gs_st2 = gs_st1.
*
*  MOVE-CORRESPONDING gs_st1 TO gs_st2.
*
*  BREAK-POINT.


*DATA: gt_scarr TYPE TABLE OF scarr,
*      gs_scarr TYPE scarr,
*      gv_currcode TYPE s_currcode.

*DATA: gt_scarr TYPE TABLE OF scarr,
*      gs_scarr TYPE scarr.
*
*
*DATA: gt_scarr  TYPE TABLE OF scarr,
*      gt_scarr2 TYPE TABLE OF scarr.

*TYPES: BEGIN OF gty_scarr,
*         mandt    TYPE s_mandt,
*         carrid   TYPE s_carr_id,
*         carrname TYPE s_carrname,
*         currcode TYPE s_currcode,
*         url      TYPE s_carrurl,
*       END OF gty_scarr.
*
*DATA: gt_scarr TYPE TABLE OF gty_scarr.
*
*
*SELECT * FROM scarr
*  INTO CORRESPONDING FIELDS OF TABLE gt_scarr.
*
*BREAK-POINT.
*
*  SELECT carrid carrname FROM scarr
*    INTO TABLE gt_scarr.
*
*  SELECT carrid carrname FROM scarr
*    INTO CORRESPONDING FIELDS OF TABLE gt_scarr2.
*  BREAK-POINT.
*
*  SELECT * FROM scarr
*    INTO TABLE gt_scarr.

*  READ TABLE gt_scarr INTO gs_scarr INDEX 4.
*
*  WRITE: gs_scarr.

*  READ TABLE gt_scarr INTO gs_scarr WITH KEY carrname = 'Alitalia'.
*  READ TABLE gt_scarr INTO gs_scarr WITH KEY currcode = 'EUR'
*                                             carrname ='Alitalia'.

*  LOOP AT gt_scarr INTO gs_scarr WHERE currcode = 'EUR'.
*    WRITE: gs_scarr.
*  ENDLOOP.
*
*  WRITE: gs_scarr.

*  SELECT * FROM scarr
*    INTO TABLE gt_scarr
*  WHERE carrid EQ 'AC'.
*
*  READ TABLE gt_scarr INTO gs_scarr INDEX 1.
*
*  WRITE: gs_scarr-currcode.


*  SELECT * UP TO 1 ROWS FROM scarr
*    INTO TABLE gt_scarr
*WHERE carrid EQ 'AC'.
*
*  READ TABLE gt_scarr INTO gs_scarr INDEX 1.
*
*  WRITE: gs_scarr-currcode.

*SELECT SINGLE currcode FROM scarr
*  INTO gv_currcode
*  WHERE carrid eq 'AC'.
*
*WRITE: gv_currcode.