;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for class existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'library )
lib = makeInstance( 'library )
classp(lib 'library)
classOf(lib)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generates a list of the libs
;       contained in the target cds.lib
;       library
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'library )
genLibList(lib)
lib->libList->elems


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FIXME: Following tests were used
;        to test toggling individual
;        libraries on and off. Codes
;        was removed due to problems
;        with Linting. Need to create
;        a hash class and do the toggling
;        with hashes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-?: Tests the toggling of library
;       enables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'library )
lib->name = "Conversion"
lib->name
genLibList(lib)
lib->libList->elems
lib->enables->elems
toggleLibEnable(lib "ASML" )
toggleLibEnable(lib "ASML" )

toggleLibEnable(lib "CommonOverhead" )
toggleLibEnable(lib "avTech" )
toggleLibEnable(lib "cdsDefTechLib" )
lib->libList->elems
lib->enables->elems

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-?: Tests the population of the
;       library object list. 
;       NO LIBRARY TOGGLING!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'library )
lib->name = "Conversion"
lib->name
genLibList(lib)
lib->enables->elems
lib->libList->elems
length(lib->enables->elems)
length(lib->libList->elems)
;##########
genObjList(lib)
;##########
lib->objList
length(lib->objList)

lib->enables->elems
lib->enLibList
lib->libList->elems

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-?: Tests the population of the
;       library object list. 
;       LIBRARY TOGGLING!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'library )
lib->name = "Conversion"
lib->name
genLibList(lib)
lib->enables->elems
lib->libList->elems
length(lib->enables->elems)
length(lib->libList->elems)
; toggle these libraries off
toggleLibEnable(lib "US_8ths" )
toggleLibEnable(lib "avTech" )
toggleLibEnable(lib "cdsDefTechLib" )
toggleLibEnable(lib "basic" )
toggleLibEnable(lib "rfLib" )
toggleLibEnable(lib "rfExamples" )
toggleLibEnable(lib "analogLib" )
toggleLibEnable(lib "functional" )
toggleLibEnable(lib "ahdlLib" )

;##########
genObjList(lib)
;##########
lib->objList
length(lib->objList)

lib->libList->elems
lib->enables->elems
lib->enLibList

length(lib->enLibList)
length(lib->enables->elems)
length(lib->libList->elems)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-?: Populate the child object list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'library )
lib->name = "Conversion"
genLibList(lib)
toggleLibEnable(lib "US_8ths" )
toggleLibEnable(lib "avTech" )
toggleLibEnable(lib "cdsDefTechLib" )
genObjList(lib)
popObjList(lib)
lib->objList
; Individual test
tl0=nth(0 lib->objList)
tl0->name
tl0->techLib->techFileName
; looped test
i=0
foreach( lib lib->objList 
	 libName=lib->name
	 techName=lib->techLib->techFileName
	 printf("%d: LIBRARY: %s -> TECHFILE: %s\n", i libName techName)
	 i=i+1
);foreach

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-?: Ecapsulate in a callable 
;       skill procedure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( techFileMapIls()
	   let( (lib
	   	 (i 0)
		 fp)
		fp = outfile("/users/1127110/techmap_ils.csv")		
	   	lib = makeInstance( 'library )
	   	lib->name = "Conversion"
	   	genLibList(lib)
	   	toggleLibEnable(lib "CommonOverhead" )
	   	toggleLibEnable(lib "avTech" )
	   	toggleLibEnable(lib "cdsDefTechLib" )
	   	genObjList(lib)
	   	popObjList(lib)
	   	lib->objList
		foreach( lib lib->objList 
	 		 libName=lib->name
	 		 techName=lib->techLib->techFileName
	 		 printf("%d: LIBRARY: %s -> TECHFILE: %s\n", i libName techName)
			 fprintf( fp "%s, %s\n" libName techName)
	 		 i=i+1
		);foreach
		close(fp)
	);let
);procedure


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-?: Standard Skill file to generate
;       techfile mapping to check 
;       OOP model. This list is 
;       UNTOGGLED orignal list.
;       This is a good test to make sure
;       a standard skill procedure has
;       the same functionality as a 
;       skill++ class method
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( techFileMapIl()
 	   let( (libListRef
	   	 libNameList
		 techNameList
		 fp
		 libRef
		 libName 
		 techRef
		 techName)		 
	   	 libListRef = ddGetLibList()
	   	 libNameList = '()
	   	 techNameList = '()
	   	 fp = outfile("/users/1127110/techmap_il.csv")
	   	 for( i 0 sub1(length(libListRef))
     	   	      libRef=nth(i libListRef)
     		      libName = libRef->name
     		      libNameList=cons(libName libNameList)
     		      techRef = techGetTechFile(ddGetObj(libRef->name))
     		      techName = techRef->libName
     		      techNameList= cons(techName techNameList)	      
		      if( !(libName == nil) && !(techName == nil) then
		      	fprintf( fp "%s, %s\n" libName techName)
     		      	printf("%d: LIBRARY: %s -> TECHFILE: %s\n" i libName techName)
		      else
			printf("%d: Returned nil values" i)	
		      );if   
	   	 );for
	   	 close(fp)
	   );let
);procedure


libListRef = ddGetLibList()
libName="P81_eng"
techRef = techGetTechFile(ddGetObj(libName))
techRef->libName

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-?: Standard Skill file to generate
;       techfile mapping to check 
;       OOP model. This list is 
;       UNTOGGLED orignal list.
;       This is a good test to make sure
;       a standard skill procedure has
;       the same functionality as a 
;       skill++ class method. This procedure
;       has been modified to unattach the
;       techlib from the library if it does
;       not match the input argument, and
;       in this attach the input argument's 
;       techfile to the library
;       Perhaps break it into separate
;       unattach procedures more closely
;       matching methods that would be :
;       called from the technology library
;       classs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; FIXME: Cadence 6p1: Also need rename library method in the 
; library class. Need to ensure the re-name
; properly handles cross library references. Need to finish
; off my library sniffer ...

procedure( detachTechFile()
);procedure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( attachTechFile()
);procedure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( attachRRFCTechFilel()
 	   let( (libListRef
	   	 libNameList
		 techNameList
		 fp
		 libRef
		 libName 
		 techRef
		 techName)		 
	   	 libListRef = ddGetLibList()
	   	 libNameList = '()
	   	 techNameList = '()
	   	 fp = outfile("/users/1127110/techmap_il.csv")
	   	 for( i 0 sub1(length(libListRef))
     	   	      libRef=nth(i libListRef)
     		      libName = libRef->name
     		      libNameList=cons(libName libNameList)
     		      techRef = techGetTechFile(ddGetObj(libRef->name))
     		      techName = techRef->libName
     		      techNameList= cons(techName techNameList)	      
		      if( !(libName == nil) && !(techName == nil) then
		      	fprintf( fp "%s, %s\n" libName techName)
     		      	printf("%d: LIBRARY: %s -> TECHFILE: %s\n" i libName techName)
		      else
			printf("%d: Returned nil values" i)	
		      );if   
	   	 );for
	   	 close(fp)
	   );let
);procedure


libListRef = ddGetLibList()
libName="P81_eng"
techRef = techGetTechFile(ddGetObj(libName))
techRef->libName

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-?: Tests the generation of original
;       creating and last touched dates
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'library )
lib->name = "Conversion"
lib->name
genLibList(lib)
lib->enables->elems
lib->libList->elems
length(lib->enables->elems)
length(lib->libList->elems)
; toggle these libraries off
toggleLibEnable(lib "US_8ths" )
toggleLibEnable(lib "avTech" )
toggleLibEnable(lib "cdsDefTechLib" )
toggleLibEnable(lib "basic" )
toggleLibEnable(lib "rfLib" )
toggleLibEnable(lib "rfExamples" )
toggleLibEnable(lib "analogLib" )
toggleLibEnable(lib "functional" )
toggleLibEnable(lib "ahdlLib" )

;##########
genObjList(lib)
;##########
; looped test
i=0
foreach( lib lib->objList 
	 libName=lib->name
	 techName=lib->techLib->techFileName
	 printf("%d: LIBRARY: %s -> TECHFILE: %s\n", i libName techName)
	 i=i+1
);foreach

;########################################
; Experimental
;########################################


; This an UT output for regression testing
fp = outfile("ut1.txt")
foreach( name lib->cellNameList 
	 fprintf( fp "%s\n" name)
) 	
close(fp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-N: This test tests the encapsulation
;       of all the cells in the target 
;       libary into layout cell objects
;       using the layCell class
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'library )
lib->name = "XYnumbers"
lib->name
genLibCellList(lib)
lib->cellNameList

;Instantiate a layout cell object
cell = makeInstance( 'layCell )
;Populate its members
cell->library = "XYnumbers"
cell->cellName = nth(0 lib->cellNameList)
cell->viewName = "layout"
;Get the target cell and dump it's attributes
getAttrList(cell)
;Inspect the attribute member of the cell object
cell->attr
getAttrValueByKey(cell "libName")
getAttrValueByKey(cell "cellName")
getAttrValueByKey(cell "DBUPerUU")
getAttrValueByKey(cell "userUnits")
getAttrValueByKey(cell "isParamCell")
getAttrValueByKey(cell "subMasters")
getAttrValueByKey(cell "superMasters")

foreach( name lib->cellNameList
	 cell = makeInstance( 'layCell )
	 cell->cellName = name
	 cell->library = "XYnumbers"
	 dbu = getAttrValueByKey(cell "DBUPerUU")
	 uun = getAttrValueByKey(cell "userUnits")
	 printf("%s , UU: %s, DBU: %n \n", name uun dbu)
)

techGetDefaultTechName

tf = techGetTechFile(ddGetObj("XYnumbers"))

tf->??

gridSet = techIsMfgGridResolutionSet(tf)
mfgGrid = techGetMfgGridResolution(tf)

techFindViaDefByName(tf "via_metal")

techGetDeviceInClass(tf "controls" "techParams")


techGetParams(tf)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-: Testing the generation of
;       library lists 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'library )
getLibList(lib)
lib->libList

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Generating a list of cells in
;  a library - belongs in lib class  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib=ddGetObj("libname")
lib~>cells~>name
lib~>cells

foreach(mapcar cell lib~>cells list(cell~>name cell)




