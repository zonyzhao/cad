;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0; Existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'die )
d = makeInstance( 'die )
classp( d 'die)
classOf(d)



;###############################
;UTX: finding the CD XYnumberPad
;###############################
lib = "am0105"
cell= "wafer_4"


cv = dbOpenCellViewByType( lib cell "layout" "maskLayout")

cv->?

cv->shapes

shape = nth(0 cv->shapes)
shape->layerName
shape = nth(1 cv->shapes)
shape->layerName
shape = nth(2 cv->shapes)
shape->layerName
shape = nth(3 cv->shapes)
shape->layerName
shape = nth(4 cv->shapes)
shape->layerName
shape = nth(5 cv->shapes)
shape->layerName
shape = nth(6 cv->shapes)
shape->layerName
shape->points
box=shape->bBox

wid = caadr(box)-caar(box)
hgh = cadadr(box)-cadar(box)

wid-hgh

abs( (caadr( box ) - caar( box)) - (cadadr(box) - cadar(box)))

cross = nth(6 cv->shapes)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Test Existence and Inheritance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'reticle )
ret = makeInstance( 'reticle )
classp( ret 'reticle)
classOf(ret)
superclassesOf(classOf(ret))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Reticle Resolution Testing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ret = makeInstance( 'reticle )
ret->cellName  = "am0105_0p"
ret->library   = "am0105"
ret->srRes = 10
ret->maxDim = 20000
ret->frame = "frameless"
getbBox(ret)
getDim(ret)
checkRes(ret)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Reticle Resolution Testing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ret = makeInstance( 'reticle )
ret->cellName  = "pa0715_0p"
ret->library   = "pa0715"
ret->srRes = 10
ret->maxDim = 20000
ret->frame = "leica"
getbBox(ret)
getDim(ret)
checkRes(ret)