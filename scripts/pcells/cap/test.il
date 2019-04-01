;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'cap )
c = makeInstance( 'cap )
classp( c 'cap)
classOf(c)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: render fixed value cap to 
;       a cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "test"
name = "capTest"
view = "layout"
mview = "maskLayout"
cv = dbOpenCellViewByType( lib name view mview "w")
cap = makeInstance('cap)
setRef(cap cv)
draw(cap)
dbSave(cv)
dbClose(cv)