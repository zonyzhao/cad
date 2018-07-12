;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0; Class Existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'instance )
inst = makeInstance( 'instance )
classp( inst 'instance)
classOf(inst)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Open the heirarchical cell
lib="test"
name="p80B_1_fet_mult_F"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
getInstances(cell)
; Define the flattened cellview
cpName = "p80B_1_fet_mult_F_flattened"
dbCopyCellView(cv lib cpName "layout" "" nil t)
cpRef = dbOpenCellViewByType(lib cpName "layout" "maskLayout" "a" )
; Create the copy cellview reference
cpcell = makeInstance( 'cv )
setRef(cpcell cpRef)
setView(cpcell "layout")
setName(cpcell cpName)
setLib(cpcell lib)
getInstances(cpcell)

nth(0 getInstances(cpcell))~>?
nth(0 getInstances(cpcell))~>cellName
nth(0 getInstances(cpcell))~>cluster

; Creat an instance object
inst = makeInstance( 'instance )
; iterate over nInstances - i=0 indicating that instances
; are being consumed by the flattening process
setRef(inst nth(0 getInstances(cpcell)))
flattenInstance(inst)
setRef(inst nth(0 getInstances(cpcell)))
flattenInstance(inst)
; Save the flattened cell
dbSave(cpRef)
dbClose(cpRef)


;###########################################################################
; Experimental Code
;###########################################################################

; Nice procedural construct for recursively finding an instance with a given
; name within an instance that contains heirarchy

procedure(getMetroFET(master @optional (transform list(0:0 "R0" 1)) (hierInstPath "/"))
  let( (InternalCellInfo)
    foreach(inst master~>instances
      when(inst~>objType=="inst"
	if( rexMatchp("MetroFet" inst~>cellName) || rexMatchp("metroFET" inst~>cellName) then
	  InternalCellInfo = list(inst~>cellName  dbTransformPoint(inst~>xy transform) inst~>orient)
	  phopl->Metro = cons(InternalCellInfo phopl->Metro)
	)
	getMetroFET(
	  inst~>master
	  dbConcatTransform(inst~>transform transform)
	  strcat(hierInstPath inst~>cellName "/")
	)
      )
    )
    t
  )
)

;first attempt to make it more general ....
;of course it is still procedural, so we need the global variable GLOBAL_INST

lib="pa0715"
name="pa715_0p"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")

name = "Boxnbox"
GLOBAL_INST = list()
getAllInstances(cv name)

procedure(getAllInstances(cv name @optional (transform list(0:0 "R0" 1)) (hierInstPath "/"))
  let( (InternalCellInfo iname)
    iname = lowerCase(name)
    foreach(inst cv~>instances
      when(inst~>objType=="inst"
	printf("Checking instance: %s\n" inst~>cellName)
	if( rexMatchp(iname lowerCase(inst~>cellName)) then
	  InternalCellInfo = list(inst~>cellName  dbTransformPoint(inst~>xy transform) inst~>orient)
	  GLOBAL_INST = cons(InternalCellInfo GLOBAL_INST)
	  printf("Adding %s to list" inst~>cellName)
	);if 
	getAllInstances(inst~>master iname dbConcatTransform(inst~>transform transform) strcat(hierInstPath inst~>cellName "/"))
      );while
    );foreach
    t
  );let
);proc

phopl->Metro = GLOBAL_INST

