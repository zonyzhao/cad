;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'planarCap )
pc = makeInstance( 'planarCap )
classp( pc 'planarCap)
classOf(pc)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate and render unit 
;       gate stem
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pc = makeInstance( 'planarCap )
; Dielectric "Sandwiched" layer
capWidth = 87.0
capLength = 240.2 
overlap = 2.0
setWidthDiel(pc capWidth)
setLengthDiel(pc capLength)
setLayerDiel(pc "spacer_via")
setPurposeDiel(pc "drawing")
; Top Plate Definition
setWidthTop(pc capWidth+2*overlap)
setLengthTop(pc capLength+2*overlap)
setLayerTop(pc "membrane")
setPurposeTop(pc "drawing")
; Bottom Plate Definition
setWidthBot(pc capWidth+4*overlap)
setLengthBot(pc capLength+4*overlap)
setLayerBot(pc "thick")
setPurposeBot(pc "drawing")
generate(pc)
lib = "D91"
name = "capTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(pc cv)
render(pc)
dbSave(cv)
dbClose(cv)