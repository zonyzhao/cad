:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'snapshot )
ss = makeInstance( 'snapshot )
classp( ss 'snapshot)
classOf(ss)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Get the cellview stackup - single layer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="ASML_PM_LO"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
nth(0 ss->layers->list->elems)->name
classOf(nth(0 ss->layers->list->elems))
classOf(nth(0 nth(0 ss->layers->list->elems)->shapes->list->elems))
nth(0 nth(0 ss->layers->list->elems)->shapes->list->elems)->vertices
dbClose(cv)
; Render snapshot it in a new cellview
name="ASML_PM_LO_snapshot"
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "resistor")
getName(nth(0 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Get the cellview stackup - multilayer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="SPM_X_AH32"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
nth(0 ss->layers->list->elems)->name
classOf(nth(0 ss->layers->list->elems))
classOf(nth(0 nth(0 ss->layers->list->elems)->shapes->list->elems))
nth(0 nth(0 ss->layers->list->elems)->shapes->list->elems)->vertices
dbClose(cv)
; Render snapshot it in a new cellview
name="SPM_X_AH32_snapshot"
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "numbers")
getName(nth(0 ss->layers->list->elems))
getName(nth(1 ss->layers->list->elems))
setName(nth(1 ss->layers->list->elems) "resistor")
getName(nth(1 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Grid checking the snapshot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="sw_mhcd2_sr"
;name="membrane_ebh13_Std"
lib="D91"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
checkMfg(ss)
setOnMfg(ss)
checkMfg(ss)
nth(0 ss->layers->list->elems)->name
classOf(nth(0 ss->layers->list->elems))
classOf(nth(0 nth(0 ss->layers->list->elems)->shapes->list->elems))
nth(0 nth(0 ss->layers->list->elems)->shapes->list->elems)->vertices
dbClose(cv)
; Render snapshot it in a new cellview
name="sw_mhcd2_sr_snapshot"
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
getName(nth(1 ss->layers->list->elems))
getName(nth(2 ss->layers->list->elems))
getName(nth(3 ss->layers->list->elems))
getName(nth(4 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)
; Open the snapshot cellview and re-check grid
name="sw_mhcd2_sr_snapshot"
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
setRef(ss cv)
getStackUp(ss)
checkMfg(ss)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: test removing a layer from
;       the stackup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="SPM_Y_AH53"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
deleteLayer(ss "nitEtch")
printStackUp(ss)
dbClose(cv)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="SPM_Y_AH53_snapshot"
lib="reticle"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5: Tech conversion and re-mapping 
;       layers manually
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="SPM_X_AH53"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
checkMfg(ss)
dbClose(cv)
; Render snapshot it in a new cellview in new technology
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "resistor")
getName(nth(0 ss->layers->list->elems))
getName(nth(1 ss->layers->list->elems))
setName(nth(1 ss->layers->list->elems) "numbers")
getName(nth(1 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6: Tech conversion and re-mapping 
;       layers manually
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="SPM_Y_AH53"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
checkMfg(ss)
dbClose(cv)
; Render snapshot it in a new cellview in new technology
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "resistor")
getName(nth(0 ss->layers->list->elems))
getName(nth(1 ss->layers->list->elems))
setName(nth(1 ss->layers->list->elems) "numbers")
getName(nth(1 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-7: Tech conversion and re-mapping 
;       layers manually
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="SPM_Y_AH32"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
checkMfg(ss)
dbClose(cv)
; Render snapshot it in a new cellview in new technology
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "resistor")
getName(nth(0 ss->layers->list->elems))
getName(nth(1 ss->layers->list->elems))
setName(nth(1 ss->layers->list->elems) "numbers")
getName(nth(1 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-8: Tech conversion and re-mapping 
;       layers manually
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="bug"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
checkMfg(ss)
dbClose(cv)
; Render snapshot it in a new cellview in new technology
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
checkMfg(ss)
setOnMfg(ss)
checkMfg(ss)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "electrode")
getName(nth(0 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-8: Tech conversion and re-mapping 
;       layers manually - BNB RE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="asml_1_bnb_RE"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
checkMfg(ss)
dbClose(cv)
; Render snapshot it in a new cellview in new technology
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
checkMfg(ss)
setOnMfg(ss)
checkMfg(ss)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "resistor")
getName(nth(0 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-9: Tech conversion and re-mapping 
;       layers manually - BNB EL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="asml_1_bnb_EL"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
checkMfg(ss)
dbClose(cv)
; Render snapshot it in a new cellview in new technology
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
checkMfg(ss)
setOnMfg(ss)
checkMfg(ss)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "electrode")
getName(nth(0 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-10: Tech conversion and re-mapping 
;       layers manually - BNB TH
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="asml_1_bnb_TH"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
checkMfg(ss)
dbClose(cv)
; Render snapshot it in a new cellview in new technology
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
checkMfg(ss)
setOnMfg(ss)
checkMfg(ss)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "thick")
getName(nth(0 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-10: Tech conversion and re-mapping 
;       layers manually - BNB MB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="asml_1_bnb_MB"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
checkMfg(ss)
dbClose(cv)
; Render snapshot it in a new cellview in new technology
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
checkMfg(ss)
setOnMfg(ss)
checkMfg(ss)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "membrane")
getName(nth(0 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-11: Tech conversion and re-mapping 
;       layers manually - BNB SV
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="asml_1_bnb_SV"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
checkMfg(ss)
dbClose(cv)
; Render snapshot it in a new cellview in new technology
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
checkMfg(ss)
setOnMfg(ss)
checkMfg(ss)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "spacer_via")
getName(nth(0 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-12: Tech conversion and re-mapping 
;       layers manually - BNB DL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="asml_1_bnb_DL"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
checkMfg(ss)
dbClose(cv)
; Render snapshot it in a new cellview in new technology
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
checkMfg(ss)
setOnMfg(ss)
checkMfg(ss)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "dielectric")
getName(nth(0 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-13: Tech conversion and re-mapping 
;       layers manually - BNB GL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="asml_1_bnb_GL"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
checkMfg(ss)
dbClose(cv)
; Render snapshot it in a new cellview in new technology
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
checkMfg(ss)
setOnMfg(ss)
checkMfg(ss)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "glass")
getName(nth(0 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-14: Tech conversion and re-mapping 
;       layers manually - BNB BR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="asml_1_bnb_BR"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
checkMfg(ss)
dbClose(cv)
; Render snapshot it in a new cellview in new technology
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
checkMfg(ss)
setOnMfg(ss)
checkMfg(ss)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "Bond_Ring")
getName(nth(0 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-15: Tech conversion and re-mapping 
;       layers manually - BNB LM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="asml_1_bnb_LM"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
checkMfg(ss)
dbClose(cv)
; Render snapshot it in a new cellview in new technology
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
checkMfg(ss)
setOnMfg(ss)
checkMfg(ss)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "Lid_Metal")
getName(nth(0 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-16: Taking a snaphot of the 
;        numbers cells
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="num9"
lib="reticle"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
checkMfg(ss)
dbClose(cv)
nth(0 getCollection(nth(0 getCollection(ss->layers))->shapes))->vertices
