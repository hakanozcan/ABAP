*&---------------------------------------------------------------------*
*& Report Z_ITAB_TO_XLSX
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_itab_to_xlsx.


TRY .
*  READ TABLE
    SELECT * FROM sflight INTO TABLE @DATA(it_sflight).

*HEADER
    DATA: it_columns TYPE if_fdt_doc_spreadsheet=>t_column.
    DATA: lv_header TYPE sflight.
    DATA(o_desc) = CAST cl_abap_structdescr( cl_abap_structdescr=>describe_by_data( lv_header ) ).

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
itab = REF #( it_sflight )
iv_call_type = if_fdt_doc_spreadsheet=>gc_call_dec_table ) .

* FILE DIALOG SAVE
    if xstrlen( lv_bin_data ) > 0.
      DATA: lv_action TYPE i,
            lv_filename TYPE string,
            lv_fullpath TYPE string,
            lv_path TYPE string.

      cl_gui_frontend_services=>file_save_dialog( EXPORTING
        default_file_name = 'ITAB_Export'
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