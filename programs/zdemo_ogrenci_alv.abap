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




*DATA: gr_table TYPE REF TO cl_salv_table.
*
*DATA: gv_xstring      TYPE xstring,
*      gv_xlen         TYPE int4,
*      gt_binary_table TYPE solix_tab,
*      gr_request      TYPE REF TO cl_bcs,
*      gv_body_text    TYPE bcsy_text,
*      gv_subject      TYPE so_obj_des,
*      gr_recipient    TYPE REF TO if_recipient_bcs,
*      gr_document     TYPE REF TO cl_document_bcs,
*      gv_size         TYPE so_obj_len.

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
      PUSHBUTTON 15(10) button2 USER-COMMAND but2,
      PUSHBUTTON 28(15) button3 USER-COMMAND but3.


INITIALIZATION.
  button1 = 'ALV Göster'.
  button2 = 'Kaydet'.
  button3 = 'Excel Export'.


AT SELECTION-SCREEN.


  PERFORM get_data.
  CASE sy-dynnr.
    WHEN 1000.
      CASE sy-ucomm.
        WHEN 'BUT1'.
          PERFORM display_alv.
        WHEN 'BUT2'.
          PERFORM save.
        WHEN 'BUT3'.
          PERFORM excel.
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



*&---------------------------------------------------------------------*
*&      Form  SAVE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM save .
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
ENDFORM.





FORM mail.
  PERFORM get_data.
  TRY.
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table   =  gr_table                         " Basis Class Simple ALV Tables
        CHANGING
          t_table        = gt_ogrenci
      ).
    CATCH cx_salv_msg. " ALV: General Error Class with Message
  ENDTRY.

  TRY.

      gv_xstring = gr_table->to_xml( if_salv_bs_xml=>c_type_xlsx ).

      CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
        EXPORTING
          buffer        = gv_xstring
        IMPORTING
          output_length = gv_xlen
        TABLES
          binary_tab    = gt_binary_table.

      gr_request = cl_bcs=>create_persistent( ).

      APPEND 'Sample body text' TO gv_body_text.
      gv_subject = 'Sample subject'.
      gr_document = cl_document_bcs=>create_document(
                      i_type         = 'RAW'
                      i_subject      = gv_subject
                      i_text         = gv_body_text

                    ).
      gv_size = gv_xlen.
      gr_document->add_attachment(
          i_attachment_type     =   'EXT'               " Document Class for Attachment
          i_attachment_subject  =       gv_subject && '.xlsx'           " Attachment Title
          i_attachment_size     = gv_size                 " Size of Document Content
          i_att_content_hex     =       gt_binary_table           " Content (Binary)
      ).
      gr_request->set_document( gr_document ).

      gr_recipient = cl_cam_address_bcs=>create_internet_address( 'hakanozcan20@hotmail.com.tr' ).
      gr_request->add_recipient( gr_recipient ).
      gr_request->send( ).
      MESSAGE 'E-mail gönderildi' TYPE 'S'.
    CATCH cx_bcs.
      MESSAGE 'E-Mail gönderilemedi.' TYPE 'A'.
  ENDTRY.
ENDFORM.