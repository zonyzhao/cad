;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0; Existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'cadObj )
co = makeInstance( 'cadObj )
classp( co 'cadObj)
classOf(co)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1; Test clone (by value)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
co = makeInstance( 'cadObj )
setOid(co 100)
setCid(co 200)
setLayer(co "text")
setPurpose(co "drawing")
setGrid(co 0.1)
setRef(co "foo")
getOid(co)
getCid(co)
getLayer(co)
getPurpose(co)
getGrid(co)
getRef(co)
setAttributes(co "foobar")
cop = makeInstance( 'cadObj )
cloneCadObj(co cop)
getOid(cop)
getCid(cop)
getLayer(cop)
getRef(cop)
getPurpose(cop)
getGrid(cop)
getAttributes(cop)
;
setOid(cop 400)
getOid(cop) 
getOid(co)
setLayer(cop "foo")
getLayer(cop)
getLayer(co)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2; Test clone (by value)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pd0164"
name = "viaTest"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "r")
co = makeInstance( 'cadObj )
setRef(co cv)
setAttrList(co)
getAttrValueByKey(co "cellName")
getAttrValueByKey(co "libName")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3; Test diff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; match
a = makeInstance( 'cadObj )
setOid(a "foo")
b = makeInstance( 'cadObj )
setOid(b "foo")
diff(a b)
; mismatch
a = makeInstance( 'cadObj )
setOid(a "foo")
b = makeInstance( 'cadObj )
setOid(b "foobar")
diff(a b)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4; Test serializaton
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; match
a = makeInstance( 'cadObj )
setOid(a "foo")
setCid(a "foobar")
serializeCadObj(a)
