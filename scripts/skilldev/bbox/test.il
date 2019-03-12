;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'bbox )
bb = makeInstance( 'bbox )
classp( bb 'bbox)
classOf(bb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Get the bbox for a cv
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#lib = "pd0164"
#name = "pd0164_0p"
#lib = "tr0046"
#name = "tr46_7s"
lib = "am0128"
name = "am128_0p"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
bb = makeInstance( 'bbox )
setRef(bb cv)
getbb(bb)
getDim(bb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Get the bbox dimensions:
: width and height
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pd0164"
name = "pd0164_0p"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
bb = makeInstance( 'bbox )
setRef(bb cv)
getbb(bb)
getDim(bb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Get the bbox Origin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pd0164"
name = "pd0164_0p"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
bb = makeInstance( 'bbox )
setRef(bb cv)
getbb(bb)
Origin(bb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Get the bbox center
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pd0164"
name = "pd0164_0p"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
bb = makeInstance( 'bbox )
setRef(bb cv)
getbb(bb)
Centroid(bb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5: Test conversion of bbox
;       coordinates to vertices
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pd0164"
name = "pd0164_0p"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
bb = makeInstance( 'bbox )
setRef(bb cv)
getbb(bb)
bb2vert(bb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6: Get the area of bbox
;       (meters**2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;lib = "pd0164"
;name = "pd0164_0p"
;bb = makeInstance( 'bbox )
;setLib(bb lib)
;setName(bb name)
;getArea(bb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-7: Shift the bbox and it's contents
;       to the upper right quadrant
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pd0164"
name = "pd0164_0p_urqshift"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
bb = makeInstance( 'bbox )
setRef(bb cv)
shiftURQ(bb)



