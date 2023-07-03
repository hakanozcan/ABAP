*&---------------------------------------------------------------------*
*&  Include           ZDEMO_OOALV_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  DISPLAY_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM display_alv .
  *  CREATE OBJECT go_cont
  *    EXPORTING
  *      container_name = 'CC_ALV'.
  *
  *  CREATE OBJECT go_alv
  *    EXPORTING
  *      i_parent = go_cont.
  *
  *
  *  CALL METHOD go_alv->set_table_for_first_display
  *    EXPORTING
  *      i_structure_name = 'SCARR'
  *    CHANGING
  *      it_outtab        = gt_scarr.
    IF go_alv IS INITIAL.
      CREATE OBJECT go_alv
        EXPORTING
          i_parent = cl_gui_container=>screen0.
  
      PERFORM set_dropdown.
  
      CALL METHOD go_alv->set_table_for_first_display
        EXPORTING
  *       i_buffer_active =     " Buffering Active
  *       i_bypassing_buffer            =     " Switch Off Buffer
  *       i_consistency_check           =     " Starting Consistency Check for Interface Error Recognition
  *       i_structure_name = ''    " Internal Output Table Structure Name
  *       is_variant      =     " Layout
  *       i_save          =     " Save Layout
  *       i_default       = 'X'    " Default Display Variant
          is_layout       = gs_layout   " Layout
  *       is_print        =     " Print Control
  *       it_special_groups             =     " Field Groups
  *       it_toolbar_excluding          =     " Excluded Toolbar Standard Functions
  *       it_hyperlink    =     " Hyperlinks
  *       it_alv_graphics =     " Table of Structure DTC_S_TC
  *       it_except_qinfo =     " Table for Exception Quickinfo
  *       ir_salv_adapter =     " Interface ALV Adapter
        CHANGING
          it_outtab       = gt_scarr[]
          it_fieldcatalog = gt_fcat  " Field Catalog
  *       it_sort         =     " Sort Criteria
  *       it_filter       =     " Filter Criteria
  *    EXCEPTIONS
  *       invalid_parameter_combination = 1
  *       program_error   = 2
  *       too_many_lines  = 3
  *       others          = 4
        .
  
  *  CALL METHOD go_alv->register_edit_event
  *    EXPORTING
  *      i_event_id = cl_gui_alv_grid=>mc_evt_enter.
  
      CALL METHOD go_alv->register_edit_event
        EXPORTING
          i_event_id = cl_gui_alv_grid=>mc_evt_modified.
    ELSE.
      CALL METHOD go_alv->refresh_table_display.
    ENDIF.
  ENDFORM.
  
  
  *&---------------------------------------------------------------------*
  *&      Form  GET_DATA
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM get_data .
    SELECT * FROM scarr
        INTO CORRESPONDING FIELDS OF TABLE gt_scarr.
  
    LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
      CASE <gfs_scarr>-currcode.
        WHEN 'EUR'.
          <gfs_scarr>-dd_handle = '3'.
        WHEN 'USD'.
          <gfs_scarr>-dd_handle = '4'.
        WHEN 'JPY'.
          <gfs_scarr>-dd_handle = '5'.
      ENDCASE.
    ENDLOOP.
  
  *  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
  *    <gfs_scarr>-durum = '@11@'.
  *  ENDLOOP.
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  SET_FCAT
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM set_fcat .
    CLEAR: gs_fcat.
    gs_fcat-fieldname = 'DURUM'.
    gs_fcat-scrtext_s = 'Durum'.
    gs_fcat-scrtext_m = 'Durum'.
    gs_fcat-scrtext_l = 'Durum'.
  *  gs_fcat-col_pos = 2.
  *  gs_fcat-key = abap_true.
    APPEND gs_fcat TO gt_fcat.
  
    CLEAR: gs_fcat.
    gs_fcat-fieldname = 'CARRID'.
    gs_fcat-scrtext_s = 'Havayolu T.'.
    gs_fcat-scrtext_m = 'Havayolu Tanımı'.
    gs_fcat-scrtext_l = 'Havayolu Şirketinin Kısa Tanımı'.
  *  gs_fcat-col_pos = 2.
  *  gs_fcat-key = abap_true.
    APPEND gs_fcat TO gt_fcat.
  
    CLEAR: gs_fcat.
    gs_fcat-fieldname = 'CARRNAME'.
    gs_fcat-scrtext_s = 'H.Yolu Adı'.
    gs_fcat-scrtext_m = 'Havayolu Adı'.
    gs_fcat-scrtext_l = 'Havayolu Şirketinin Adı'.
  *  gs_fcat-col_pos = 3.
  *  gs_fcat-edit = abap_true.
    APPEND gs_fcat TO gt_fcat.
  
    CLEAR: gs_fcat.
    gs_fcat-fieldname = 'CURRCODE'.
    gs_fcat-scrtext_s = 'PB'.
    gs_fcat-scrtext_m = 'Havayolu PB'.
    gs_fcat-scrtext_l = 'Havayolu Para Birimi'.
  *  gs_fcat-col_pos = 4.
    APPEND gs_fcat TO gt_fcat.
  
    CLEAR: gs_fcat.
    gs_fcat-fieldname = 'URL'.
    gs_fcat-scrtext_s = 'URL'.
    gs_fcat-scrtext_m = 'Havayolu URL'.
    gs_fcat-scrtext_l = 'Havayolu Şirketi URL'.
  *  gs_fcat-col_pos = 1.
  *  gs_fcat-col_opt = abap_true.
  *  gs_fcat-hotspot = abap_true.
    gs_fcat-ref_table = 'SCARR'.
    gs_fcat-ref_field = 'URL'.
    APPEND gs_fcat TO gt_fcat.
  
    CLEAR: gs_fcat.
    gs_fcat-fieldname = 'COST'.
    gs_fcat-scrtext_s = 'Fiyat'.
    gs_fcat-scrtext_m = 'Fiyat'.
    gs_fcat-scrtext_l = 'Fiyat'.
    gs_fcat-edit = abap_true.
    APPEND gs_fcat TO gt_fcat.
  
    CLEAR: gs_fcat.
    gs_fcat-fieldname = 'LOCATION'.
    gs_fcat-scrtext_s = 'Lokasyon'.
    gs_fcat-scrtext_m = 'Lokasyon'.
    gs_fcat-scrtext_l = 'Lokasyon'.
    gs_fcat-edit = abap_true.
    gs_fcat-drdn_hndl = 1.
    APPEND gs_fcat TO gt_fcat.
  
    CLEAR: gs_fcat.
    gs_fcat-fieldname = 'SEATL'.
    gs_fcat-scrtext_s = 'Koltuk Harf'.
    gs_fcat-scrtext_m = 'Koltuk Harf'.
    gs_fcat-scrtext_l = 'Koltuk Harf'.
    gs_fcat-edit = abap_true.
    gs_fcat-drdn_hndl = 2.
    APPEND gs_fcat TO gt_fcat.
  
    CLEAR: gs_fcat.
    gs_fcat-fieldname = 'SEATP'.
    gs_fcat-scrtext_s = 'Koltuk Pos'.
    gs_fcat-scrtext_m = 'Koltuk Pos'.
    gs_fcat-scrtext_l = 'Koltuk Pos'.
    gs_fcat-edit = abap_true.
    gs_fcat-drdn_field = 'DD_HANDLE'.
    APPEND gs_fcat TO gt_fcat.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  SET_LAYOUT
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM set_layout .
    CLEAR: gs_layout.
    gs_layout-cwidth_opt = abap_true.
  *  gs_layout-edit = abap_true.
  *  gs_layout-no_toolbar = abap_true.
  *  gs_layout-zebra = abap_true.
  *  gs_layout-info_fname = 'LINE_COLOR'.
  *  gs_layout-ctab_fname = 'CELL_COLOR'.
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  GET_TOTAL_SUM
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM get_total_sum .
  *  DATA: lv_ttl_sum   TYPE int4,
  *        lv_mess      TYPE char200,
  *        lv_ttl_sum_c TYPE char20.
  *
  *  LOOP AT gt_scarr INTO gs_scarr.
  *    lv_ttl_sum = lv_ttl_sum + gs_scarr-cost.
  *  ENDLOOP.
  *
  *  lv_ttl_sum_c = lv_ttl_sum.
  *
  *  CONCATENATE 'Tüm satırların toplamı = '
  *              lv_ttl_sum_c
  *              INTO lv_mess.
  *
  *  MESSAGE lv_mess TYPE 'I'.
  
    DATA: lv_ttl_sum TYPE int4,
          lv_lines   TYPE int4,
          lv_avr     TYPE int4.
  
    LOOP AT gt_scarr INTO gs_scarr.
      lv_ttl_sum = lv_ttl_sum + gs_scarr-cost.
    ENDLOOP.
  
    DESCRIBE TABLE gt_scarr LINES lv_lines.
    lv_avr = lv_ttl_sum / lv_lines.
  
    LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
      IF <gfs_scarr>-cost > lv_avr.
        <gfs_scarr>-durum = '@08@'.
      ELSEIF <gfs_scarr>-cost < lv_avr.
        <gfs_scarr>-durum = '@0A@'.
      ELSE.
        <gfs_scarr>-durum = '@09@'.
      ENDIF.
    ENDLOOP.
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  SET_DROPDOWN
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM set_dropdown .
    DATA: lt_dropdown TYPE lvc_t_drop,
          ls_dropdown TYPE lvc_s_drop.
  
    CLEAR: ls_dropdown.
    ls_dropdown-handle = 1.
    ls_dropdown-value = 'Yurtiçi'.
    APPEND ls_dropdown TO lt_dropdown.
  
  
    CLEAR: ls_dropdown.
    ls_dropdown-handle = 1.
    ls_dropdown-value = 'Yurtdışı'.
    APPEND ls_dropdown TO lt_dropdown.
  
    CLEAR: ls_dropdown.
    ls_dropdown-handle = 2.
    ls_dropdown-value = 'A'.
    APPEND ls_dropdown TO lt_dropdown.
  
    CLEAR: ls_dropdown.
    ls_dropdown-handle = 2.
    ls_dropdown-value = 'B'.
    APPEND ls_dropdown TO lt_dropdown.
  
    CLEAR: ls_dropdown.
    ls_dropdown-handle = 2.
    ls_dropdown-value = 'C'.
    APPEND ls_dropdown TO lt_dropdown.
  
    CLEAR: ls_dropdown.
    ls_dropdown-handle = 2.
    ls_dropdown-value = 'D'.
    APPEND ls_dropdown TO lt_dropdown.
  
    CLEAR: ls_dropdown.
    ls_dropdown-handle = 2.
    ls_dropdown-value = 'E'.
    APPEND ls_dropdown TO lt_dropdown.
  
    CLEAR: ls_dropdown.
    ls_dropdown-handle = 3.
    ls_dropdown-value = 'Ön'.
    APPEND ls_dropdown TO lt_dropdown.
  
    CLEAR: ls_dropdown.
    ls_dropdown-handle = 3.
    ls_dropdown-value = 'Kanat'.
    APPEND ls_dropdown TO lt_dropdown.
  
    CLEAR: ls_dropdown.
    ls_dropdown-handle = 3.
    ls_dropdown-value = 'Arka'.
    APPEND ls_dropdown TO lt_dropdown.
  
    CLEAR: ls_dropdown.
    ls_dropdown-handle = 4.
    ls_dropdown-value = 'Ön'.
    APPEND ls_dropdown TO lt_dropdown.
  
    CLEAR: ls_dropdown.
    ls_dropdown-handle = 4.
    ls_dropdown-value = 'Arka'.
    APPEND ls_dropdown TO lt_dropdown.
  
    CLEAR: ls_dropdown.
    ls_dropdown-handle = 5.
    ls_dropdown-value = 'Kanat'.
    APPEND ls_dropdown TO lt_dropdown.
  
    go_alv->set_drop_down_table(
      EXPORTING
        it_drop_down       = lt_dropdown
    ).
  ENDFORM.