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
setName(tf "XYnumbers")
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
setName(tf "XYnumbers")
getTechFileRef(tf)
setAttrList(tf)
tf->attributes

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Get attribute value 
;       by attribute key
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tf = makeInstance( 'techfile )
setName(tf "XYnumbers")
tid=getTechFileRef(tf)
setAttrList(tf)
getAttrValueByKey(tf "libName")
getAttrValueByKey(tf "processFamily")
getAttrValueByKey(tf "hasConflict")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5: set the list of layer names
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tf = makeInstance( 'techfile )
setName(tf "RRFC_2metal")
tid=getTechFileRef(tf)
setTechLayers(tf)
printLayers(tf)


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
