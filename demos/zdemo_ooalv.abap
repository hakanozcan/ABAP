REPORT zdemo_ooalv.

INCLUDE zdemo_ooalv_top.
INCLUDE zdemo_ooalv_pbo.
INCLUDE zdemo_ooalv_pai.
INCLUDE zdemo_ooalv_frm.

START-OF-SELECTION.

  PERFORM: get_data.
  PERFORM: set_fcat.
  PERFORM: set_layout.


  CALL SCREEN 0100.