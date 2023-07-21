*&---------------------------------------------------------------------*
*& Report ZDEMO_EGT_0004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEMO_EGT_0004.

TABLES: zbk_pers_t.

DATA: gv_persoyad TYPE zbk_perssoyad_de.

PARAMETERS: p_num1   TYPE int4,
            p_persad TYPE zbk_perad_de.

SELECT-OPTIONS: s_perssd FOR gv_persoyad,
                s_perscn FOR zbk_pers_t-pers_cins.

PARAMETERS: p_cbox1 AS CHECKBOX.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-001.

PARAMETERS: p_rad1 RADIOBUTTON GROUP gr1,
            p_rad2 RADIOBUTTON GROUP gr1,
            p_rad3 RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF BLOCK bl1.

SELECTION-SCREEN BEGIN OF BLOCK bl2 WITH FRAME TITLE TEXT-002.
PARAMETERS:
  p_rad4 RADIOBUTTON GROUP gr2,
  p_rad5 RADIOBUTTON GROUP gr2.
SELECTION-SCREEN END OF BLOCK bl2.