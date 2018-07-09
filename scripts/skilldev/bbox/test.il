;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'bbox )
bb = makeInstance( 'bbox )
classp( bb 'bbox)
classOf(bb)
bb->bb
bb->ur
bb->ll
bb->width
bb->height


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Get the bbox for a cv
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pd0164"
name = "pd0164_p"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "r")
bb = makeInstance( 'bbox )
setRef(bb cv)
getbBox(bb)
bb->bb

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Get the bbox dimensions:
: width and height
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pd0164"
name = "pd0164_p"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "r")
bb = makeInstance( 'bbox )
setRef(bb cv)
getDim(bb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Get the bbox Origin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pa0715"
name = "pa715_0p"
bb = makeInstance( 'bbox )
setLib(bb lib)
setName(bb name)
getOrigin(bb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Get the bbox center
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pa0715"
name = "pa715_0p"
bb = makeInstance( 'bbox )
setLib(bb lib)
setName(bb name)
getCenter(bb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5: Test conversion of bbox
;       coordinates to vertices
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pa0715"
name = "pa715_0p"
bb = makeInstance( 'bbox )
setLib(bb lib)
setName(bb name)
bb2vert(bb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6: Get the area of bbox
;       (meters**2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pa0715"
name = "pa715_0p"
bb = makeInstance( 'bbox )
setLib(bb lib)
setName(bb name)
getArea(bb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-7: Shift the bbox and it's contents
;       to the upper right quadrant
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pa0715"
name = "pa715_0p"
bb = makeInstance( 'bbox )
setLib(bb lib)
setName(bb name)
shiftURQ(bb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-8: Get the bbox for a suspected
;       bad reticle cv
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "ts0455"
name = "ts455_0s"
bb = makeInstance( 'bbox )
setLib(bb lib)
setName(bb name)
getbb(bb)
getDim(bb)

