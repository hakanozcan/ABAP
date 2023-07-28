CLASS zcl_kindergarten_garden DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS plants
      IMPORTING
        diagram        TYPE string
        student        TYPE string
      RETURNING
        VALUE(results) TYPE string_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA students TYPE string_table.
    METHODS check_plant_type
      IMPORTING
        plant_id       TYPE string
      RETURNING
        VALUE(results) TYPE string.
ENDCLASS.
CLASS zcl_kindergarten_garden IMPLEMENTATION.
  METHOD plants.
    students = VALUE #(
      ( `Alice` )
      ( `Bob` )
      ( `Charlie` )
      ( `David` )
      ( `Eve` )
      ( `Fred` )
      ( `Ginny` )
      ( `Harriet` )
      ( `Ileana` )
      ( `Joseph` )
      ( `Kincaid` )
      ( `Larry` )
    ).
    READ TABLE students WITH TABLE KEY table_line = student TRANSPORTING NO FIELDS.
    DATA(first_offset) = sy-tabix.
    DATA(second_offset)  = first_offset * 2.
    IF second_offset = 0.
      second_offset += 1.
    ELSE.
      second_offset -= 1.
      first_offset = second_offset - 1.
    ENDIF.
    SPLIT diagram AT `\n` INTO DATA(first_line) DATA(second_line).
    DATA(first_plant) = first_line+first_offset(1).
    DATA(second_plant) = first_line+second_offset(1).
    DATA(third_plant) = second_line+first_offset(1).
    DATA(fourth_plant) = second_line+second_offset(1).
    results = VALUE #(
        ( check_plant_type( first_plant ) )
        ( check_plant_type( second_plant ) )
        ( check_plant_type( third_plant ) )
        ( check_plant_type( fourth_plant ) )
    ).
  ENDMETHOD.
  METHOD check_plant_type.
    CASE plant_id.
      WHEN 'V'.
        results = 'violets'.
      WHEN 'G'.
        results = 'grass'.
      WHEN 'C'.
        results = 'clover'.
      WHEN 'R'.
        results = 'radishes'.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

"Iteration 2

CLASS zcl_kindergarten_garden DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS constructor.
    METHODS plants
      IMPORTING
        diagram        TYPE string
        student        TYPE string
      RETURNING
        VALUE(results) TYPE string_table.
    METHODS convert2name
      IMPORTING
        first_char     TYPE c
      RETURNING
        VALUE(result) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA students TYPE string_table.
ENDCLASS.
CLASS zcl_kindergarten_garden IMPLEMENTATION.
  METHOD constructor.
    me->students = VALUE #( ( 'Alice' ) ( 'Bob' ) ( 'Charlie' ) ( 'David' )
                            ( 'Eve' ) ( 'Fred' ) ( 'Ginny' ) ( 'Harriet' )
                            ( 'Ileana' ) ( 'Joseph' ) ( 'Kincaid' ) ( 'Larry' ) ).
  ENDMETHOD.
  METHOD plants.
    READ TABLE me->students TRANSPORTING NO FIELDS
      WITH KEY table_line = student.
    DATA(lv_line1) = sy-tabix * 2 - 2.
    DATA(lv_line2) = sy-tabix * 2 - 1.
    SPLIT diagram AT '\n' INTO DATA(lv_row1) DATA(lv_row2).
    APPEND me->convert2name( lv_row1+lv_line1(1) ) TO results.
    APPEND me->convert2name( lv_row1+lv_line2(1) ) TO results.
    APPEND me->convert2name( lv_row2+lv_line1(1) ) TO results.
    APPEND me->convert2name( lv_row2+lv_line2(1) ) TO results.
  ENDMETHOD.
  METHOD convert2name.
    result = COND string( WHEN first_char = 'R' THEN 'radishes'
                          WHEN first_char = 'V' THEN 'violets'
                          WHEN first_char = 'C' THEN 'clover'
                          WHEN first_char = 'G' THEN 'grass' ).
  ENDMETHOD.
ENDCLASS.