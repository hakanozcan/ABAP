*&---------------------------------------------------------------------*
*&  Include           ZDEMO_REUSE_ALV_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .
    SELECT
        ekko~ebeln
        ekpo~ebelp
        ekko~bstyp
        ekko~bsart
        ekpo~matnr
        ekpo~menge
        ekpo~meins
        FROM ekko
        INNER JOIN ekpo ON ekpo~ebeln EQ ekko~ebeln
        INTO CORRESPONDING FIELDS OF TABLE gt_list.
  
    LOOP AT gt_list INTO gs_list.
  
      IF gs_list-ebelp EQ '10'.
        CLEAR: gs_cell_color.
        gs_cell_color-fieldname = 'MATNR'.
        gs_cell_color-color-col = 5.
        gs_cell_color-color-int = 1.
        gs_cell_color-color-inv = 0.
        APPEND gs_cell_color TO gs_list-cell_color.
  
        CLEAR: gs_cell_color.
        gs_cell_color-fieldname = 'EBELP'.
        gs_cell_color-color-col = 7.
        gs_cell_color-color-int = 1.
        gs_cell_color-color-inv = 0.
        APPEND gs_cell_color TO gs_list-cell_color.
        MODIFY gt_list FROM gs_list.
      ENDIF.
  
  *    IF gs_list-ebelp EQ '20'.
  *      CLEAR: gs_cell_color.
  *      gs_cell_color-fieldname = 'BSTYP'.
  *      gs_cell_color-color-col = 6.
  *      gs_cell_color-color-int = 1.
  *      gs_cell_color-color-inv = 0.
  *      APPEND gs_cell_color TO gs_list-cell_color.
  *      MODIFY gt_list FROM gs_list.
  *    ENDIF.
  
  *    IF gs_list-ebelp EQ '10'.
  *      gs_list-line_color = 'C301'.
  *      MODIFY gt_list FROM gs_list.
      IF gs_list-ebelp EQ '20'.
        gs_list-line_color = 'C710'.
        MODIFY gt_list FROM gs_list.
  *    ELSEIF gs_list-ebelp EQ '30'.
  *      gs_list-line_color = 'C600'.
  *      MODIFY gt_list FROM gs_list.
      ENDIF.
  *    gs_list-line_color = 'C500'. "col renk, int koyuluk, inv text veya background rengi
  *    MODIFY gt_list FROM gs_list.
    ENDLOOP.
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  SET_FC
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM set_fc .
  
  *  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
  *    EXPORTING
  *      i_program_name   = sy-repid
  *      "I_INTERNAL_TABNAME           = 'GT_LIST'
  *      i_structure_name = 'ZDEMO_REUSEALV_S'
  *      i_inclname       = sy-repid
  *    CHANGING
  *      ct_fieldcat      = gt_fieldcatalog.
  
  
  
    PERFORM: set_fc_sub USING 'EBELN' 'SAS No' 'SAS Numarası' 'SAS Numarası' abap_true '0' '' 'X',
             set_fc_sub USING 'EBELP' 'Kalem' 'Kalem' 'Kalem' 'X' '1' '' '',
             set_fc_sub USING 'BSTYP' 'Belge Tipi' 'Belge Tipi' 'Belge Tipi' '' '2' '' '',
             set_fc_sub USING 'BSART' 'Belge Türü' 'Belge Türü' 'Belge Türü' '' '3' '' '',
             set_fc_sub USING 'MATNR' 'Malzeme' 'Malzeme' 'SAS Numarası' '' '4' '' 'X',
             set_fc_sub USING 'MENGE' 'Miktar' 'Miktar' 'Miktar' '' '5' 'X' '',
             set_fc_sub USING 'MEINS' 'ÖB' 'Ölçü Birimi' 'Ölçü Birimi' '' '6' '' ''.
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *&      Form  SET_FC_SUB
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  
  FORM set_fc_sub USING p_fieldname
                        p_seltext_s
                        p_seltext_m
                        p_seltext_l
                        p_key
                        p_col_pos
                        p_do_sum
                        p_hotspot.
    CLEAR: gs_fieldcatalog.
    gs_fieldcatalog-fieldname = p_fieldname.
    gs_fieldcatalog-seltext_s = p_seltext_s.
    gs_fieldcatalog-seltext_m = p_seltext_m.
    gs_fieldcatalog-seltext_l = p_seltext_l.
    gs_fieldcatalog-key = p_key.
    gs_fieldcatalog-col_pos = p_col_pos.
    gs_fieldcatalog-do_sum = p_do_sum.
    gs_fieldcatalog-hotspot = p_hotspot.
    APPEND gs_fieldcatalog TO gt_fieldcatalog.
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
    gs_layout-window_titlebar = 'REUSE ALV DENEME'.
    gs_layout-zebra = abap_true.
    gs_layout-colwidth_optimize = abap_true.
    gs_layout-box_fieldname = 'SELKZ'.
    gs_layout-info_fieldname = 'LINE_COLOR'.
    gs_layout-coltab_fieldname = 'CELL_COLOR'.
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  DISPLAY_ALV
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM display_alv .
  
    gs_event-name = slis_ev_top_of_page.
    gs_event-form = 'TOP_OF_PAGE'.
    APPEND gs_event TO gt_events.
  
    gs_event-name = slis_ev_end_of_list.
    gs_event-form = 'END_OF_LIST'.
    APPEND gs_event TO gt_events.
  
    gs_event-name = slis_ev_pf_status_set.
    gs_event-form = 'PF_STATUS_SET'.
    APPEND gs_event TO gt_events.
  
  
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
  *     I_INTERFACE_CHECK        = ' '
  *     I_BYPASSING_BUFFER       = ' '
  *     I_BUFFER_ACTIVE          = ' '
        i_callback_program       = sy-repid
        i_callback_pf_status_set = 'PF_STATUS_SET'
        i_callback_user_command  = 'USER_COMMAND'
  *     I_CALLBACK_TOP_OF_PAGE   = 'TOP'
  *     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
  *     I_CALLBACK_HTML_END_OF_LIST       = ' '
  *     I_STRUCTURE_NAME         =
  *     I_BACKGROUND_ID          = ' '
  *     I_GRID_TITLE             =
  *     I_GRID_SETTINGS          =
        is_layout                = gs_layout
        it_fieldcat              = gt_fieldcatalog
  *     IT_EXCLUDING             =
  *     IT_SPECIAL_GROUPS        =
  *     IT_SORT                  =
  *     IT_FILTER                =
  *     IS_SEL_HIDE              =
  *     I_DEFAULT                = 'X'
  *     I_SAVE                   = ' '
  *     IS_VARIANT               =
        it_events                = gt_events
  *     IT_EVENT_EXIT            =
  *     IS_PRINT                 =
  *     IS_REPREP_ID             =
  *     I_SCREEN_START_COLUMN    = 0
  *     I_SCREEN_START_LINE      = 0
  *     I_SCREEN_END_COLUMN      = 0
  *     I_SCREEN_END_LINE        = 0
  *     I_HTML_HEIGHT_TOP        = 0
  *     I_HTML_HEIGHT_END        = 0
  *     IT_ALV_GRAPHICS          =
  *     IT_HYPERLINK             =
  *     IT_ADD_FIELDCAT          =
  *     IT_EXCEPT_QINFO          =
  *     IR_SALV_FULLSCREEN_ADAPTER        =
  *       IMPORTING
  *     E_EXIT_CAUSED_BY_CALLER  =
  *     ES_EXIT_CAUSED_BY_USER   =
      TABLES
        t_outtab                 = gt_list
  *       EXCEPTIONS
  *     PROGRAM_ERROR            = 1
  *     OTHERS                   = 2
      .
    IF sy-subrc <> 0.
  * Implement suitable error handling here
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  TOP_OF_PAGE
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM top_of_page .
    DATA: lt_header TYPE slis_t_listheader,
          ls_header TYPE slis_listheader.
  
    DATA: lv_date TYPE char10.
    DATA: lv_lines   TYPE i,
          lv_lines_c TYPE char4.
  
  
    CLEAR: ls_header.
    ls_header-typ = 'H'.
    ls_header-info = 'Satınalma Sipariş Raporu'.
    APPEND ls_header TO lt_header.
  
    CLEAR: ls_header.
    ls_header-typ = 'S'.
    ls_header-key = 'Tarih: '.
  *  ls_header-info = '19.06.2023'.
    CONCATENATE sy-datum+6(2)
                '.'
                sy-datum+4(2)
                '.'
                sy-datum+0(4)
                INTO lv_date.
    ls_header-info = lv_date.
    APPEND ls_header TO lt_header.
  
    DESCRIBE TABLE gt_list LINES lv_lines.
    lv_lines_c = lv_lines.
  
    CLEAR: ls_header.
    ls_header-typ = 'A'.
  *  ls_header-info = 'Raporda 50 adet kalem vardır'.
    CONCATENATE 'Raporda'
                lv_lines_c
                'adet kalem vardır.'
    INTO ls_header-info
    SEPARATED BY space.
  
    APPEND ls_header TO lt_header.
  
  
    CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
      EXPORTING
        it_list_commentary = lt_header.
  
  ENDFORM.
  
  FORM end_of_page.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  PF_STATUS_SET
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM pf_status_set USING p_extab TYPE slis_t_extab .
    SET PF-STATUS '0200'.
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  USER_COMMAND
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM user_command USING p_ucomm TYPE sy-ucomm
                          ps_selfield TYPE slis_selfield .
  
    DATA: lv_mes TYPE char200,
          lv_ind TYPE numc2.
    CASE p_ucomm.
      WHEN '&MSG'.
        LOOP AT gt_list INTO gs_list WHERE selkz EQ 'X'.
          lv_ind = lv_ind + 1.
        ENDLOOP.
        CONCATENATE lv_ind
                    'satır seçilmiştir.'
        INTO lv_mes
        SEPARATED BY space.
        MESSAGE lv_mes TYPE 'I'.
      WHEN '&IC1'.
        CASE ps_selfield-fieldname.
          WHEN 'EBELN'.
            CONCATENATE ps_selfield-value
            'numaralı SAS tıklanmıştır.'
            INTO lv_mes
            SEPARATED BY space.
            MESSAGE lv_mes TYPE 'I'.
          WHEN 'MATNR'.
            CONCATENATE ps_selfield-value
            'numaralı malzeme tıklanmıştır.'
            INTO lv_mes
             SEPARATED BY space.
            MESSAGE lv_mes TYPE 'I'.
        ENDCASE.
  *    MESSAGE 'Çift tıklandı' TYPE 'I'.
    ENDCASE.
  ENDFORM.