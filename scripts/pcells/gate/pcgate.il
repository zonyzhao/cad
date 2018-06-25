;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  PCELL generation code
;  for creating the gate
;  supermaster PCELL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pcDefinePCell(
  list( ddGetObj("test") "gateTest" "layout")
  (
    ( width "float" 50.0 )
    ( length "float" 0.25 )
  )
  let( (pcell)
    pcell = makeInstance( 'gate )
    setRef(pcell pcCellView)
    setPcellParams(pcell pcCellView)
    draw(pcell)
  );let
);pcDefinePCell