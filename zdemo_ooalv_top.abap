*&---------------------------------------------------------------------*
*&  Include           ZDEMO_OOALV_TOP
*&---------------------------------------------------------------------*

TABLES: scarr.

DATA: go_alv TYPE REF TO cl_gui_alv_grid.
*      go_cont TYPE REF TO cl_gui_custom_container.

*DATA: BEGIN OF gt_scarr OCCURS 0,
*        carrid   TYPE scarr-carrid,
*        carrname TYPE scarr-carrname,
*        currcode TYPE scarr-currcode,
*        url      TYPE scarr-url,
*
*      END OF gt_scarr.

TYPES: BEGIN OF gty_scarr,
         carrid   TYPE s_carr_id,
         carrname TYPE s_carrname,
         currcode TYPE s_currcode,
         url      TYPE   s_carrurl,
         cost     TYPE int4,
       END OF gty_scarr.

DATA: gs_cell_color TYPE lvc_s_scol.


DATA:    gt_scarr  TYPE TABLE OF gty_scarr,
         gs_scarr  TYPE gty_scarr,
         gt_fcat   TYPE lvc_t_fcat,
         gs_fcat   TYPE lvc_s_fcat,
         gs_layout TYPE lvc_s_layo.

FIELD-SYMBOLS: <gfs_fc>    TYPE lvc_s_fcat,
               <gfs_scarr> TYPE gty_scarr.