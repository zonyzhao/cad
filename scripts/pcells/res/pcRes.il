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
;           defined in the TF
;       3.) Need contact end length and enclosures as
;           defined in the TF
pcDefinePCell(
  list(ddGetObj("D91") "res" "layout")
  (
	( wid  "float" 5)
	( len  "float" 15)
  )
  let((pcell)
	pcell = makeInstance('res)
	setRef(pcell pcCellView)
	setPcellParams(pcell pcCellView)	
	draw(pcell)
  );let
);pcDefinePcell