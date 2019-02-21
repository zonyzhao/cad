;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0; Existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'stream )
strm = makeInstance( 'stream )
classp( strm 'stream)
classOf(strm)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Stream out a test layout using a FIXED template file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="ln0246"
name="ln246_3p_wafer_flat"
view="layout"
strm = makeInstance( 'stream )
setName(strm name)
setLib(strm lib)
setView(strm view)
setTemplatePath(strm "/users/1127110/cad/scripts/skilldev/stream")
setTemplateFile(strm "ln246_3_p_wafer_vias_output.template")
getTemplateTarget(strm)
streamOut(strm)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Stream in a test GDS using a FIXED template file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pa0715_sfw"
name="ln246_3p_wafer_flat"
view="layout"
strm = makeInstance( 'stream )
setName(strm name)
setLib(strm lib)
setView(strm view)
setTemplatePath(strm "/users/1127110/cad/scripts/skilldev/stream")
setTemplateFile(strm "ln246_3_p_wafer_vias_input.template")
getTemplateTarget(strm)
streamIn(strm)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Test generation of .streamOutKvps and stream output template files
;       from member variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="ln0246"
name="ln246_3p_wafer_flat"
view="layout"
strm = makeInstance( 'stream )
setName(strm name)
setLib(strm lib)
setView(strm view)
setStrmFile(strm "ln246_3p_wafer_vias.gds")
setRunDir(strm "/users/1127110/deslibs_oa/ln0246/release/")
setMapPath(strm "/net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa/cad/maps/trunk/")
setMapFile(strm "via_layer.map")
createOutputKvps(strm)
createOutputTemplateFile(strm)
getTemplateTarget(strm)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Test generation of .streamInKvps and stream input template files
;       from member variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pa0715_sfw"
name="ln246_3p_wafer_flat_streamIn"
view="layout"
strm = makeInstance( 'stream )
setName(strm name)
setLib(strm lib)
setView(strm view)
setTechFile(strm "RRFC_2metal")
setStrmFile(strm "ln246_3p_wafer_vias.gds")
setRunDir(strm "/users/1127110/deslibs_oa/ln0246/release/")
setMapPath(strm "/net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa/cad/maps/trunk/")
setMapFile(strm "rrfc_2metal.map")
createInputKvps(strm)
createInputTemplateFile(strm)
getTemplateTarget(strm)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Stream out using member variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pa0715_sfw"
name="ln246_3p_wafer_flat"
view="layout"
strm = makeInstance( 'stream )
setName(strm name)
setLib(strm lib)
setView(strm view)
setStrmFile(strm "ln246_3p_wafer_vias.gds")
setRunDir(strm "/users/1127110/deslibs_oa/ln0246/release/")
setMapPath(strm "/net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa/cad/maps/trunk/")
setMapFile(strm "via_layer.map")
getTemplateFile(strm)
getTemplatePath(strm)
getTemplateTarget(strm)
streamOut(strm)
getTemplateTarget(strm)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Stream in using member variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pa0715_sfw"
name="ln246_3p_wafer_vias"
view="layout"
strm = makeInstance( 'stream )
setName(strm name)
setLib(strm lib)
setView(strm view)
setTechFile(strm "RRFC_2metal")
setStrmFile(strm "ln246_3p_wafer_vias.gds")
setRunDir(strm "/users/1127110/deslibs_oa/ln0246/release/")
setMapPath(strm "/net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa/cad/maps/trunk/")
setMapFile(strm "rrfc_2metal.map")
getTemplateTarget(strm)
streamIn(strm)
getTemplateTarget(strm)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Experimental Code
; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
defun(CCSrunStrmout (lib cell view)
	let((streamOutKeys templateFile prt id)
	    streamOutKeys=ncons(nil)
	    streamOutKeys->libName=lib
	    streamOutKeys->primaryCell=cell
	    streamOutKeys->viewName=view
	    streamOutKeys->outFile="PIPO.log"
	    streamOutKeys->errFile="PIPO.err"
	    templateFile=makeTempFileName("./streamOutKeys")
	    prt=outfile(templateFile)
	    fprintf(prt "streamOutKeys='")
	    pprint(streamOutKeys prt)
	    newline(prt)
	    close(prt)
	    id=ipcBeginProcess(
		sprintf(nil "pipo strmout %s" templateFile)
		""
		CCSstrmDataHandler
		CCSstrmDataHandler
		CCSstrmExitHandler
	    ) ; ipcBeginProcess
            ; use ipcWait(id) if you want to wait for it to finish
	) ; let
    ) ; defun

    defun(CCSstrmDataHandler (_id data)
        printf("%s" data)
    )

    defun(CCSstrmExitHandler (_id status)
        printf("Stream Out exited with status %L\n" status)
    )


procedure( prbLoadXynDpl()
  let( ( fn fp dpl p)

;   read the dpl data file created by xyn.il:
    fn = strcat( prbpl->relDir "xynumbers.dpl")
    fp = infile( fn)
    cond(
      ( fp
	dpl = car( lineread( fp))
	close( fp)

;	copy properties from the dpl to the local global prbpl:
;	(this loop skips the 1st nil, then copies each name/value pair)
	p = cdr( dpl)
	while( p

	  putprop( prbpl cadr( p) car( p))

;	  also make sure current xynpl property values match prbpl:
	  putprop( xynpl cadr( p) car( p))
	  p = cddr( p)
	)

;	determine the total number of real chips and coupons:
	prbCountChips()
	prbMsg( "read %s" fn)

;	open the wafer drawings:
	prbpl->wafCV = dbOpenCellViewByType( prbpl->libName prbpl->wafName "layout"
			 "maskLayout" "r")
	prbpl->flatCV = dbOpenCellViewByType( prbpl->libName prbpl->flatName "layout"
			  "maskLayout" "r")
	cond(
	  ( null( prbpl->wafCV)
	    prbErr( "failed to open cellview %s/%s/layout" 
		    prbpl->libName prbpl->wafName)
	    nil
	  )
	  ( null( prbpl->flatCV)
	    prbErr( "failed to open cellview %s/%s/layout" 
		    prbpl->libName prbpl->flatName)
	    nil
	  )
	  ( t
	    t
	  )
	)
      )
      ( t
	prbErr( "failed to read xyn data file file %s" fn)
	nil
      )
    )
  )
)

lst = list("a" "b" "c" "d")

while(lst
  key = pop(lst)
  val = pop(lst)
  printf("%s\n" strcat(key " " "\"" val "\""))
);while

printf("%s\n" strcat(key " " "\"" val "\""))