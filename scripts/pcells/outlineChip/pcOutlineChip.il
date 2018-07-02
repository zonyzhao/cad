;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; pcOutlineChip.il 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  PCELL generation code
;  for creating the chip outline
;  supermaster Pcell Cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pcDefinePCell(
  list(ddGetObj("reticle") "outlineChip" "layout")
  (
	( width     "float" 1000)
	( length    "float" 1000)
	( edgeWidth "float" 95)
  )
  let((pcell)
	pcell = makeInstance('outlineChip)
	setRef(pcell pcCellView)
	setPcellParams(pcell pcCellView)	
	draw(pcell)
  );let
);pcDefinePcell