
FORM get_data .
  SELECT * FROM zdemo_ogrenci
    INTO CORRESPONDING FIELDS OF TABLE gt_ogrenci.
ENDFORM.

FORM set_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'OGR_ID'.
  gs_fieldcatalog-scrtext_s = 'Id'.
  gs_fieldcatalog-scrtext_m = 'Öğrenci Id'.
  gs_fieldcatalog-scrtext_l = 'Öğrenci Id'.
  gs_fieldcatalog-key = abap_true.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'OGR_AD'.
  gs_fieldcatalog-scrtext_s = 'Ad'.
  gs_fieldcatalog-scrtext_m = 'Öğrenci Adı'.
  gs_fieldcatalog-scrtext_l = 'Öğrenci Adı'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'OGR_SOYAD'.
  gs_fieldcatalog-scrtext_s = 'Soyad'.
  gs_fieldcatalog-scrtext_m = 'Öğrenci Soyadı'.
  gs_fieldcatalog-scrtext_l = 'Öğrenci Soyadı'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'OGR_BOLUM'.
  gs_fieldcatalog-scrtext_s = 'Bölüm'.
  gs_fieldcatalog-scrtext_m = 'Öğrenci Bölüm'.
  gs_fieldcatalog-scrtext_l = 'Öğrenci Bölüm'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'OGR_DT'.
  gs_fieldcatalog-scrtext_s = 'DT'.
  gs_fieldcatalog-scrtext_m = 'D. Tarihi'.
  gs_fieldcatalog-scrtext_l = 'Doğum Tarihi'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'OGR_OS'.
  gs_fieldcatalog-scrtext_s = 'OS'.
  gs_fieldcatalog-scrtext_m = 'Oluşturma Saati'.
  gs_fieldcatalog-scrtext_l = 'Oluşturma Saati'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'OGR_OT'.
  gs_fieldcatalog-scrtext_s = 'OT'.
  gs_fieldcatalog-scrtext_m = 'Oluşturma Tarihi'.
  gs_fieldcatalog-scrtext_l = 'Oluşturma Tarihi'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

ENDFORM.

FORM display_alv .

  PERFORM: set_fieldcatalog.
  PERFORM: set_layout.

  CREATE OBJECT go_alv
    EXPORTING
      i_parent = cl_gui_container=>screen0.

  CALL METHOD go_alv->set_table_for_first_display
    EXPORTING
      is_layout       = gs_layout  " Layout
    CHANGING
      it_outtab       = gt_ogrenci   " Output Table
      it_fieldcatalog = gt_fieldcatalog.  " Field Catalog

ENDFORM.

FORM set_layout .
  CLEAR: gs_layout.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-zebra = abap_true.
ENDFORM.


FORM excel.
  TRY .

*  READ TABLE
      SELECT * FROM zdemo_ogrenci INTO TABLE @DATA(it_ogrenci).

      DATA: it_columns TYPE if_fdt_doc_spreadsheet=>t_column.
      DATA: lv_header TYPE zdemo_ogrenci.
      DATA(o_desc) = CAST cl_abap_structdescr( cl_abap_structdescr=>describe_by_data( lv_header ) ).

*HEADER

      LOOP AT o_desc->get_components( ) ASSIGNING FIELD-SYMBOL(<c>).
        IF <c>  IS ASSIGNED.
          IF <c>-type->kind = cl_abap_structdescr=>kind_elem.
            APPEND VALUE #( id = sy-tabix
            name = <c>-name
            display_name = <c>-name
            is_result = abap_true
            type = <c>-type  ) TO it_columns.
          ENDIF.
        ENDIF.
      ENDLOOP.

*  HEADER + ITAB DATA -> XML
      DATA(lv_bin_data) = cl_fdt_xl_spreadsheet=>if_fdt_doc_spreadsheet~create_document( columns = it_columns
      itab = REF #( it_ogrenci )
      iv_call_type = if_fdt_doc_spreadsheet=>gc_call_dec_table ) .

* FILE DIALOG SAVE
      IF xstrlen( lv_bin_data ) > 0.
        DATA: lv_action   TYPE i,
              lv_filename TYPE string,
              lv_fullpath TYPE string,
              lv_path     TYPE string.

        cl_gui_frontend_services=>file_save_dialog( EXPORTING
          default_file_name = 'Ogrenci_Bilgileri'
          default_extension = 'xlsx'
          file_filter = |Excel-File (*.xlsx)\|*.xlsx\|{ cl_gui_frontend_services=>filetype_all }|
          CHANGING
            filename = lv_filename
            path = lv_path
            fullpath = lv_fullpath
            user_action = lv_action ).

*XSTRING
        IF lv_action EQ cl_gui_frontend_services=>action_ok.
          DATA(it_raw_data) = cl_bcs_convert=>xstring_to_solix( EXPORTING iv_xstring = lv_bin_data ).

* GUI DOWNLOAD
          cl_gui_frontend_services=>gui_download( EXPORTING
            filename = lv_fullpath
            filetype = 'BIN'
            bin_filesize = xstrlen( lv_bin_data )
            CHANGING
              data_tab = it_raw_data ).
        ENDIF.
      ENDIF.

    CATCH cx_root INTO DATA(e_text).
      MESSAGE e_text->get_text( ) TYPE 'I'.

  ENDTRY.
ENDFORM.