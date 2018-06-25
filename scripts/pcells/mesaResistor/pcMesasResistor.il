; pcMesaResistor.il 
; Code to create a Pcell super master for mesaResistor
pcDefinePCell(list(ddGetObj("test") "mesaResistor" "layout")
  (
	( wid  "float" 5)
	( len  "float" 15)
  )
  let((pcell)
	pcell = makeInstance('mesaResistor)
	setPcellParams(pcell pcCellView)
	draw(pcell)
  );let
);pcDefinePcell