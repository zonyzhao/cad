;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; memsChipFrame.il 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  PCELL generation code
;  for creating the MEMS chip outline
;  supermaster Pcell Cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pcDefinePCell(
  list(ddGetObj("reticle") "memsChipFrame" "layout")
  (
	( width     "float"    5000   )
	( length    "float"    5000   )
        ( spm       "boolean" "FALSE" )
	( pm        "boolean" "FALSE" )
  )
  let((pcell lib name view cv spmBool spmVal pcParameters)
	pcell = makeInstance('memsChipFrame)
	setRef(pcell pcCellView)
	setPcellParams(pcell pcCellView)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Example of instantion of cv within the pcell compile code
; also use this to implement radio button functionality
;	pcParameters = pcCellView~>parameters~>values
;        foreach( value pcParameters
;	  if(value~>name == "spm" then
;	    spmVal = value~>value
;	    if(value~>valueType == "boolean" then
;              smpBool = nil
;	      if(spmVal == "TRUE" then
;	        spmBool = t
;              );if
;	    );if
;	  );if
;        );foreach
;	if(spmBool then
;	  lib = "reticle"
;	  view = "layout"
;	  name = "SPM_X_AH32"
;	  cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
;          dbCreateInst(getRef(pcell) cv name list(0.0 0.0) "R0" 1)
;	  name = "SPM_Y_AH32"
;	  cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
;          dbCreateInst(getRef(pcell) cv name list(0.0 0.0) "R0" 1)
;	  draw(pcell)
;        else
	  draw(pcell)
;        );if	
  );let
);pcDefinePcell