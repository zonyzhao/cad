:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'reticleArray )
ra = makeInstance( 'reticleArray )
classp( ra 'reticleArray)
classOf(ra)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Create the reticle array
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;read in the reference reticle
lib   = "pd0164"
name  = "pd0164"
view  = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "r")
ret = makeInstance( 'reticle )
; set reticle level information
setRef(ret cv)
setName(ret name)
setRes(ret 10)
setMaxDim(ret 20000)
setOverlap(ret 4.0)
setSrGrid(ret 0.1)
checkDim(ret)
checkRes(ret)
checkGrid(ret)
; get the reticle die sites
detectDieSites(ret)
dbClose(cv)
Origin(ret)
getOrigin(ret)
ret->bbox
getWidth(ret)
getHeight(ret)
; Create the reticle array and center in the target cellview
ra = makeInstance( 'reticleArray )
; set target reticle in reticle array
setReticle(ra ret)
setName(ra name)
; Wafer bBox dimensions - FIXME: get from wafer outline cv
setWaferWidth(ra 97175.0)
setWaferHeight(ra 99275.0)
setOverlap(ra 4.0)
; Create the reticle array in URQ
array(ra)
length(ra->reticles->list->elems)
nth(0 ra->reticles->list->elems)->?
nth(0 ra->reticles->list->elems)->overlap
nth(0 ra->reticles->list->elems)->srRes
nth(0 ra->reticles->list->elems)->name
nth(0 ra->reticles->list->elems)->width
nth(0 ra->reticles->list->elems)->height
;
nth(0 ra->reticles->list->elems)->origin
nth(0 ra->reticles->list->elems)->bbox
;
nth(1 ra->reticles->list->elems)->origin
nth(1 ra->reticles->list->elems)->bbox
;
nth(2 ra->reticles->list->elems)->origin
nth(2 ra->reticles->list->elems)->bbox
;
nth(3 ra->reticles->list->elems)->origin
nth(3 ra->reticles->list->elems)->bbox
;
nth(4 ra->reticles->list->elems)->origin
nth(4 ra->reticles->list->elems)->bbox
;
nth(5 ra->reticles->list->elems)->origin
nth(5 ra->reticles->list->elems)->bbox
;
nth(6 ra->reticles->list->elems)->origin
nth(6 ra->reticles->list->elems)->bbox
;
nth(7 ra->reticles->list->elems)->origin
nth(7 ra->reticles->list->elems)->bbox
;
nth(8 ra->reticles->list->elems)->origin
nth(8 ra->reticles->list->elems)->bbox
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Center the array
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
centerArray(ra list(0.0 0.0))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
nth(0 ra->reticles->list->elems)->origin
nth(0 ra->reticles->list->elems)->bbx->bbx
;
nth(1 ra->reticles->list->elems)->origin
nth(1 ra->reticles->list->elems)->bbx->bbx
;
nth(2 ra->reticles->list->elems)->origin
nth(2 ra->reticles->list->elems)->bbx->bbx
;
nth(3 ra->reticles->list->elems)->origin
nth(3 ra->reticles->list->elems)->bbx->bbx

ret0 = nth(0 ra->reticles->list->elems)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Reticle Single Render
;;;;;;;;;;;;;;;;
;name  = "pd0164_ret_array"
;cv = dbOpenCellViewByType( lib name view type "w")
;setRef(ra cv)
;ret = nth(0 ra->reticles->list->elems)
;setOrigin(ra->bbx list(10000.0 10000.0))
;setRef(ret cv)
;renderRetBbox(ret)
;dbSave(cv)
;dbClose(cv)
;;;;;;;;;;;;;;;;;
; Reticle Array Render
;;;;;;;;;;;;;;;;;
;name  = "pd0164_ret_array"
;cv = dbOpenCellViewByType( lib name view type "w")
;setRef(ra cv)
;foreach(ret getCollection(ra->reticles)
;  printf("Reticle Origin: (%f,%f)\n" xCoord(ret->origin) yCoord(ret->origin))
;  setRef(ret cv)
;  renderRetBbox(ret)
;)
;dbSave(cv)
;dbClose(cv)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Render the array in a cv
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name  = "pd0164_ret_array"
cv = dbOpenCellViewByType( lib name view type "w")
setRef(ra cv)
render(ra)
dbSave(cv)
dbClose(cv)



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


