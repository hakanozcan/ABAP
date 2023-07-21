*&---------------------------------------------------------------------*
*& Report ZDEMO_EGT_0003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEMO_EGT_0003.

DATA: gv_persid    TYPE zbk_persi_de,
      gv_persad    TYPE zbk_perad_de,
      gv_perssoyad TYPE zbk_perssoyad_de,
      gv_perscins  TYPE zbk_perscins_de,
      gs_pers_t    TYPE zbk_pers_t,
      gt_pers_t    TYPE TABLE OF zbk_pers_t.

*SELECT * FROM zbk_pers_t
*  INTO TABLE gt_pers_t
*  WHERE pers_id EQ 1.
*
*SELECT SINGLE * FROM zbk_pers_t
*  INTO gs_pers_t.
*
*SELECT SINGLE pers_id FROM zbk_pers_t
*  INTO gv_persid.
*
*  UPDATE zbk_pers_t SET pers_ad = 'AHMET'
*  WHERE pers_id EQ 1.
*
*  WRITE: 'Update çalıştırıldı'.

*gs_pers_t-pers_id = 3.
*gs_pers_t-pers_ad ='FURKAN'.
*gs_pers_t-pers_doyad ='SOYLEMEZ'.
*gs_pers_t-pers_cins ='E'.
*INSERT zbk_pers_t FROM gs_pers_t.
*
*WRITE: 'Insert komutu çalıştırıldı!'.

*DELETE FROM zbk_pers_t WHERE pers_id EQ 3.
*
*WRITE: 'Delete çalıştırıldı'.

*Key ile bir satır varsa update olarak çalışır. Key ile bir satır yoksa insert olarak çalışır.


*gs_pers_t-pers_id = 2.
*GS_PERS_T-PERS_AD ='GÜLÇİN'.
*GS_PERS_T-PERS_DOYAD ='SOYLEMEZ'.
*GS_PERS_T-PERS_CINS ='K'.
*
*MODIFY zbk_pers_t FROM gs_pers_t.
*
*WRITE: 'Modify çalıştırldı'.