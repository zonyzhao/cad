;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ganFet.il
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  PCELL generation code
;  for creating the GaN FET 
;  supermaster Pcell Cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pcDefinePCell(
  list( ddGetObj("D91") "ganFet" "layout")
  (
    (     m  "int"      1 )
    (  width "float" 50.0 )
  )
  let( (pcell)
    pcell = makeInstance( 'ganFetPc )
    setRef(pcell pcCellView)
    setPcellParams(pcell pcCellView)
    generate(pcell)
    drawFet(pcell)
  );let
);pcDefinePCell