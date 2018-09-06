;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object dependency 
;       existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'ab )
ab = makeInstance( 'ab )
classp( ab 'ab )
classOf(ab)
className(findClass( 'ab ))
superclassesOf(classOf(ab))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Check for object 
;       existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'sodBridgeArray )
sba = makeInstance( 'sodBridgeArray )
classp( sba 'sodBridgeArray)
classOf(sba)
className(findClass( 'sodBridgeArray ))
superclassesOf(classOf(sba))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Preview the bridge array
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sba = makeInstance( 'sodBridgeArray )
setM(sba 6)
setWidth(sba 50.0)
setLength(sba 10.0)
setSpacing(sba 5.0)
lib = "pd0164"
name = "sbaPreview"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "w")
setRef(sba cv)
generate(sba)
render(sba)
; FIXME: Rendering of the geom bbox is broken ...
;setRef(fb->rtrans->rtran cv)
;render(fb->rtrans->rtran)
;cv~>bBox
;sba->coreBBox
dbSave(cv)
dbClose(cv)

