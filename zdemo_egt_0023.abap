REPORT zdemo_egt_0023.


TYPES: BEGIN OF gty_type1,
         col1 TYPE char10,
         col2 TYPE char10,
         col3 TYPE char10,
         col4 TYPE char10,
       END OF gty_type1.

TYPES: BEGIN OF gty_type2,
         col2 TYPE char10,
         col3 TYPE char10,
       END OF gty_type2.

DATA:gs_st1 TYPE gty_type1,
     gs_st2 TYPE gty_type2.

START-OF-SELECTION.

  gs_st1-col1 = 'aaaa'.
  gs_st1-col2 = 'bbbb'.
  gs_st1-col3 = 'cccc'.
  gs_st1-col4 = 'dddd'.

*  gs_st2 = gs_st1.

  MOVE-CORRESPONDING gs_st1 TO gs_st2.

  BREAK-POINT.


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