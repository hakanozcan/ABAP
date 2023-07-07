
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