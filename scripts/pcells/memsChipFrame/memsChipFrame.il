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
	( width     "float" 5000)
	( length    "float" 5000)
	( edgeWidth "float" 95)
  )
  let((pcell)
	pcell = makeInstance('memsChipFrame)
	setRef(pcell pcCellView)
	setPcellParams(pcell pcCellView)	
	draw(pcell)
  );let
);pcDefinePcell