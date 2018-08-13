;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0; Existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'cadObj )
co = makeInstance( 'cadObj )
classp( co 'cadObj)
classOf(co)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1; Test copy generic
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
clone(co cop)
getOid(cop)
getCid(cop)
getLayer(cop)
getRef(cop)
getPurpose(cop)
getGrid(cop)
getAttributes(cop)
