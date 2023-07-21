*&---------------------------------------------------------------------*
*&  Include           ZDEMO_REUSE_ALV_TOP
*&---------------------------------------------------------------------*

*DATA: BEGIN OF gt_list OCCURS 0,
*  ebeln LIKE ekko-ebeln,
*  ebelp LIKE ekpo-ebelp,
*  bstyp LIKE ekko-bstyp,
*  bsart LIKE ekko-bsart,
*  matnr LIKE ekpo-matnr,
*  menge LIKE ekpo-menge,
*  meins LIKE ekpo-meins,
*  statu LIKE ekpo-statu,
*END OF gt_list.

TYPES: BEGIN OF gty_list,
  selkz TYPE char1,
  ebeln TYPE ebeln,
  ebelp TYPE ebelp,
  bstyp TYPE ebstyp,
  bsart TYPE esart,
  matnr TYPE matnr,
  menge TYPE bstmg,
  meins TYPE meins,
  line_color TYPE char4,
  cell_color TYPE slis_t_specialcol_alv,
  END OF GTY_LIST.

  DATA: gs_cell_color TYPE slis_specialcol_alv.

  DATA: gt_list TYPE TABLE OF gty_list,
        gs_list TYPE GTY_LIST.

  DATA: gt_fieldcatalog TYPE slis_t_fieldcat_alv,
        gs_fieldcatalog TYPE slis_fieldcat_alv.

  DATA: gs_layout TYPE SLIS_LAYOUT_ALV.

  DATA: gt_events TYPE SLIS_T_EVENT,
        gs_event TYPE SLIS_ALV_EVENT.