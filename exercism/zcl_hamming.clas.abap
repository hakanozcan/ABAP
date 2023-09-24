CLASS zcl_hamming DEFINITION PUBLIC.
    PUBLIC SECTION.
      METHODS hamming_distance
        IMPORTING
          first_strand  TYPE string
          second_strand TYPE string
        RETURNING
          VALUE(result) TYPE i
        RAISING
          cx_parameter_invalid.
  ENDCLASS.
  
  CLASS zcl_hamming IMPLEMENTATION.
  
    METHOD hamming_distance.
      IF strlen( first_strand ) <> strlen( second_strand ).
        RAISE EXCEPTION TYPE cx_parameter_invalid.
      ENDIF.
      DO strlen( first_strand ) TIMES.
        IF substring( val = first_strand off = sy-index - 1 len = 1 ) <> substring( val = second_strand off = sy-index - 1 len = 1 ).
          result += 1.
        ENDIF.
      ENDDO.
    ENDMETHOD.
  
  ENDCLASS.
  