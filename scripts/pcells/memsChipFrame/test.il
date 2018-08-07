;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'memsChipFrame )
ol = makeInstance( 'memsChipFrame )
classp( ol 'memsChipFrame)
classOf(ol)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Test parameter mapping
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;open new dummy reference cell - don't save
lib = "reticle"
name = "dummy"
view = "layout"
mview = "maskLayout"
cv = dbOpenCellViewByType( lib name view mview "w")
pcell = makeInstance('memsChipFrame)
setRef(pcell cv)
debugPcellParams(pcell pcCellView cv)