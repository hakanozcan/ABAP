REPORT zdemo_bapi_user_get_detail.

DATA: lv_username TYPE bapibname-bapibname,
      ls_logon    TYPE bapilogond,
      ls_adress   TYPE bapiaddr3,
      ls_company  TYPE bapiuscomp,
      lt_return   TYPE bapiret2 OCCURS 0 WITH HEADER LINE.

lv_username = 'HOZCAN'.

CALL FUNCTION 'BAPI_USER_GET_DETAIL'
  EXPORTING
    username  = lv_username
*   CACHE_RESULTS        = 'X'
  IMPORTING
    logondata = ls_logon
*   DEFAULTS  =
    address   = ls_adress
    company   = ls_company
*   SNC       =
*   REF_USER  =
*   ALIAS     =
*   UCLASS    =
*   LASTMODIFIED         =
*   ISLOCKED  =
*   IDENTITY  =
*   ADMINDATA =
  TABLES
*   PARAMETER =
*   PROFILES  =
*   ACTIVITYGROUPS       =
    return    = lt_return
*   ADDTEL    =
*   ADDFAX    =
*   ADDTTX    =
*   ADDTLX    =
*   ADDSMTP   =
*   ADDRML    =
*   ADDX400   =
*   ADDRFC    =
*   ADDPRT    =
*   ADDSSF    =
*   ADDURI    =
*   ADDPAG    =
*   ADDCOMREM =
*   PARAMETER1           =
*   GROUPS    =
*   UCLASSSYS =
*   EXTIDHEAD =
*   EXTIDPART =
*   SYSTEMS   =
  .

BREAK-POINT.