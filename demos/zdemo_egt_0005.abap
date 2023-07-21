*&---------------------------------------------------------------------*
*& Report ZDEMO_EGT_0005
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEMO_EGT_0005.

*PARAMETERS: p_num TYPE int4.
*
*INITIALIZATION.
*  p_num = 12.
*
*AT SELECTION-SCREEN.
*  p_num = p_num + 1.
*
*START-OF-SELECTION.
*  WRITE 'START OF SELECTION'.
*END-OF-SELECTION.
*  WRITE 'END OF SELECTION'.

*DATA gv_num1 TYPE int4.
*DATA gv_num2 TYPE int4.
*DATA gv_num3 TYPE int4.
*
*INITIALIZATION.
*
*
*AT SELECTION-SCREEN.
*
*START-OF-SELECTION.
*  PERFORM sayiya_bir_ekle.
*  PERFORM sayiya_bir_ekle.
*  PERFORM sayiya_bir_ekle.
*  PERFORM sayiya_bir_ekle.
*  PERFORM sayiya_bir_ekle.
*  WRITE gv_num1.
*  PERFORM iki_sayinin_carpimi USING 10
*        5.
*  gv_num2 = 15.
*  gv_num3 = 6.
*  PERFORM iki_sayinin_farki USING gv_num2
*        gv_num3.
*END-OF-SELECTION.
*
*FORM sayiya_bir_ekle.
*  gv_num1 = gv_num1 + 1.
*ENDFORM.
*
*FORM iki_sayinin_carpimi USING p_num1
*      p_num2.
*  DATA: lv_sonuc TYPE int4.
*  lv_sonuc = p_num1 * p_num2.
*  WRITE: / 'Sonuc =', lv_sonuc.
*ENDFORM.
*
*FORM iki_sayinin_farki  USING    p_num2
*                                 p_num3.
*
*DATA: lv_sonuc TYPE int4.
*lv_sonuc = p_num2 - p_num3.
*WRITE: / 'Farkı =', lv_sonuc.
*
*ENDFORM.

INCLUDE ZDEMO_EGT_0005_TOP.
INCLUDE ZDEMO_EGT_0005_FRM.

START-OF-SELECTION.

  PERFORM form1.
  PERFORM form2.