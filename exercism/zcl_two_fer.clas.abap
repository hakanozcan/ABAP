CLASS zcl_two_fer DEFINITION PUBLIC.
    PUBLIC SECTION.
      METHODS two_fer
        IMPORTING
          input         TYPE string OPTIONAL
        RETURNING
          VALUE(result) TYPE string.
  ENDCLASS.
  CLASS zcl_two_fer IMPLEMENTATION.
    METHOD two_fer.
      IF input IS INITIAL.
        input = 'you'.
      ENDIF.
      result = |One for { input }, one for me.|.
    ENDMETHOD.
  ENDCLASS.

  " Iteration 2
  CLASS zcl_two_fer DEFINITION PUBLIC.
    PUBLIC SECTION.
      METHODS two_fer
        IMPORTING
          input         TYPE string OPTIONAL
        RETURNING
          VALUE(result) TYPE string.
  ENDCLASS.
  CLASS zcl_two_fer IMPLEMENTATION.
   METHOD two_fer.
       result = |One for { cond string( when input = '' then 'you' else input) }, one for me.|.
    ENDMETHOD.
  ENDCLASS.