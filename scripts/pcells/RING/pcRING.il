; pcRING.il
; Code to create a Pcell super master for RING
pcDefinePCell(list(ddGetObj("test") "RING" "layout")
  (
	( ringW  "float" 0.1)
	( ringS  "float" 0.1)

  )
  let((pcell)
	pcell = makeInstance('RING)
	setPcellParams(pcell pcCellView)
	draw(pcell)
  );let
);pcDefinePcell