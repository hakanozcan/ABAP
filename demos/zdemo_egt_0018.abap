*&---------------------------------------------------------------------*
*& Report ZDEMO_EGT_0018
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEMO_EGT_0018.

DATA: gv_name    TYPE char20,
      gv_surname TYPE char30,
      gv_age     TYPE num4.
DATA: gv_flag TYPE xfeld.



START-OF-SELECTION.

  CALL SCREEN 0100.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.

  LOOP AT SCREEN.
    IF gv_flag eq abap_true.
      IF screen-group1 eq abap_true.
        screen-input = 1.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.

    IF gv_flag eq abap_false.
       IF screen-group1 eq abap_false.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.

*  LOOP AT SCREEN.
*    IF screen-group1 EQ 'X'.
*      screen-input = 0.
*      MODIFY SCREEN.
*    ENDIF.
*  ENDLOOP.

*  LOOP AT SCREEN.
*  IF screen-name eq 'GV_NAME'.
*    screen-active = 0.
*    MODIFY SCREEN.
*  ENDIF.
*
*  IF screen-name eq 'GV_SURNAME'.
*    screen-invisible = 1.
*    MODIFY SCREEN.
*  ENDIF.
*
*  IF screen-name eq 'GV_AGE'.
*    screen-input = 0.
*    MODIFY SCREEN.
*  ENDIF.
*  ENDLOOP.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN '&BACK'.
      SET SCREEN 0.
    WHEN '&ENABLE'.
      gv_flag = abap_true. " X
    WHEN '&DISABLE'.
      gv_flag = abap_false. " ''
  ENDCASE.
ENDMODULE.