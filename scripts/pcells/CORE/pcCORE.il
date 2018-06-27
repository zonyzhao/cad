; pcCORE.il 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PCELL API code for generating a block cross representing 
; the core area of a chip
;
; Used for testing the Skill++ PCELL API 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
; cyanW: Width of the verticle cross block
; cyanL: Lenth of the verticle cross blcok
; greenW: Width of the verticle cross block
; greenL: Lenth of the verticle cross blcok
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pcDefinePCell(list(ddGetObj("D91") "CORE" "layout")
  (
	( cyanW   "float" 0.6)
	( greenL  "float" 0.6)
	( greenW  "float" 0.2)
	( cyanL   "float" 0.2)

  )
  let((pcell)
	pcell = makeInstance('CORE)
	setPcellParams(pcell pcCellView)
	draw(pcell)
  );let
);pcDefinePcell