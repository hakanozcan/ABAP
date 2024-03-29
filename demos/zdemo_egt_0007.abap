*&---------------------------------------------------------------------*
*& Report ZDEMO_EGT_0007
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEMO_EGT_0007.

DATA: go_egitim_class TYPE REF TO z_cl_egitim_class.
DATA: gv_num1   TYPE int4,
      gv_num2   TYPE int4,
      gv_result TYPE int4.


START-OF-SELECTION.

  CREATE OBJECT go_egitim_class.

  gv_num1 = 12.
  gv_num2 = 15.

  go_egitim_class->sum_numbers(
    EXPORTING
      iv_num1   =                  gv_num1
      iv_num2   =                  gv_num2
    IMPORTING
      ev_result =                  gv_result
  ).

  WRITE: gv_result.

* z_cl_egitim_class=>sum_numbers_v2().