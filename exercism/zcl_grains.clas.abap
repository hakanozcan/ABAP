CLASS zcl_grains DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    TYPES type_result TYPE p LENGTH 16 DECIMALS 0.
    METHODS square
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE type_result
      RAISING
        cx_parameter_invalid.
    METHODS total
      RETURNING
        VALUE(result) TYPE type_result
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.
CLASS zcl_grains IMPLEMENTATION.
  METHOD square.
    if input eq 0.
      raise exception type cx_parameter_invalid.
    elseif input < 0 or input > 64.
      raise exception type cx_parameter_invalid.
    else.
      result = 2 ** ( input - 1 ).
    endif.
  ENDMETHOD.
    
  METHOD total.
    result = ( 2 ** 64 ) - 1. 
  ENDMETHOD.
ENDCLASS.


"iteration 2

CLASS zcl_grains DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    TYPES type_result TYPE p LENGTH 16 DECIMALS 0.
    METHODS square
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE type_result
      RAISING
        cx_parameter_invalid.
    METHODS total
      RETURNING
        VALUE(result) TYPE type_result
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.
CLASS zcl_grains IMPLEMENTATION.
  METHOD square.
     if input between 1 and 64.
      result = 2 ** ( input - 1 ).
    else.
      raise exception type cx_parameter_invalid.
    endif.
  ENDMETHOD.
  METHOD total.    
result = reduce #( init x = 0 for i = 1 until i > 64 next x += me->square( i ) ).
  ENDMETHOD.
ENDCLASS.