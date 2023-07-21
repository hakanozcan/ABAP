REPORT zdemo_sales_order_report.

TABLES: vbak, vbap.

TYPES: BEGIN OF st_sal,
         vbeln TYPE vbeln_va,
         erdat TYPE erdat,
         ernam TYPE ernam,
         posnr TYPE posnr,
         matnr TYPE matnr,
       END OF st_sal.

DATA: it_sal TYPE STANDARD TABLE OF st_sal,
      w_sal  TYPE st_sal.

SELECT-OPTIONS: s_vbeln FOR vbak-vbeln.


SELECT vbak~vbeln
  vbak~erdat
  vbak~ernam
  vbap~posnr
  vbap~matnr
  INTO TABLE it_sal FROM vbak
  INNER JOIN vbap
  ON vbak~vbeln = vbap~vbeln
  WHERE vbak~vbeln IN s_vbeln.

LOOP AT it_sal INTO w_sal.
  WRITE: / w_sal-vbeln,
   w_sal-erdat,
   w_sal-ernam,
   w_sal-posnr,
   w_sal-matnr.
ENDLOOP.