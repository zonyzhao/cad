:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'assembly )
ass = makeInstance( 'assembly )
classp( ass 'assembly)
classOf(ass)
:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Making a capsule assembly
;       on layer "sd" adding it to 
;       a stackup and rendering the
;       stackup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cap = makeInstance( 'capsule )
setHeight(cap 50.0)
setWidth(cap 25.0)
setLayer(cap "sd")
setPurpose(cap "drawing")
genCapsule(cap)
classOf(nth(0 cap->shapes->list->elems))
getLayer(nth(0 cap->shapes->list->elems))
; Create the stackup object
stack = makeInstance( 'stackup )
; Set the stackup to the layer list of
; the capsule assembly object
setStackCollection(stack getLayerCollection(cap)) 
name="capsuleTest"
lib="test"
cvRef = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(stack cvRef)
renderStack(stack)
dbSave(cvRef)
dbClose(cvRef)
:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Making a trirect assembly 
;       on layer "mesa" adding it 
;       to a stackup and rendering 
;       the stackup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tr = makeInstance( 'trirect )
setHeight(tr 50.0)
setWidth(tr 10.0)
setLayer(tr "mesa")
setPurpose(tr "drawing")
genTriRect(tr)
classOf(nth(0 tr->shapes->list->elems))
getLayer(nth(0 tr->shapes->list->elems))
; Create the stackup object
stack = makeInstance( 'stackup )
; Set the stackup to the layer list of
; the trirect assembly object
setStackCollection(stack getLayerCollection(tr)) 
name="trirectTest"
lib="test"
cvRef = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(stack cvRef)
renderStack(stack)
dbSave(cvRef)
dbClose(cvRef)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Adding a trirect assembly on "capBot"
;       and a capsule assembly on "thick" to
;       a stackup and rendering it
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;
; Create the gate pad polygons
;;;;;;;;;;;;;;;;;;;;;;;;
cap = makeInstance( 'capsule )
setLength(cap 4.0)
setWidth(cap 13.0)
genCapsule(cap)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; gatePad shape
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gatePad = makeInstance( 'shape )
setLayer(gatePad "leGatePad")
setPurpose(gatePad "drawing")
addPolygon(gatePad cap)

;;;;;;;;;;;;;;;;;;;;;;;;
; Create the gate stem 
; polygons
;;;;;;;;;;;;;;;;;;;;;;;;
tr = makeInstance( 'trirect )
setLength(tr 0.8)
setWidth(tr 2.5)
genTriRect(tr)

rect = makeInstance( 'rectangle )
setLen(rect 50.0)
setWid(rect 0.25)
genRect(rect)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; gate stem shape
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gateStem = makeInstance( 'shape )
setLayer(gateStem "gateStem")
setPurpose(gateStem "drawing")
addPolygon(gateStem tr)
addPolygon(gateStem rect)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Create the gate assembly
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gate = makeInstance( 'assembly )
addShape(gate gatePad)
addShape(gate gateStem)
setShapesOnLayers(gate)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Create the component stackup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stack = makeInstance( 'stackup )
addAssembly(stack getLayerCollection(gate)) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Render the stackup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="fetGateTest"
lib="test"
cvRef = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(stack cvRef)
renderStack(stack)
dbSave(cvRef)
dbClose(cvRef)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Translating an assembly
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
gate = makeInstance( 'ganGate )
lib = "pd0164"
name = "ganGatePreview"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "w")
setRef(gate cv)
setWidth(gate 100.0)
setLength(gate 0.25)
generate(gate)
translate(gate list(0.0 300.0))

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Rotationg an assembly
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
abr = makeInstance( 'ab )
setWidth(abr 50.0)
setLength(abr 100.0)
setMinWidth(abr 10.0)
setMinLength(abr 10.0)
setTermLen(abr 25.0)
setTermEnc(abr 5.0)
setBodyLayer(abr "thick")
setBodyPurpose(abr "drawing")
setPillowLayer(abr "dielectric")
setPillowPurpose(abr "drawing")
setContLayer(abr "electrode")
setContPurpose(abr "drawing")
generate(abr)
rotate(abr 90.0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Experimental code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
nth(0 getCollection(abr->geometries))
foreach( geom getCollection(abr->geometries)
      rotate(geom 90.0)
);foreach	  
rotate(abr>rtran 90.0)