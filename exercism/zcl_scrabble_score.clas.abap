class ZCL_SCRABBLE_SCORE definition public.
    public section.
      methods SCORE
        importing
          INPUT         type STRING optional
        returning
          value(RESULT) type I.
    protected section.
    private section.
  endclass.
  class ZCL_SCRABBLE_SCORE implementation.
    METHOD SCORE.
      CHECK input IS NOT INITIAL.
      result = count( val = input case = abap_false regex = `[AEIOULNRST]` )
               + 2 * count( val = input case = abap_false regex = `[DG]` )
               + 3 * count( val = input case = abap_false regex = `[BCMP]` )
               + 4 * count( val = input case = abap_false regex = `[FHVWY]` )
               + 5 * count( val = input case = abap_false regex = `[K]` )
               + 8 * count( val = input case = abap_false regex = `[JX]` )
               + 10 * count( val = input case = abap_false regex = `[QZ]` ).  
  ENDMETHOD.
  endclass.


  CLASS ZCL_SCRABBLE_SCORE DEFINITION PUBLIC .
    PUBLIC SECTION.
      METHODS score
        IMPORTING
          input         TYPE string OPTIONAL
        RETURNING
          VALUE(result) TYPE i.
    data: input_upper type string.
    PROTECTED SECTION.
    PRIVATE SECTION.
  ENDCLASS.
  CLASS ZCL_SCRABBLE_SCORE IMPLEMENTATION.
    METHOD score.
       CHECK input IS NOT INITIAL.
      input_upper = input.
        translate input_upper to upper case.
               result = count( val = input_upper regex = '[AEIOULNRST]' )
              + 2  *   count( val = input_upper regex = '[DG]')
              + 3  *   count( val = input_upper regex = '[BCMP]')
              + 4  *   count( val = input_upper regex = '[FHVWY]')
              + 5  *   count( val = input_upper regex = '[K]')
              + 8  *   count( val = input_upper regex = '[JX]')
              + 10 *   count( val = input_upper regex = '[QZ]') .
    ENDMETHOD.
  ENDCLASS.