;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; pcGate.il
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  PCELL generation code
;  for creating the GaN FET gate
;  supermaster Pcell Cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pcDefinePCell(
  list( ddGetObj("D91") "gate" "layout")
  (
    ( width "float" 50.0 )
    ( length "float" 0.25 )
  )
  let( (pcell)
    pcell = makeInstance( 'gate )
    setRef(pcell pcCellView)
    setPcellParams(pcell pcCellView)
    drawGate(pcell)
  );let
);pcDefinePCell