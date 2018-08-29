;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object dependency 
;       existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'sdArray )
sda = makeInstance( 'sdArray )
classp( sda 'sdArray)
classOf(sda)
className(findClass( 'sdArray ))
superclassesOf(classOf(sda))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Check for object dependency 
;       existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'fetBody )
fb = makeInstance( 'fetBody )
classp(fb 'fetBody)
classOf(fb)
className(findClass( 'fetBody ))
superclassesOf(classOf(fb))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Preview the gate bocy layout
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fb = makeInstance( 'fetBody )
setM(fb 2)
setWidth(fb 50.0)
setLength(fb 10.0)
setSpacing(fb 5.0)
lib = "pd0164"
name = "fetBodyPreview"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(fb cv)
generate(fb)
render(fb)
; FIXME: Rendering of the geom bbox is broken ...
;setRef(fb->rtrans->rtran cv)
;render(fb->rtrans->rtran)
;cv~>bBox
;fb->coreBBox
dbSave(cv)
dbClose(cv)

