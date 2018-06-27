;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  PCELL generation code
;  for creating the gate
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
    ;Propagate the pcCellview (Supermaster Cell View) reference down into
    ;the pcell SKILL++ code representing the structure of the pcell
    setRef(pcell pcCellView)
    ;Map all the parameters of the a
    setPcellParams(pcell pcCellView)
    draw(pcell)
  );let
);pcDefinePCell