; pcRes.il 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  PCELL generation code
;  for creating the MEMS resistor
;  supermaster Pcell Cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Code to create a Pcell super master for MEMS resistor
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