REPORT zdemo_hozcan_0002.


DATA: gt_list       TYPE TABLE OF zdemo_emp_001,
      gt_return_tab TYPE TABLE OF ddshretval,
      gt_mapping    TYPE TABLE OF dselc,
      gs_mapping    TYPE dselc.

PARAMETERS: p_id   TYPE char10,
            p_name TYPE char30,
            p_age  TYPE numc3.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_id.

  SELECT * FROM zdemo_emp_001 INTO CORRESPONDING FIELDS OF TABLE gt_list.

    gs_mapping-fldname = 'F0002'.
    gs_mapping-dyfldname = 'P_ID'.
    APPEND gs_mapping TO gt_mapping.

    gs_mapping-fldname = 'F0003'.
    gs_mapping-dyfldname = 'P_NAME'.
    APPEND gs_mapping TO gt_mapping.

    gs_mapping-fldname = 'F0004'.
    gs_mapping-dyfldname = 'P_AGE'.
    APPEND gs_mapping TO gt_mapping.

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield        = 'EMP_ID'
      dynpprog        = sy-repid
      dynpnr          = sy-dynnr
      dynprofield     = 'P_ID'
      value_org       = 'S'
    TABLES
      value_tab       = gt_list
      return_tab      = gt_return_tab
*     DYNPFLD_MAPPING = gt_mapping
    EXCEPTIONS
      parameter_error = 1
      no_values_found = 2
      OTHERS          = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


START-OF-SELECTION.