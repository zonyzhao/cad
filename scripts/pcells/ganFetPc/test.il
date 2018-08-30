;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Dependency 
;        Existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'ganFet )
gf = makeInstance( 'ganFet )
classp( gf 'ganFet )
classOf(gf)
className(findClass( 'ganFet ))
superclassesOf(classOf(gf))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Preview the ganFet layout
;       prior to commiting to PCELL
;       supermaster
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gf = makeInstance( 'ganFet )
lib = "pd0164"
name = "ganFetPreview"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "w")
setRef(gf cv)
generate(gf)
render(gf)
;setRef(gf->rtrans->rtran cv)
; FIXME: Rendering of the geom bbox is broken ...
;render(gf->rtrans->rtran)
;cv~>bBox
;gf->coreBBox
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: PCELL generation code
;       for creating the gate
;       supermaster PCELL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pcDefinePCell(
  list( ddGetObj("test") "gateTest" "layout")
  (
    ( width "float" 50.0 )
    ( length "float" 0.25 )
  )
  let( (pcell)
    pcell = makeInstance( 'pcgate )
    setRef(pcell pcCellView)
    setPcellParams(pcell pcCellView)
    draw(pcell)
  );let
);pcDefinePCell

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: PCELL definition file 
;       generation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Start of file - genPcDef.il
; Generate Pcell definition file in user specified directory 
; based on specified name, lib name, cell name, and draw function
; 
; getPcellCodeFromClass( 
;        s_className t_libName t_cellName t_viewName t_pcFilename t_drawFuncName)
; Ex:
: getPcellCodeFromClass( 'pcgate "test" "gateTest" "layout" "./pcGate.il" "draw")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Auto generate Pcell superMaster by user defined Pcell class
; load(filePathName)
; load("pcGate.il")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( getPcellCodeFromClass(
	   _className libN cellN viewN filePathName drawFuncName)
  let((oport params device str dirpath)
  when( !filePathName || filePathName == ""
    warn("File path name is empty.\n")
    return()
  ); when
  oport = outfile(filePathName "w")
  fprintf(oport "pcDefinePCell(\n\tlist(ddGetObj(\"%s\") \"%s\" \"%s\")\n" libN cellN viewN)
  ; Output parameters section
  device = makeInstance(concat(_className))
  fprintf(oport "\t(\n")
  params = getPcellParams(device)
  foreach( param params
  	   case( cadr(param)
	   	("int"
			fprintf(oport "\t\t( %s \"int\" %d)\n" car(param) caddr(param))
           	);int
	   	("float"
			fprintf(oport "\t\t( %s \"float\" %f)\n" car(param) caddr(param))
           	);float
  	   	("string"
			fprintf(oport "\t\t( %s \"string\" %s)\n" car(param) caddr(param))
           	);string
	   	("boolean"
			fprintf(oport "\t\t( %s \"boolean\" %L)\n" car(param) caddr(param))
           	);boolean
	   	("ILList" "ilList"
			fprintf(oport "\t\t( %s \"ILList\" %L)\n" car(param) caddr(param))
           	);ILList
	   	(t
			 warn("Unsupported type %s on parameter %s skipped\n" car(param) caddr(param))
           	);t
	  );case
   );foreach
   fprintf(oport "\t\n")
   ; Output the standard Pcell code section
   fprintf(oport "\tlet(pcell)\n")
   fprintf(oport "\t\tpcell = makeInstance('%s)\n" _className)
   fprintf(oport "\t\tsetPcellParams(pcell pcCellView)\n") 
   fprintf(oport "\t\t%s(pcell)\n" drawFuncName)
   fprintf(oport "\t)")
   fprintf(oport ")\n")
   close(oport)
   );let
);procedure