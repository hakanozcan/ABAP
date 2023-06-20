REPORT ZDEMO_REUSEALV.

INCLUDE zdemo_reuse_alv_top.
INCLUDE zdemo_reuse_alv_frm.


  START-OF-SELECTION.

  PERFORM get_data.
  PERFORM set_fc.
  PERFORM set_layout.
  PERFORM display_alv.