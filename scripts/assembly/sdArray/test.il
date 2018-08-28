;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'sdArray )
sda = makeInstance( 'sdArray )
classp( sda 'sdArray)
classOf(sda)
className(classOf(sda))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate and render unit 
;       source drain array
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sda = makeInstance( 'sdArray )
setM(sda 4)
setWidth(sda 100.0)
setLength(sda 50.0)
setSpacing(sda 50.0)
setLayer(sda "resistor")
setPurpose(sda "drawing")
generate(sda)
lib = "pd0164"
name = "sdArray"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(sda cv)
render(sda)
dbSave(cv)
dbClose(cv)