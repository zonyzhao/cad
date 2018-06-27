;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; pcRING.il
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PCELL API code for generating a ring or frame
; Used for testing the Skill++ PCELL API flow.  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
; ringW: Width of the frame ring
; ringS: Innner dimension of the frame ring core
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Code to create a Pcell super master for RING
pcDefinePCell(list(ddGetObj("D91") "RING" "layout")
  (
	( ringW  "float" 1)
	( ringS  "float" 10)

  )
  let((pcell)
	pcell = makeInstance('RING)
	setPcellParams(pcell pcCellView)
	draw(pcell)
  );let
);pcDefinePcell