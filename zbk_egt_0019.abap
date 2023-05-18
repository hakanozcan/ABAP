*&---------------------------------------------------------------------*
*& Report ZBK_EGT_0019
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbk_egt_0019.

*PARAMETERS: p_num TYPE int4.
*
*INITIALIZATION.
*
*AT SELECTION-SCREEN OUTPUT.
*
*START-OF-SELECTION.

*DATA: gv_num TYPE i.
*
*PARAMETERS: p_num TYPE int4 MODIF ID gr1.
*
*SELECT-OPTIONS: s_num FOR gv_num MODIF ID gr1.
*
*INITIALIZATION.
*
*  LOOP AT SCREEN.
*    IF screen-group1 EQ 'GR1'.
*      screen-input = 0.
*      MODIFY SCREEN.
*    ENDIF.
*  ENDLOOP.,


PARAMETERS: p_num1 TYPE int4 MODIF ID gr1,
            p_num2 TYPE int4 MODIF ID gr1,
            p_num3 TYPE int4 MODIF ID gr2,
            p_num4 TYPE int4 MODIF ID gr2,
            p_num5 TYPE int4 MODIF ID gr3,
            p_num6 TYPE int4 MODIF ID gr3.