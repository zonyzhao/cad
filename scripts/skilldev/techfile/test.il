;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for class existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'techfile )
tf = makeInstance( 'techfile )
classp(tf 'techfile)
classOf(tf)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Get techfile reference
;           original techfile not in
;           same library
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tf = makeInstance( 'techfile )
setName(tf "D91")
getTechFileRef(tf)
tf->ref
tf->ref->??
tf->cid
tf->oid

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Get techfile reference
;           original techfile in
;           same library
;       (lower level stuff using cadObj
;       inherited class)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tf = makeInstance( 'techfile )
setName(tf "fooTech")
getTechFileRef(tf)
setAttrList(tf)
getAttrValueByKey(tf "layers")
getAttrValueByKey(tf "libName")
getAttrValueByKey(tf "prop")~>??
nth(0 getAttrValueByKey(tf "constraintGroups"))~>??
tf->ref
tf->ref->??
tf->cid
tf->oid

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Get attribute list of 
;       techfile reference
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tf = makeInstance( 'techfile )
setName(tf "D91")
getTechFileRef(tf)
setAttrList(tf)
tf->attributes

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Get attribute value 
;       by attribute key
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tf = makeInstance( 'techfile )
setName(tf "D91")
tid=getTechFileRef(tf)
setAttrList(tf)
getAttrValueByKey(tf "libName")
getAttrValueByKey(tf "processFamily")
getAttrValueByKey(tf "hasConflict")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5: set the list of layer names
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tf = makeInstance( 'techfile )
setName(tf "D91")
tid=getTechFileRef(tf)
setTechLayers(tf)
printLayers(tf)
getControls(tf)
isDerived(tf)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6: derived tech file  layer names
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tf = makeInstance( 'techfile )
setName(tf "reticle")
tid=getTechFileRef(tf)
setTechLayers(tf)
printLayers(tf)
tid=getTechFileRef(tf)
setAttrList(tf)
getAttrValueByKey(tf "libName")
getAttrValueByKey(tf "processFamily")
getAttrValueByKey(tf "hasConflict")
getControls(tf)
isDerived(tf)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-7: get the tech params
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tf = makeInstance( 'techfile )
setName(tf "D91")
getControls(tf)
getControl(tf "sdHeight")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Experimental Code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Techfile reference Experimental Commands
libId=ddGetObj("XYnumbers")
tf = techGetTechFile(libId)
techGetDeviceClass(tf "" "symbolic")
techGetDeviceInClass(tf "syContact" "symbolic")

foreach(mpcar device techGetDeviceInClass(tf "syContact" "symbolic")
	      techGetDeviceParam(tf device "symbolic")
);foreach



techIsMfgGridResolutionSet(tid)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Techfile unattach/attach
;Command to attach a techfile?
techBindTechFile(<lib_id> <techfile_id>)
;Is there a skill techfile command to detach a techfile?
techUnattachTechFile(ddGetObj("<libname>")

tf = makeInstance( 'techfile )
setName(tf "PLL_80B")
getTechFileRef(tf)
tf->ref->??
unattachAllTechFiles(tf)
attachTechFile(tf "fooTech")
attachTechFile(tf "RRFC_2metal")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 5.1 Skill Version
procedure( techBridgeAttach( libName bridgeName)
  let((libRef bridgRef attachName )
    libRef = ddGetObj(libName)
    bridgeRef = ddGetObj(bridgeName)
    attachName = techGetTechLibName(libRef)
    printf("INFO: %s library is currently attached to %s library\n n" libName attachName)
    techUnattachTechFile(libRef)
    techBindTechFile(libRef bridgeName "tech.db" t)
    attachName = techGetTechLibName(libRef)
    printf("INFO: %s library is now attached to %s library\n" libName attachName)
  );
);procedure

techBridgeAttach( "ASML" "RRFC_2metal")
techBridgeAttach( "ganLib" "RRFC_2metal")
techBridgeAttach( "XYnumbers" "RRFC_2metal")