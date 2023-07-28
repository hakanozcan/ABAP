CLASS zcl_clock DEFINITION PUBLIC CREATE PUBLIC.
    PUBLIC SECTION.
      METHODS constructor
        IMPORTING
          !hours   TYPE i
          !minutes TYPE i DEFAULT 0.
      METHODS get
        RETURNING
          VALUE(result) TYPE string.
      METHODS add
        IMPORTING
          !minutes TYPE i.
      METHODS sub
        IMPORTING
          !minutes TYPE i.
    PRIVATE SECTION.
      DATA time TYPE t.
  ENDCLASS.
  CLASS zcl_clock IMPLEMENTATION.
    METHOD add.
      time = time + minutes * 60.
    ENDMETHOD.
    METHOD constructor.
      add( hours * 60 ).
      add( minutes ).
    ENDMETHOD.
    METHOD get.
      result = |{ time+0(2) }:{ time+2(2) }|.
    ENDMETHOD.
    METHOD sub.
      time = time - minutes * 60.
    ENDMETHOD.
  ENDCLASS.
