;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'stamp )
st = makeInstance( 'stamp )
classp( st 'stamp)
classOf(st)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Print a number in a cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
st = makeInstance( 'stamp )
setChars(st "100")
setOrigin(st list(0.0 0.0))
setLayer(st "resistor")
setPurpose(st "drawing")
generate(st)
lib = "pd0164"
name = "memsChipFrameTest"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "w")
setRef(st cv)
render(st)
dbSave(cv)
dbClose(cv)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2 Print a shifted number in the celview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
numg = makeInstance( 'numbersGenerator )
setRow(numg 3)
setCol(numg 1)
setCentroid(numg list(500.0 500.0))
setLayer(numg "resistor")
setPurpose(numg "drawing")
generate(numg)
lib = "pd0164"
name = "memsChipFrameTest"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "a")
setRef(numg cv)
render(numg)
dbSave(cv)
dbClose(cv)