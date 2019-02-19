;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0; Existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'stream )
strm = makeInstance( 'stream )
classp( strm 'stream)
classOf(strm)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Stream out a test layout
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="ln0246"
name="ln246_3p_wafer_flat_copy"
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
; UT-2: Stream out using member variables
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
setMapPath(strm "/users/1127110/cad/scripts/skilldev/stream/")
setMapFile(strm "layer.map")
streamOut(strm)

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