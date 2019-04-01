;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; pcRes.il 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  PCELL generation code
;  for creating the MEMS resistor
;  supermaster Pcell Cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FIXME:
;       1.) Need to generate the resistor on the grid
;           defined in the TF
;       2.) Need guard rails for minLen and minWid as
;           defined in the TF - in planarResistor assembly!
;       3.) Need contact end length and enclosures as
;           defined in the TF
pcDefinePCell(
  list(ddGetObj("D91") "res" "layout")
  (
	( wid  "float" 5)
	( len  "float" 15)
  )
  let((pcell cvid cdfid)
	pcell = makeInstance( 'res )
	setRef(pcell pcCellView)
	setPcellParams(pcell pcCellView)	
	draw(pcell)
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Create the CDF
	; If CDF exists - delete it
;	if( cvid = ddGetObj("D91" "res") then
;	  if( cdfid = cdfGetBaseCellCDF(cvid) then
;            cdfDeleteCDF(cdfid)
;          );if
;	);if
	; Create base cell CDF
;	cdfid = cdfCreateBaseCellCDF(cvid)
	; Create the parameters
;	cdfCreateParam(cdfid
;                           ?name "wid"
;			   ?prompt "wid"
;			   ?defValue 5.0	
;			   ?type "float"
;			   ?display "t"
;        );cdfCreateParameter
;	cdfCreateParam(cdfid
;                           ?name "len"
;			   ?prompt "len"
;			   ?defValue 15.0	
;			   ?type "float"
;			   ?display "t"
;        );cdfCreateParameter
;	cdfCreateParam(cdfid
;                           ?name "width"
;			   ?prompt "width"
;			   ?defValue "5.0"	
;			   ?type "string"
;			   ?display "t"
;			   ?callback "cdfgData->wid=atof(cdfgData->width)"
;        );cdfCreateParameter
;	cdfCreateParam(cdfid
;                           ?name "length"
;			   ?prompt "length"
;			   ?defValue "15.0"	
;			   ?type "string"
;			   ?display "t"
;			   ?callback "cdfgData->len=atof(cdfgData->length)"
;        );cdfCreateParameter
;	cdfSaveCDF(cdfid)
  );let
);pcDefinePcell