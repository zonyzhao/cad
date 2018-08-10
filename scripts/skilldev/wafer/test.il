:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'wafer )
waf = makeInstance( 'wafer )
classp( waf 'wafer)
classOf(wafer)
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
findCenter(wafer)
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


