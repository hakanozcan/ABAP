*&---------------------------------------------------------------------*
*& Report  ZDEMO_SALES_REPORT
*&
*&---------------------------------------------------------------------*
*&  Description: Report program to display sales order data
*&  hozcan
*&---------------------------------------------------------------------*
REPORT zdemo_sales_report LINE-COUNT 32(5)
                          LINE-SIZE 120
                          MESSAGE-ID zdemo_msg
                          NO STANDARD PAGE HEADING.


*&---------------------------------------------------------------------*
*&  TABLES
*&---------------------------------------------------------------------*
TABLES: vbak, "Header Data
        vbap, "Item data
        mara. "General material data

*&---------------------------------------------------------------------*
*&  STRUCTURE
*&---------------------------------------------------------------------*
TYPES: BEGIN OF st_sal, "Structure for sales data from vbak, vbap, mara
         vbeln TYPE vbeln_va,
         erdat TYPE  erdat,
         ernam TYPE ernam,
         posnr TYPE posnr,
         matnr TYPE matnr,
         matkl TYPE matkl,
       END OF st_sal.

*&---------------------------------------------------------------------*
*&  ITAB
*&---------------------------------------------------------------------*
DATA: it_sal TYPE STANDARD TABLE OF st_sal,
      wa_sal TYPE st_sal.

*&---------------------------------------------------------------------*
*&  SELECTION SCREEN
*&---------------------------------------------------------------------*
SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE text-008.
"SELECT-OPTIONS: s_vbeln FOR vbak-vbeln NO-EXTENSION.
*SELECT-OPTIONS: s_vbeln FOR vbak-vbeln NO INTERVALS.
*SELECT-OPTIONS: s_vbeln FOR vbak-vbeln NO-EXTENSION NO INTERVALS.
SELECT-OPTIONS: s_vbeln FOR vbak-vbeln OBLIGATORY. "REQUIRED
PARAMETERS: p_ernam TYPE vbak-ernam.
SELECTION-SCREEN: END OF BLOCK b1.

PARAMETERS: rb1 RADIOBUTTON GROUP g1,
            rb2 RADIOBUTTON GROUP g1.

PARAMETERS: cb1 AS CHECKBOX,
            cb2 AS CHECKBOX.
*
*SELECTION-SCREEN: BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.
*SELECT-OPTIONS: s_vbeln FOR vbak-vbeln.
*SELECTION-SCREEN: END OF BLOCK b2.


*&---------------------------------------------------------------------*
*&  INITIALIZATION
*&---------------------------------------------------------------------*
INITIALIZATION.

  s_vbeln-low  = '1000'.
  s_vbeln-high = '5000'.
  s_vbeln-sign = 'I'.
  s_vbeln-option = 'BT'. "EQ, NE, LT, GT, LE, GE, BT, NB
  APPEND s_vbeln.

*  s_vbeln-low  = '8000'.
*  s_vbeln-high = '9000'.
*  s_vbeln-sign = 'E'.
*  s_vbeln-option = 'NB'.
*  APPEND s_vbeln.


*&---------------------------------------------------------------------*
*&  AT SELECTION SCREEN
*&---------------------------------------------------------------------*
AT SELECTION-SCREEN.
  IF s_vbeln-low < 500.
    MESSAGE e002.
  ENDIF.

*&---------------------------------------------------------------------*
*&  START OF SELECTION
*&---------------------------------------------------------------------*
START-OF-SELECTION.
  SELECT vbak~vbeln
    vbak~erdat
    vbak~ernam
    vbap~posnr
    vbap~matnr
    mara~matkl
    INTO TABLE it_sal
    FROM vbak INNER JOIN vbap
    ON vbak~vbeln = vbap~vbeln
    INNER JOIN mara
    ON vbap~matnr = mara~matnr
    WHERE vbak~vbeln IN s_vbeln.

  IF sy-subrc <> 0.
    MESSAGE a003.
  ENDIF.

*&---------------------------------------------------------------------*
*&  END OF SELECTION
*&---------------------------------------------------------------------*
END-OF-SELECTION.
  IF rb1 = 'X'.
    LOOP AT it_sal INTO wa_sal.
      WRITE: / sy-vline,
               wa_sal-vbeln COLOR 1,
               sy-vline,
               wa_sal-erdat COLOR 2,
               sy-vline,
               wa_sal-ernam COLOR 3,
               sy-vline,
               wa_sal-posnr COLOR 4,
               sy-vline,
               wa_sal-matnr COLOR 5,
               sy-vline,
               wa_sal-matkl COLOR 6,
      sy-vline.
    ENDLOOP.
  ELSEIF rb2 = 'X'.
    LOOP AT it_sal INTO wa_sal.
      WRITE: / sy-vline,
            wa_sal-vbeln COLOR 1,
            wa_sal-erdat COLOR 2,
            wa_sal-ernam COLOR 3,
            wa_sal-posnr COLOR 4,
            wa_sal-matnr COLOR 5,
            wa_sal-matkl COLOR 6.
    ENDLOOP.
  ENDIF.


*&---------------------------------------------------------------------*
*&  TOP OF PAGE
*&---------------------------------------------------------------------*
TOP-OF-PAGE.
  WRITE: / 'Sales Order Data'.
  SKIP 1.
  WRITE: (84) sy-uline.

  WRITE: / sy-vline,
           text-001,
           sy-vline,
           text-002,
           sy-vline,
           text-003,
           sy-vline,
           text-004,
           sy-vline,
           text-005,
           sy-vline,
           text-006,
           sy-vline.

  WRITE: (84) sy-uline.

*&---------------------------------------------------------------------*
*&  END OF PAGE
*&---------------------------------------------------------------------*
END-OF-PAGE.
  WRITE: (84) sy-uline.
  WRITE: / 'Page Number', sy-pagno.
*&---------------------------------------------------------------------*
*&  SUBROUTINES
*&---------------------------------------------------------------------*