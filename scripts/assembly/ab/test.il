;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'ab )
abr = makeInstance( 'ab )
classp( abr 'ab)
classOf(abr)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate and render unit 
;       gate stem
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
lib = "pd0164"
name = "abTest"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "w")
setRef(abr cv)
render(abr)
dbSave(cv)
dbClose(cv)