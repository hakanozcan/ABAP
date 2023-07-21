*&---------------------------------------------------------------------*
*& Report ZDEMO_EGT_0002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEMO_EGT_0002.

*DATA gv_degs1 TYPE i.
*DATA gv_degs2 TYPE n LENGTH 10.

DATA: gv_degs1 TYPE i,
      gv_degs2 TYPE n LENGTH 10,
      gv_sonuc TYPE i,
      gv_metin TYPE string.

gv_degs1 = 0.
gv_degs2 = 164.

*WRITE gv_degs1.
*WRITE / gv_degs2.

*gv_metin = 'Toplam = '.
*
*gv_sonuc = gv_degs1 + gv_degs2.
*WRITE: gv_metin, gv_sonuc.
*
*gv_sonuc = gv_degs1 - gv_degs2.
*WRITE: / 'Farkı =', gv_sonuc.
*
*gv_sonuc = gv_degs1 * gv_degs2.
*WRITE: / 'Çarpımı =', gv_sonuc.
*
*gv_sonuc = gv_degs1 / gv_degs2.
*WRITE: / 'Bölümü =', gv_sonuc.

*IF gv_degs1 > gv_degs2.
*  WRITE: 'Birinci sayı büyüktür!'.
*ENDIF.
*
*IF gv_degs1 < gv_degs2.
*  WRITE: 'İkinci sayı büyüktür!'.
*ENDIF.
*
*IF gv_degs1 = gv_degs2.
*  WRITE: 'İki sayı eşittir'.
*ENDIF.

*IF gv_degs1 > gv_degs2.
*    WRITE: 'Birinci sayı büyüktür!'.
*  ELSEIF gv_degs1 < gv_degs2.
*    WRITE: 'İkinci sayı büyüktür!'.
*   ELSE.
*     WRITE: 'İki sayı eşittir'.
*ENDIF.

*CASE gv_degs1.
*  WHEN 1.
*    WRITE: 'Değişken değerim 1'.
*  WHEN 2.
*    WRITE: 'Değişken değerim 2'.
*  WHEN 3.
*    WRITE: 'Değişken değerim 3'.
*  WHEN 4.
*    WRITE: 'Değişken değerim 4'.
*  WHEN 5.
*    WRITE: 'Değişken değerim 5'.
*  WHEN OTHERS.
*    WRITE: 'Hiçbir değere eşit değildir'.
*ENDCASE.


*DO 10 TIMES.
*  gv_degs1 = gv_degs1 + 1.
*  WRITE: / gv_degs1, 'Do döngüsü'.
*ENDDO.

WHILE gv_degs1 < 10.
  gv_degs1 = gv_degs1 + 1.
  WRITE: / gv_degs1, 'While döngüsü'.
ENDWHILE.