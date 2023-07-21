*&---------------------------------------------------------------------*
*& Report ZDEMO_EGT_0010
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEMO_EGT_0010 MESSAGE-ID zegt.

START-OF-SELECTION.

*MESSAGE 'Hello Abap!' TYPE 'S'.
*MESSAGE 'Hello Abap!' TYPE 'I'.
*MESSAGE 'Hello Abap!' TYPE 'W'.
*MESSAGE 'Hello Abap!' TYPE 'E'.
*MESSAGE 'Hello Abap!' TYPE 'A'.
*MESSAGE 'Hello Abap!' TYPE 'x'.


*MESSAGE 'Hello Abap!' TYPE 'S' DISPLAY LIKE 'W'.
*MESSAGE 'Hello Abap!' TYPE 'W'.
*MESSAGE 'Hello Abap!' TYPE 'E'.
*MESSAGE 'Hello Abap!' TYPE 'A'.
*MESSAGE 'Hello Abap!' TYPE 'x'.

*MESSAGE text-000 TYPE 'I'.

* MESSAGE: i000.
*MESSAGE: i001 WITH 'Pazar'.

DATA: lv_gun TYPE char20.
lv_gun = 'Perşembe'.
*MESSAGE i002 WITH 'Çarşamba' 'Perşembe'.
MESSAGE i002 WITH 'Çarşamba' lv_gun.

  WRITE: 'Message'.