;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'component )
comp = makeInstance( 'component )
classp( comp 'component)
classOf(comp)
className(findClass( 'component ))
superclassesOf(classOf(comp))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'ganFet )
gf = makeInstance( 'ganFet )
classp( gf 'ganFet)
classOf(gf)
className(findClass( 'ganFet ))
superclassesOf(classOf(gf))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate a ganFet component
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
comp = makeInstance( 'ganFet )
generate(comp)
classOf(nth(0 getCollection(comp->assemblies)))
classOf(nth(1 getCollection(comp->assemblies)))
lib = "pd0164"
name = "ganFetPreview"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "w")
setRef(comp cv)
render(comp)
dbSave(cv)
dbClose(cv)
