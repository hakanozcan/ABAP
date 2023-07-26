CLASS zcl_high_scores DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS constructor
      IMPORTING
        scores TYPE integertab.
    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.
    METHODS latest
      RETURNING
        VALUE(result) TYPE i.
    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.
    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA scores_list TYPE integertab.
ENDCLASS.
CLASS zcl_high_scores IMPLEMENTATION.
  METHOD constructor.
    me->scores_list = scores.
  ENDMETHOD.
  METHOD list_scores.
    result = me->scores_list.
  ENDMETHOD.
  METHOD latest.
    describe table me->scores_list lines data(lv_lines).
    result = me->scores_list[ lv_lines ]. 
  ENDMETHOD.
  METHOD personalbest.
    DATA: lv_i type i,
          lt_score type integertab.
          lt_score = me->scores_list.
          Sort lt_score descending.
          result = lt_Score[ 1 ].
  ENDMETHOD.
  METHOD personaltopthree.
    DATA: lv_i type i value 1,
          lt_score type integertab.
          lt_score = me->scores_list.
          Sort lt_score descending.
    do lines( lt_score ) times.
      result = value #( Base result ( lt_score[ lv_i ] ) ).
      if sy-index = 3.
      exit.
      endif.
      lv_i += 1.
    enddo.
  ENDMETHOD.
ENDCLASS.