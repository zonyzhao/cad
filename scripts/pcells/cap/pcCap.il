;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; pcCap.il 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  PCELL generation code
;  for creating the MEMS capacitor
;  supermaster Pcell Cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FIXME:
;       1.) Need to generate the capacitor on the grid
;           defined in the TF
;       2.) Need guard rails for minLen and minWid as
;           defined in the TF
;       3.) Need contact end length and enclosures as
;           defined in the TF
pcDefinePCell(
  list(ddGetObj("D91") "cap" "layout")
  (
	( wid  "float" 100)
	( len  "float" 100)
  )
  let((pcell)
	pcell = makeInstance('cap)
	setRef(pcell pcCellView)
	setPcellParams(pcell pcCellView)	
	draw(pcell)
  );let
);pcDefinePcell