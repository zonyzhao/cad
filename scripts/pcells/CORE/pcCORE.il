; pcCORE.il 
; Code to create a Pcell super master for CORE
pcDefinePCell(list(ddGetObj("test") "CORE" "layout")
  (
	( cyanW  "float" 0.6)
	( greenL  "float" 0.8)
	( greenW "float" 0.2)
	( cyanL  "float" 0.2)

  )
  let((pcell)
	pcell = makeInstance('CORE)
	setPcellParams(pcell pcCellView)
	draw(pcell)
  );let
);pcDefinePcell