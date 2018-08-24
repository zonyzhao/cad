:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'wafer )
waf = makeInstance( 'wafer )
classp( waf 'wafer)
classOf(waf)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Find "CD" Cross
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "reticle"
name = "wafer_4"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type)
wafer = makeInstance( 'wafer )
setRef(wafer cv)
setCrossLayer(wafer "membrane")
findCenter(wafer)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Read in and render the wafer
;       outline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib   = "reticle"
name  = "wafer_4"
view  = "layout"
type = "maskLayout"
cvwo = dbOpenCellViewByType( lib name view type "r")
lib   = "pd0164"
name  = "pd0164_wafer"
view  = "layout"
type = "maskLayout"
cvw = dbOpenCellViewByType( lib name view type "w")
waf = makeInstance( 'wafer )
setRef(waf cvw)
renderOutline(waf cvwo)
dbSave(cvw)
dbClose(cvw)
dbClose(cvwo)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Create the reticle array
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Open reference reticle
lib   = "pd0164"
name  = "pd0164"
view  = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "r")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ret = makeInstance( 'reticle )
setRef(ret cv)
setName(ret name)
setRes(ret 10)
setMaxDim(ret 20000)
setOverlap(ret 4.0)
setSrGrid(ret 0.1)
checkDim(ret)
checkRes(ret)
checkGrid(ret)
detectDieSites(ret)
dbClose(cv)
getOrigin(ret)
ret->bbox
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
waf = makeInstance( 'wafer )
setName(waf name)
setReticle(waf->retArray ret)
setWaferWidth(waf->retArray 97175.0)
setWaferHeight(waf->retArray 99275.0)
setOverlap(waf->retArray 4.0)
; Create the reticle array
array(waf->retArray)
length(waf->retArray->reticles->list->elems)
nth(0 waf->retArray->reticles->list->elems)->?
nth(0 waf->retArray->reticles->list->elems)->overlap
nth(0 waf->retArray->reticles->list->elems)->srRes
nth(0 waf->retArray->reticles->list->elems)->name
nth(0 waf->retArray->reticles->list->elems)->width
nth(0 waf->retArray->reticles->list->elems)->height
;
nth(0 waf->retArray->reticles->list->elems)->origin
nth(0 waf->retArray->reticles->list->elems)->bbx->bbx
;
nth(1 waf->retArray->reticles->list->elems)->origin
nth(1 waf->retArray->reticles->list->elems)->bbx->bbx

ret0 = nth(0 waf->retArray->reticles->list->elems)
;;;;;;;;;;;;;;;;;
; Reticle Array Render over the wafer outline layers
;;;;;;;;;;;;;;;;;
name  = "pd0164_wafer"
lib = "pd0164"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "a")
setRef(waf->retArray cv)
render(waf->retArray)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Erase the reticle array
;       and render a new  
;       reticle array centered 
;       on the wafer outline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Erase all reticle abstracts
name  = "pd0164_wafer"
lib = "pd0164"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "a")
waf = makeInstance( 'wafer )
setRef(waf->retArray cv)
erase(waf->retArray)
; Open the reference reticle
lib   = "pd0164"
name  = "pd0164"
view  = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "r")
ret = makeInstance( 'reticle )
setRef(ret cv)
setName(ret name)
setRes(ret 10)
setMaxDim(ret 20000)
setOverlap(ret 4.0)
setSrGrid(ret 0.1)
checkDim(ret)
checkRes(ret)
checkGrid(ret)
detectDieSites(ret)
dbClose(cv)
Origin(ret)
ret->bbox
; Create the wafer array
waf = makeInstance( 'wafer )
setName(waf name)
setReticle(waf->retArray ret)
setWaferWidth(waf->retArray 97175.0)
setWaferHeight(waf->retArray 99275.0)
setOverlap(waf->retArray 4.0)
array(waf->retArray)
; Center the array
;FIXME: center of wafer not being found!
center = findCenter(waf)
; set wafer center manually for now ...
center = list(0.0 0.0)
centerArray(waf->retArray center)
waf->retArray->origin
waf->retArray->ur
; redender it in wafer cellview
name  = "pd0164_wafer"
lib = "pd0164"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "a")
setRef(waf->retArray cv)
render(waf->retArray)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Number the die sites
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib   = "pd0164"
name  = "pd0164"
view  = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "r")
ret = makeInstance( 'reticle )
setRef(ret cv)
setName(ret name)
setRes(ret 10)
setMaxDim(ret 20000)
setOverlap(ret 4.0)
setSrGrid(ret 0.1)
checkDim(ret)
checkRes(ret)
checkGrid(ret)
detectDieSites(ret)
checkInnerStreets(ret)
arrayDieSites(ret)
dbClose(cv)
Origin(ret)
ret->bbox
; Create the wafer array
waf = makeInstance( 'wafer )
setName(waf name)
setReticle(waf->retArray ret)
setWaferWidth(waf->retArray 97175.0)
setWaferHeight(waf->retArray 99275.0)
setOverlap(waf->retArray 4.0)
array(waf->retArray)
; Center the array
;FIXME: center of wafer not being found!
center = findCenter(waf)
; set wafer center manually for now ...
center = list(0.0 0.0)
centerArray(waf->retArray center)
waf->retArray->origin
waf->retArray->ur
; wafer level die sites
getWaferDieSites(waf)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ret = getItem(waf->retArray->reticles 0)
; Wafer Reticle: 0, Wafer Die Site: 0
getWaferRow(getItem(ret->dieSites 0))
getWaferRow(getItem(ret->dieSites 0))
; Wafer Reticle: 0, Wafer Die Site: 1
getWaferRow(getItem(ret->dieSites 1))
getWaferRow(getItem(ret->dieSites 1))
; Wafer Reticle: 0, Wafer Die Site: 2
getWaferRow(getItem(ret->dieSites 2))
getWaferRow(getItem(ret->dieSites 2))
; Wafer Reticle: 0, Wafer Die Site: 3
getWaferRow(getItem(ret->dieSites 3))
getWaferRow(getItem(ret->dieSites 3))
; Wafer Reticle: 0, Wafer Die Site: 4
getWaferRow(getItem(ret->dieSites 4))
getWaferRow(getItem(ret->dieSites 4))
; Wafer Reticle: 0, Wafer Die Site: 5
getWaferRow(getItem(ret->dieSites 5))
getWaferRow(getItem(ret->dieSites 5))
; Wafer Reticle: 0, Wafer Die Site: 6
getWaferRow(getItem(ret->dieSites 6))
getWaferRow(getItem(ret->dieSites 6))
; Wafer Reticle: 0, Wafer Die Site: 7
getWaferRow(getItem(ret->dieSites 7))
getWaferRow(getItem(ret->dieSites 7))
; Wafer Reticle: 0, Wafer Die Site: 8
getWaferRow(getItem(ret->dieSites 8))
getWaferRow(getItem(ret->dieSites 8))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ret = getItem(waf->retArray->reticles 1)
; Wafer Reticle: 1, Wafer Die Site: 0
getWaferRow(getItem(ret->dieSites 0))
getWaferRow(getItem(ret->dieSites 0))
; Wafer Reticle: 1, Wafer Die Site: 1
getWaferRow(getItem(ret->dieSites 1))
getWaferRow(getItem(ret->dieSites 1))
; Wafer Reticle: 1, Wafer Die Site: 2
getWaferRow(getItem(ret->dieSites 2))
getWaferRow(getItem(ret->dieSites 2))
; Wafer Reticle: 1, Wafer Die Site: 3
getWaferRow(getItem(ret->dieSites 3))
getWaferRow(getItem(ret->dieSites 3))
; Wafer Reticle: 1, Wafer Die Site: 4
getWaferRow(getItem(ret->dieSites 4))
getWaferRow(getItem(ret->dieSites 4))
; Wafer Reticle: 1, Wafer Die Site: 5
getWaferRow(getItem(ret->dieSites 5))
getWaferRow(getItem(ret->dieSites 5))
; Wafer Reticle: 1, Wafer Die Site: 6
getWaferRow(getItem(ret->dieSites 6))
getWaferRow(getItem(ret->dieSites 6))
; Wafer Reticle: 1, Wafer Die Site: 7
getWaferRow(getItem(ret->dieSites 7))
getWaferRow(getItem(ret->dieSites 7))
; Wafer Reticle: 1, Wafer Die Site: 8
getWaferRow(getItem(ret->dieSites 8))
getWaferRow(getItem(ret->dieSites 8))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Experimental Code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;###############################
;UT?: check cv for a PCELL
;###############################
lib = "pa0715"
cell= "p80B_1_grid_C"


cv = dbOpenCellViewByType( lib cell "layout" "maskLayout")

cv->?
cv->??

cv->isParamCell

cv->objType

cv->prop
prp = nth(0 cv->prop)
prp->?
prp->??
prp->object->??
prp = nth(1 cv->prop)
prp->?
prp->??
prp->object->?

; Checks to see if cv is a PCELL
dbCheckParamCell(cv)
; Evaluates the supermaster and submaster of a PCELL (parmeters on all the
;instance headers are fixed)
dbEvalParamCell(cv)
dbFixParamCell(cv "/users/1127110/pcfix.il")
dbIsFluidPcell(cv)
dbIsNonSkillPCell(cv)
superMasterpcellXform = dbCreateXformPCell(cv lib)
superMasterpcellXform->??

;#########################################################
; Writes out three lists to the specified file:
; First List is a list of library names, cell names,
; and view names of the given cellview ID
; Second List is a list of the parameter values
; Third List is the skill procedure attached to the given
; cellview ID
dbDumpPcDefinePcell(cv "/users/1127110/pcdump.il")
;#########################################################

;###############################
;UT?: check cv instance for a PCELL
;###############################
lib = "pa0715"
cell= "pa715_0p_chip_00"
cv = dbOpenCellViewByType( lib cell "layout" "maskLayout")

cv->?? 

cv->isParamCell

inst=cv->instances

iid = nth(0 inst)
iid->??
iid->cellName
iid->isAnyInst
iid->isShape 
iid->children
iid->parent
iid->baseName
iid->isParamCell
iid->master
iid->master->??

iid = nth(1 inst)
iid->??
iid->cellName
iid->isAnyInst
iid->isShape 
iid->children
iid->parent
iid->baseName
iid->isParamCell
iid->master
iid->master->??

iid = nth(2 inst)
iid->??
iid->cellName
iid->isAnyInst
iid->isShape 
iid->children
iid->parent
iid->baseName
iid->isParamCell
iid->master
iid->master->??

iid = nth(3 inst)
iid->??
iid->cellName
iid->isAnyInst
iid->isShape 
iid->children
iid->parent
iid->baseName
iid->isParamCell
iid->master
iid->master->??

iid = nth(4 inst)
iid->??
iid->cellName
iid->isAnyInst
iid->isShape 
iid->children
iid->parent
iid->baseName
iid->isParamCell
iid->master
iid->master->??

iid = nth(5 inst)
iid->??
iid->cellName
iid->isAnyInst
iid->isShape 
iid->children
iid->parent
iid->baseName
iid->isParamCell
iid->master
iid->master->??

iid = nth(6 inst)
iid->??
iid->cellName
iid->isAnyInst
iid->isShape 
iid->children
iid->parent
iid->baseName
iid->isParamCell
iid->master
iid->master->??

iid = nth(7 inst)
iid->??
iid->cellName
iid->isAnyInst
iid->isShape 
iid->children
iid->parent
iid->baseName
iid->isParamCell
iid->master
iid->master->??

; I85, p80B_1_grid_C - PCELL??
iid = nth(8 inst)
iid->??
iid->cellName
iid->isAnyInst
iid->isShape 
iid->children
iid->parent
iid->baseName
iid->isParamCell
iid->master 
iid->master->??
iid->master->superMaster
iid->master->superMaster->??


cdfDump("Libname" "outfile" ?cellName "cellName")

dbCreatePCell()

dbCheckParamCell(iid)







; Get the target instance in the cellview
instId=dbGetInstByName(cv iid->baseName)
instId->??
instId->cellName
instId->cellView->isParamCell
instId->cellView->master


instId=dbGetInstByName(cv "I85")
instId->??
instId->cellName
instId->cellView->isParamCell
instId->cellView->master

dd
pcDefinePCell(list(ddGetObj("foo") "muxPcell" "layout")
              list((width 1.0) 
	      	   (length 10) 
		   (numGates 1)




pcell=pcDefinePCell(list(ddGetObj("pa0715"), "ind", "layout")
              (
	        (W "float" 1000)
		(S "float" 100)
		(OD "float" 90) 
		(GAP "float" 10) 
	      	(DIV "float" 3.5) 
		(LEAD "float" 20.0)
		(NT "int"  2)
		(dmy_en "boolean" nil)
		(DMY_TEXT "string" "ind_a")
	      )
	      let((techfile_lib techFileID master inst)
	        techfile_lib=techGetTechLibName(pcCellView->lib)
		techFileID=techGetTechFile(ddGetObj(techfile_lib))
		master=dbOpenCellViewByType("pa0715" "ind_oct_t" "layout")
		inst = dbCreateParamInst(pcCellView master nil 0:0 "R0" 1
                                         list(
						list("OD" "float" OD-(NT-1)*2*LEAD)
						list("W" "float" W)
						list("S" "float" S)
						list("GAP" "float" GAP)
						list("DIV" "float" DIV)
						list("dmy_en" "boolean" dmy_en)
					      );list
                                         );dbCreateParamInst
		dbCreateRect(pcCellView,list("sd" "drawing"),list(0:0 W:W))
		dbCreateLabel(pcCellView,list("text" "drawing"),0:0,DMY_TEXT, "centerCenter","R0","roman",0.2)
		);let
);pcDefinePCell


