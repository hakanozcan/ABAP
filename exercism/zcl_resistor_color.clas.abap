CLASS zcl_resistor_color DEFINITION PUBLIC CREATE PUBLIC.
    PUBLIC SECTION.
      METHODS resistor_color
        IMPORTING
          color_code   TYPE string
        RETURNING
          VALUE(value) TYPE i.
  ENDCLASS.
  CLASS zcl_resistor_color IMPLEMENTATION.
    METHOD resistor_color.
      DATA colors TYPE STANDARD TABLE OF string.
      colors = VALUE #(  ( `black` )
                         ( `brown` )
                         ( `red` )
                         ( `orange` )
                         ( `yellow` )
                         ( `green` )
                         ( `blue` )
                         ( `violet` )
                         ( `grey` )
                         ( `white` ) ).
      DATA(input) = to_lower( color_code ).
      LOOP AT colors ASSIGNING FIELD-SYMBOL(<color>).
        IF <color> EQ input.
          value = sy-tabix - 1.
          RETURN.
        ENDIF.
      ENDLOOP.
    ENDMETHOD.
  ENDCLASS.