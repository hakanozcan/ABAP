REPORT zdemo_ooalv_0002.

INCLUDE zdemo_ooalv_0002_top.
INCLUDE zdemo_ooalv_0002_pbo.
INCLUDE zdemo_ooalv_0002_pai.
INCLUDE zdemo_ooalv_0002_frm.
INCLUDE zdemo_ooalv_0002_cls.



START-OF-SELECTION.
  
  PERFORM get_data.
  PERFORM set_fcat.
  PERFORM set_layout.

  CALL SCREEN 0100.