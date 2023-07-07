*&---------------------------------------------------------------------*
*& Report ZDEMO_OGRENCI_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT zdemo_ogrenci_alv.
TYPE-POOLS: slis.
TABLES: zdemo_ogrenci.
DATA: go_alv TYPE REF TO cl_gui_alv_grid.

DATA: gt_ogrenci      TYPE TABLE OF zdemo_ogrenci,
      gt_fieldcatalog TYPE lvc_t_fcat,
      gs_fieldcatalog TYPE lvc_s_fcat,
      gs_layout       TYPE lvc_s_layo.

DATA: gs_ogrenci TYPE zdemo_ogrenci,
      gv_last_id TYPE zdemo_ogrid_de.

INCLUDE zdemo_ogrenci_alv_frm.



SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.  "RADIO BUTTON - INSERT & UPDATE
PARAMETERS: rb_in RADIOBUTTON GROUP rb1 USER-COMMAND c1 DEFAULT 'X' MODIF ID b1,
            rb_up RADIOBUTTON GROUP rb1 MODIF ID b1.
SELECTION-SCREEN: END OF BLOCK b1.

SELECTION-SCREEN: BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002. "INSERT BLOCK
PARAMETERS: p_id    TYPE zdemo_ogrid_de MODIF ID b2i,
            p_ad    TYPE zdemo_ograd_de MODIF ID b2,
            p_soyad TYPE zdemo_ogrsoyad_de MODIF ID b2,
            p_bolum TYPE zdemo_ogrbolum_de MODIF ID b2,
            p_dt    TYPE zdemo_ogrdt_de MODIF ID b2.
SELECTION-SCREEN: END OF BLOCK b2.


SELECTION-SCREEN: BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003. "UPDATE BLOCK: ÖĞRENCİ ID
PARAMETERS: p_u_id TYPE zdemo_ogrid_de MODIF ID b3.
SELECTION-SCREEN: END OF BLOCK b3.

SELECTION-SCREEN: BEGIN OF BLOCK b4 WITH FRAME TITLE TEXT-004. "UPDATE BLOCK
PARAMETERS: p_u_ad  TYPE zdemo_ograd_de MODIF ID b4,
            p_u_sy  TYPE zdemo_ogrsoyad_de MODIF ID b4,
            p_u_blm TYPE zdemo_ogrbolum_de MODIF ID b4,
            p_u_dt  TYPE zdemo_ogrdt_de MODIF ID b4.
SELECTION-SCREEN: END OF BLOCK b4.

INITIALIZATION.
  SELECT MAX( ogr_id ) FROM zdemo_ogrenci INTO gv_last_id .  "TABLODAKİ SON ID
  IF sy-subrc EQ 0.
    p_id = gv_last_id + 1.
  ELSE.
  ENDIF.

  SELECTION-SCREEN:
      PUSHBUTTON 2(10) button1 USER-COMMAND but1,
      PUSHBUTTON 15(10) button2 USER-COMMAND but2.

INITIALIZATION.
  button1 = 'ALV Göster'.
  button2 = 'Kaydet'.

AT SELECTION-SCREEN.
  PERFORM get_data.
  CASE sy-dynnr.
    WHEN 1000.
      CASE sy-ucomm.
        WHEN 'BUT1'.
          PERFORM display_alv.

      ENDCASE.
  ENDCASE.

AT SELECTION-SCREEN OUTPUT.
  IF rb_in EQ 'X' .    "INSERT SEÇİLİRSE
    CLEAR: p_u_id.
    LOOP AT SCREEN.
      IF screen-group1 = 'B3' OR screen-group1 = 'B4'.
        screen-active = 0.
      ELSEIF screen-group1 = 'B2I'.
        screen-input = 0.
      ELSE.
        screen-active = 1.
      ENDIF.
      MODIFY SCREEN.
    ENDLOOP.

  ELSEIF rb_up EQ 'X' AND p_u_id IS INITIAL.
    LOOP AT SCREEN.
      IF screen-group1 = 'B2' OR screen-group1 = 'B2I' OR screen-group1 = 'B4'.
        screen-active = 0.
      ELSE.
        screen-active = 1.
      ENDIF.
      MODIFY SCREEN.
    ENDLOOP.

  ELSEIF rb_up EQ 'X' AND p_u_id IS NOT INITIAL.
    SELECT SINGLE *
    FROM zdemo_ogrenci
    INTO gs_ogrenci
    WHERE ogr_id = p_u_id.

    IF sy-subrc EQ 0.
      LOOP AT SCREEN.
        IF screen-group1 = 'B2' OR screen-group1 = 'B2I'.
          screen-active = 0.
        ELSE.
          screen-active = 1.
        ENDIF.
        MODIFY SCREEN.
      ENDLOOP.

      p_u_ad = gs_ogrenci-ogr_ad.
      p_u_sy = gs_ogrenci-ogr_soyad .
      p_u_blm = gs_ogrenci-ogr_bolum.
      p_u_dt = gs_ogrenci-ogr_dt.
    ELSE.
      MESSAGE 'Hatalı ID' TYPE 'S' DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDIF.




START-OF-SELECTION.


  IF rb_up EQ 'X'.    "UPDATE
    gs_ogrenci-ogr_ad = p_u_ad.
    gs_ogrenci-ogr_soyad = p_u_sy.
    gs_ogrenci-ogr_bolum = p_u_blm.
    gs_ogrenci-ogr_dt = p_u_dt.

    UPDATE zdemo_ogrenci FROM gs_ogrenci .
    IF sy-subrc EQ 0.
      MESSAGE 'Kayıt güncellendi' TYPE 'S'.
    ELSE.
      MESSAGE 'Kayıt güncellenemedi' TYPE 'E'.
    ENDIF.
  ELSE.                "INSERT
    CLEAR: gs_ogrenci.
    gs_ogrenci-mandt       = sy-mandt.
    gs_ogrenci-ogr_id      = p_id.
    gs_ogrenci-ogr_ad    = p_ad.
    gs_ogrenci-ogr_soyad = p_soyad.
    gs_ogrenci-ogr_bolum   = p_bolum.
    gs_ogrenci-ogr_dt    = p_dt.
    gs_ogrenci-ogr_os = sy-timlo.
    gs_ogrenci-ogr_ot = sy-datum.

    INSERT zdemo_ogrenci FROM gs_ogrenci.
    IF sy-subrc EQ 0.
      MESSAGE 'Kayıt eklendi' TYPE 'S'.
    ELSE.
      MESSAGE 'Kayıt eklenemedi' TYPE 'E'.
    ENDIF.
    CLEAR: gs_ogrenci.
  ENDIF.