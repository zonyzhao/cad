;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; phofo.il: FIXME: name should be same as main procedure photoInfo()
;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
phopl = '( nil
  design  	"" 
  primary	""
  dropin	""
  procTypes	("P46F" "P46H" "P51E" "P51F" "P51G" 
                 "P60D" "P60H" "P60J" "P60K" "P70A"
		 "P80A" "P80B" "P81" "P82" "D83" "P85"
                 "D91")
  process 	"P46H"
  winId		nil
  cv		nil
  cvSec         nil
  xStepPri	0
  yStepPri	0
  xStepSec	0
  yStepSec	0	
  xStepOat	0
  yStepOat	0
  print		t	
  priCells 	nil
  secCells      nil
  alignCells    nil
  alignSecCells nil
  oatCells	nil
  junkCells	nil
  junkSecCells  nil
  Gmarks	nil
  GmarksSec     nil
  BnB		nil
  BnBSec        nil
  Metro		nil
  MetroSec      nil
  dfas		nil
  dfasSec       nil
  oldStyleCells nil
  qtrX		0
  qtrY		0
  qtrXSec	0
  qtrYSec	0
  qtrCenX	0
  qtrCenY	0
  qtrSecCenX	0
  qtrSecCenY	0
  NEcenter	nil
  SWcenter	nil
  NWcenter	nil
  SEcenter	nil
  NEcenterSec	nil
  SWcenterSec	nil
  NWcenterSec	nil
  SEcenterSec	nil
  dfasQtr	nil
  dfasQtrSec	nil
  gmarkQtr	nil
  gmarkQtrSec	nil
  newStyleCells nil
  mpss		t  
  libPath	""
  release	""
  port		""
  mofport	""
  eBeam         "Leica"
  multi         nil
  Lmarks        nil
  LmarksSec     nil
)
;		)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Main Procedure Call
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure(photoInfo()
  tmpCellData = nil
  allCellData = nil
  
  ; Set UI form data based on currently open cv window
  kwSetFormData()
  ; Creates the UI
  kwCreateForm()
  ; A set of callbacks that copies variables from
  ; the photoForm variables inot the phopl variables??
  kwTriggerCBs()
  ; Helper procedure that sets the pholp->release and
  ; and phopl->libPath variables
  kwCreateRelDirIfNec()
  ; Maps old and new naming conventions into a 
  ; common naming convention
  kwNamingConvention()
  ; Sorts the cells of the primary and finds all alignment marks
  kwGetPriCellsB()
  ; Generates a list of cells in "dropin" (This is different than secondary!?!) 
  ; - no explicit alignment mark checks in the "dropin"
  kwGetOatCells()
  ; Scans throough Each Primary Cell and looks for cell names
  ; with "GM", "global_mar", "ASML_PM", and "ASML_SPM"
  ; "Weeds" these cells out of the primary cell list
  kwGetGlobalMarks()
  ; Scans throough Each Primary Cell and looks for cell names
  ; with "dfas", "isi"
  ; "Weeds" these cells out of the primary cell list
  kwGetDFASkeys()
  ; For each DFAS key detected:
  ;  puts the DFAS key into a bin based upon its name
  kwEvaluateDFASkeys()
  ; Scans through the list of remaining primary cells for "boxnbox" cell name
  ; and removes them from the primary cell list and adds them to the 
  ; phopl->BnB list
  kwGetBoxnBox()
  ; 1.) Scans through the list of remaining primary cells for "MetroFet" and
  ; "metroFET"  cell
  ; 2.) add a list of the MetroFet name, position and oriention
  ; 3.) add the list in step 2.) to the phopl->Metro list
  ; 4.) Call getMetroFET() recursively to process the rest of the
  ;     heirarchy (depth-first-recursive search of heirarchy)
  getMetroFET(phopl->cv)
  ; Based upon some crazy naming conventions weed out "junkCells" 
  ; and aligment cells from the primary cell list
  ; Add these weeded cells to the following lists:
  ; phopl->junkCells
  ; phopl->alignCells
  kwWeedPriCells()
  ; Weed the "OatCells" with "boxnbox" and "rners" in their name
  ; Add these cells to the  phopl->junkCellsOat list
  kwWeedOatCells()

  if(phopl->multi then
    ; NOTE: Multi-Image mask just means you have a secondary!?!
    ; Repeat of getPriCells() on secondary
    getSecCells()
    ; Repeat of getGlobalMarks() on secondary
    getSecGlobalMarks()
    ; Repeat of getDFASkeys() on secondary
    getSecDFASkeys()
    ; Repeat of evaluateDFASkeys() on secondary
    evaluateSecDFASkeys()
    ; Repeat of getBoxnBox() on secondary
    getSecBoxnBox()
    ;################################################################################
    ; New version of getMetroFET() using the generic heirarchy search procedure
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    GLOBAL_INST = list()
    cv = dbOpenCellViewByType(phopl->design phopl->dropin "layout" "maskLayout" "a")
    name = "MetroFet"
    getAllInstances(cv name)
    phopl->MetroSec = GLOBAL_INST
    ;################################################################################
    ; Repeat kwWeedPriCells() on secondary
    weedSecCells()
  );if
  
  if(phopl->print then
    kwCreateOutFile()
    kwGetStepAndRepeat()
    kwGetQtrCenData()
    kwPrintData()
    kwGetQtrPrintData()
    kwPrintQtrInfo()
    if(phopl->multi then
      getSecStepAndRepeat()
      getSecQtrCenData()
      printSecData()
      getSecQtrPrintData()
      printSecQtrInfo()
    );if
    close(phopl->port)
  )
  if( phopl->mpss then
    mpss(phopl->multi)
    printf("t\n")
  )

)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( kwCreateForm()
  prog((design retName primaryName dropinName ebeamOpt)

    ebeamOpt = list("Aeble" "Leica" "None")
/*  Setting up the form */ 
	Fld1 = hiCreateStringField(
    	?name		'design
       	?prompt		"Design Name (ex pa0999) "
		?value		""
		?defValue	phopl->design	
		?callback	"designCB()"
)
	Fld2 = hiCreateStringField(
		?name		'retName
		?prompt		"Primary Reticle"
		?value		""
		?defValue	phopl->primary	
		?callback	"primaryCB()"
)
    Fld3 = hiCreateStringField(
		?name       'dropinName
		?prompt     "Dropin Reticle"
		?value      ""
		?defValue   oatName
        ?callback   "dropinCB()"
)
    Fld4 = hiCreateRadioField(
		?name       'process
		?choices   	phopl->procTypes 
		?prompt     "Process: "
		?callback   '("processCB()") 
)
    Fld5 = hiCreateBooleanButton(
        ?name       'printfile
        ?buttonText "createFile"
		?value		t		
		?callback	"printfileCB()"
)
    Fld6 = hiCreateRadioField(
		?name       'eBeamMach
		?choices    ebeamOpt 
		?prompt     "eBeam: "
		?defValue      "Leica"
		?callback   '("eBeamCB()") 
)
    Fld7 = hiCreateBooleanButton(
        ?name       'mpssVal
        ?buttonText "Create MPSS: "
		?defValue	t		
		?callback	"mpssCB()"
)
    Fld8 = hiCreateBooleanButton(
        ?name       'multiVal
        ?buttonText "MultiImage Mask: "
        ?defValue    nil
        ?callback   "multiCB()"
)

	photoForm = hiCreateAppForm(
		?name	'photoForm
		?fields list(Fld1 Fld2 Fld3 Fld4 Fld5 Fld6 Fld7 Fld8)
		?dialogStyle	'modeless
 		)
	hiDisplayForm(photoForm)
))

; assigning the data to their variable names
; through callbacks

procedure( designCB()
  phopl->design = photoForm->design->value
)
procedure( primaryCB()
  phopl->primary = photoForm->retName->value
)
procedure( dropinCB()
  phopl->dropin = photoForm->dropinName->value
)
procedure( processCB()
  phopl->process = photoForm->process->value
)
procedure( eBeamCB()
  phopl->eBeam = photoForm->eBeamMach->value
)
procedure( mpssCB()
  phopl->mpss = photoForm->mpssVal->value
)
procedure( printfileCB()
  phopl->print = photoForm->printfile->value
)
procedure( multiCB()
  phopl->multi = photoForm->multiVal->value
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Sets the UI form data based on the currently open cellview window
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( kwSetFormData()
  let( (win cv)
    win=hiGetCurrentWindow()
    phopl->winId = win
    cv = geGetWindowCellView(win)
    phopl->cv = cv
    sepPos=strlen(cv~>cellName)-1 ; returns number chars -1
    oatName=substring(cv~>cellName 1 sepPos)
    oatName=strcat(oatName "s")
    phopl->design = cv~>libName
    phopl->primary= cv~>cellName
    phopl->dropin = oatName
  )
)


procedure( kwTriggerCBs()
  designCB()
  primaryCB()
  dropinCB()
  processCB()
  printfileCB()
)

procedure( kwCreateRelDirIfNec()
  phopl->libPath = ddGetObjReadPath( ddGetObj( phopl->design))
  sprintf(dir "%s/release" phopl->libPath)
  phopl->release = dir
  if(!isDir(phopl->release) then
    createDir(phopl->release)
  )
)

procedure( kwCreateOutFile()
  sprintf(file "%s/%s.photo" phopl->release phopl->design)
  port = outfile(file) 
  phopl->port = port	
  if(phopl->port == nil then
    hiGetAttention()
    sprintf( buf "Unable to create file:  %s\n" file)
    hiDisplayAppDBox( ?name 'photo4nfo0 ?dboxBanner "Warning" ?dboxText buf)
    return(nil)
  )
  fprintf(phopl->port "Design:  %s \n", phopl->design)
  fprintf(phopl->port "Primary:  %s \n", phopl->primary)
  fprintf(phopl->port "Dropin:  %s \n", phopl->dropin)
  fprintf(phopl->port "Process Type:  %s \n", phopl->process)
)


procedure( kwGetStepAndRepeat()
  let((xStep yStep CellbBox Xint Yint)
    CellbBox = phopl->cv~>bBox
    xStep = abs(car(car(CellbBox))) + car(cadr(CellbBox))
    yStep = abs(cadr(car(CellbBox))) + cadr(cadr(CellbBox))
    Xint = atoi(sprintf( newXvalue "%f", xStep))
    Yint = atoi(sprintf( newYvalue "%f", yStep))

    if(( xStep == Xint ) && (yStep == Yint ) then
      if((( mod( fix(xStep) 5 ) == 4) && (mod( fix(yStep) 5) == 4)) then
	fprintf(phopl->port "Step and Repeat:  %8.2f %8.2f \n", xStep-4 yStep-4)
      else
	hiGetAttention()
	hiDisplayAppDBox( ?name 'photoInfo0 ?dboxBanner "Warning" ?dboxText
	"Step and Repeat is incorrect, check and fix in .photo file")
	fprintf(phopl->port "Step & Repeat: Check and Fix \n")
      )
    else
      hiGetAttention()
      hiDisplayAppDBox( ?name 'photoInfo0 ?dboxBanner "Warning" ?dboxText
      "Step & Repeat is not correct, check and fix in .photo file")
      fprintf(phopl->port "Step & Repeat: Check and Fix \n")
    )

    phopl->xStepPri = xStep-4
    phopl->yStepPri = yStep-4
  )
)

procedure( getSecStepAndRepeat()
  let((xStep yStep CellbBox Xint Yint)
    CellbBox = phopl->bBoxSec
    xStep = abs(car(car(CellbBox))) + car(cadr(CellbBox))
    yStep = abs(cadr(car(CellbBox))) + cadr(cadr(CellbBox))
    Xint = atoi(sprintf( newXvalue "%f", xStep))
    Yint = atoi(sprintf( newYvalue "%f", yStep))
    if(( xStep == Xint ) && (yStep == Yint ) then
      if((( mod( fix(xStep) 5 ) == 4) && (mod( fix(yStep) 5) == 4)) then
	fprintf(phopl->port "Secondary Step and Repeat:  %8.2f %8.2f \n", xStep-4 yStep-4)
      else
	hiGetAttention()
	hiDisplayAppDBox( ?name 'photoInfo0 ?dboxBanner "Warning" ?dboxText
	"Secondary Step and Repeat is incorrect, check and fix in .photo file")
	fprintf(phopl->port "Secondary Step & Repeat: Check and Fix \n")
      )
    else
      hiGetAttention()
      hiDisplayAppDBox( ?name 'photoInfo0 ?dboxBanner "Warning" ?dboxText
      "Secondary Step & Repeat is not correct, check and fix in .photo file")
      fprintf(phopl->port "Secondary Step & Repeat: Check and Fix \n")
    )

    phopl->xStepSec = xStep-4
    phopl->yStepSec = yStep-4
  )
)

procedure( kwNamingConvention()
  let((nameStyle)
    nameStyle = 
      case(phopl->process
	("P46F" '("mmc46" "p46"))
	("P46H" '("mmc46" "p46"))
	("P51E" '("mmc51" "p51"))
	("P51F" '("mmc51" "p51"))
	("P51G" '("mmc51" "p51"))
	("P60D"	'("mmc60" "p60"))
	("P60H"	'("mmc60" "p60"))
	("P60J"	'("mmc60" "p60"))
	("P60K"	'("mmc60" "p60"))
	("P70A"	'("mmc70" "p70"))
	("P80A"	'("mmcP80" "p80"))
	("P80B"	'("mmcP80" "p80"))
	("P81"	'("mmcP81" "p81"))
	("P82"	'("mmcP82" "p82"))
	("P85"	'("mmcP85" "p85"))
	("D83"	'("mmcD83" "d83"))
	("D91"	'("mmcD91" "d91"))
      )

      phopl->oldStyle = car(nameStyle)
      phopl->newStyle = cadr(nameStyle)
  )
)

procedure( kwGetPriCells()
tmpPriCell = nil
foreach( cell phopl->cv~>instances
if(((strncmp(cell~>cellName phopl->oldStyle 5 ) == 0) || 
    (strncmp(cell~>cellName phopl->newStyle 3 ) == 0) ||
     rexMatchp("gan_1" cell~>cellName) ||
     rexMatchp("gaas_1" cell~>cellName)) 
		then
		name  	=   cell~>cellName
		xy    	=   cell~>xy
		orient	=   cell~>orient
	    		
		tmpPriCell = list(name xy orient)
		phopl->priCells= cons(tmpPriCell phopl->priCells)
)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Items within the primary that are being detected
; 1.) "Box in Box" alignment marks (BnB)
; 2.) "Global" marks
; 3.) "Leica" ebeam marks
; 4.) "Metro" FET structures
; 
; cell names substrings that are being searched for using
; a combination regular expressions and string compares 
; 1.) "gaas_1"
; 2.) "gan_1"
; 3.) "ASML"
; 4.) "_Leica_"
; 5.) "boxnbox", "_Leica_" : kwEvaluateBnB(cell) - evaluate "box in box" alignment marks
; 6.) "_grid_", "_L0_", "_grid_gaAs" : kwEvaluateGM(cell) evaluate "global" alignment marks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; phopl->priCells holds a list of all primary reticle cells which has the above named
;                 cells filtered out. Those cells are processed separately by: 
;                 kwEvaluateBnB(cell) and kwEvaluateGM(cell)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; kwEvaluateBnB(cell) adds all the valid BnB marks ("BNB") to the phopl->BnB list
;                     and adds all the valid Leica marks (phopl->Lmarks) to the 
;                     phopl->Lmarks lists
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( kwGetPriCellsB()
  let( (cellLength endOfCell tmpPriCell)
    tmpPriCell = nil
    phopl->BnB = nil
    phopl->Gmarks = nil
    phopl->Lmarks = nil
    phopl->Metro = nil
    phopl->priCells = nil
    foreach( cell phopl->cv~>instances
      cellLength = strlen(cell~>cellName)
      endOfCell = substring(cell~>cellName cellLength-6 cellLength)
      ; turns of regular expression meta character interpretation
      rexMagic(t)
      ;printf("%s %L\n" cell~>cellName cell~>xy)
      if(((strncmp(cell~>cellName phopl->oldStyle 5 ) == 0) ||
        (strncmp(cell~>cellName phopl->newStyle 3 ) == 0) ||
	rexMatchp("gaas_1" cell~>cellName) ||
	rexMatchp("gan_1" cell~>cellName) ||
	rexMatchp("ASML" cell~>cellName) ||
	rexMatchp("_Leica_" cell~>cellName)) then
	if(((strncmp(substring(cell~>cellName 7 7) "boxnbox" 7) == 0) ||
	  (strcmp(endOfCell "boxnbox") == 0) || rexMatchp("_Leica_" cell~>cellName)) then
          kwEvaluateBnB(cell)
	else
	  if( (rexMatchp("_grid_" cell~>cellName) && rexMatchp("_L0_" cell~>cellName)) || rexMatchp("_grid_gaAs" cell~>cellName) then
	    kwEvaluateGM(cell)
	  else
	    name    =   cell~>cellName
	    xy      =   cell~>xy
	    orient  =   cell~>orient
	    tmpPriCell = list(name xy orient)
	    phopl->priCells= cons(tmpPriCell phopl->priCells)
	  ):if
	);if
      );if
    );foreach
  );let
);procedure

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( getSecCells()
  let( (cv cellLength endOfCell tmpPriCell)
    tmpPriCell = nil
    phopl->BnBSec = nil
    phopl->GmarksSec = nil
    phopl->LmarksSec = nil
    phopl->MetroSec = nil
    phopl->secCells = nil
    cv = dbOpenCellViewByType(phopl->design phopl->dropin "layout" "maskLayout" "a")
    phopl->bBoxSec = cv~>bBox
    foreach( cell cv~>instances
      cellLength = strlen(cell~>cellName)
      endOfCell = substring(cell~>cellName cellLength-6 cellLength)

      rexMagic(t)
      ; mfp - added ASML to Global marks update in kwGetGlobalMarks() also
      ;printf("%s %L\n" cell~>cellName cell~>xy)

      if(((strncmp(cell~>cellName phopl->oldStyle 5 ) == 0) ||
	  (strncmp(cell~>cellName phopl->newStyle 3 ) == 0) ||
	  rexMatchp("gaas_1" cell~>cellName) ||
	  rexMatchp("gan_1" cell~>cellName) ||
	  rexMatchp("ASML" cell~>cellName) ||
	  rexMatchp("_Leica_" cell~>cellName)) then

	if(((strncmp(substring(cell~>cellName 7 7) "boxnbox" 7) == 0) ||
	    (strcmp(endOfCell "boxnbox") == 0) || rexMatchp("_Leica_" cell~>cellName)) then

	  kwEvaluateBnB(cell)
	else
	  if( (rexMatchp("_grid_" cell~>cellName) && rexMatchp("_L0_" cell~>cellName)) || rexMatchp("_grid_gaAs" cell~>cellName) then
	    kwEvaluateGM(cell)
	  else
	    name    =   cell~>cellName
	    xy      =   cell~>xy
	    orient  =   cell~>orient
	    tmpPriCell = list(name xy orient)
	    phopl->secCells= cons(tmpPriCell phopl->secCells)
	  )
	)
      )
    )
  )
)

procedure( weedSecCells()
  let( (cellLen cellName endOfCell junkCells newPriCells alignCells offsetX offsetY)
     	junkSecCells = nil
	newSecCells = nil
	alignSecCells = nil
	foreach(i phopl->secCells
	  cellName = car(i)
	  cellLen = strlen(cellName)
	  if((strncmp(cellName phopl->oldStyle 5 ) == 0) then
		endOfCell = substring(cellName cellLen-4 5)
		else
		endOfCell = substring(cellName cellLen-6 5)
	 )
	 if(((strcmp(endOfCell "_post") == 0) || (strcmp(endOfCell "_grid") == 0) ||
	     (strcmp(endOfCell "_grid") == 0) || rexMatchp("align_ur" cellName) ||
             rexMatchp("align_ul" cellName) || rexMatchp("align_lr" cellName) ||     
             rexMatchp("align_ll" cellName) || (strcmp(endOfCell "_mark") == 0) ||     
             (strcmp(endOfCell "fet51") == 0) || (strcmp(endOfCell "Probe") == 0) ||     
             (strcmp(endOfCell "_all4") == 0) || (strcmp(endOfCell "rPost") == 0) || 
             (strcmp(endOfCell "dSnap") == 0) || (strcmp(endOfCell "FET99") == 0) ||
	     (strcmp(endOfCell "sog_A") == 0) || (strcmp(endOfCell "bel_A") == 0)) then
	       if( rexMatchp("align_ul" cellName) || rexMatchp("align_lr" cellName) ||
	           rexMatchp("align_ur" cellName) || rexMatchp("align_ll" cellName) then
	       rexMagic(t)
	       cond( ( rexMatchp("_ul" cellName)
		         offsetX = 17
	 	         offsetY = -107 )
	             ( rexMatchp("_ur" cellName)
		         offsetX = -17
		         offsetY = -287 )
	             ( rexMatchp("_ll"  cellName)
		         offsetX = 17
		         offsetY = 407 )
	             ( rexMatchp("_lr" cellName)
		         offsetX = -17
		         offsetY = 227 )
	       );cond
            	 cellX = caadr(i)+offsetX
            	 cellY = cadadr(i)+offsetY
	    	 alignSecCells = cons(list(cellName cellX cellY) alignSecCells)
               else
	       junkSecCells = cons(i junkSecCells)
	     )
	     else
               newSecCells = cons(i newSecCells)
	     )
	     phopl->junkSecCells = junkSecCells
	     phopl->secCells = newSecCells
	     phopl->alignSecCells = alignSecCells
	   )
	)
) ;let & procedure

procedure( kwWeedPriCells()
let( (cellLen cellName endOfCell junkCells newPriCells alignCells)

junkCells = nil
newPriCells = nil
alignCells = nil

	foreach(i phopl->priCells
	cellName = car(i)
	cellLen = strlen(cellName)
	if((strncmp(cellName phopl->oldStyle 5 ) == 0)
		then
		endOfCell = substring(cellName cellLen-4 5)
		else
		endOfCell = substring(cellName cellLen-6 5)
	)
	
	if(((strcmp(endOfCell "_post") == 0) || (strcmp(endOfCell "_grid") == 0) ||
	    (strcmp(endOfCell "_grid") == 0) || rexMatchp("align_ur" cellName) ||
        rexMatchp("align_ul" cellName) || rexMatchp("align_lr" cellName) ||     
        rexMatchp("align_ll" cellName) || (strcmp(endOfCell "_mark") == 0) ||     
        (strcmp(endOfCell "fet51") == 0) || (strcmp(endOfCell "Probe") == 0) ||     
        (strcmp(endOfCell "_all4") == 0) || (strcmp(endOfCell "rPost") == 0) || 
        (strcmp(endOfCell "dSnap") == 0) || (strcmp(endOfCell "FET99") == 0) ||
	(strcmp(endOfCell "sog_A") == 0) || (strcmp(endOfCell "bel_A") == 0))
	then
	  if( rexMatchp("align_ul" cellName) || rexMatchp("align_lr" cellName) ||
	      rexMatchp("align_ur" cellName) || rexMatchp("align_ll" cellName) then
	    rexMagic(t)
	    cond( 
	      ( rexMatchp("_ul" cellName)
		offsetX = 17
		offsetY = -107 )
	      ( rexMatchp("_ur" cellName)
		offsetX = -17
		offsetY = -287 )
	      ( rexMatchp("_ll"  cellName)
		offsetX = 17
		offsetY = 407 )
	      ( rexMatchp("_lr" cellName)
		offsetX = -17
		offsetY = 227 )
	    )

            cellX = caadr(i)+offsetX
            cellY = cadadr(i)+offsetY

	    alignCells = cons(list(cellName cellX cellY) alignCells)
          else
	    junkCells = cons(i junkCells)
	  )
	else
		newPriCells = cons(i newPriCells)
	)

	phopl->junkCells = junkCells
	phopl->priCells = newPriCells
	phopl->alignCells = alignCells


)
)) ;let & procedure


procedure( kwWeedOatCells()
  let( (cellLen cellName endOfCell junkCells newOatCells)

    junkCells = nil
    newOatCells = nil

    foreach(i phopl->oatCells
      cellName = car(i)
      cellLen = strlen(cellName)
      if((strncmp(cellName phopl->oldStyle 5 ) == 0) then
	endOfCell = substring(cellName cellLen-4 5)
      else
	endOfCell = substring(cellName cellLen-6 5)
      )
      if( rexMatchp("boxnbox" cellName) || (strcmp(endOfCell "rners") == 0) then
	  junkCells = cons(i junkCells)
      else
	  newOatCells = cons(i newOatCells)
      )

      phopl->junkCellsOat = junkCells
      phopl->oatCells = newOatCells
    )
  )
)

procedure( kwGetQtrCenData()
  let( (tempX tempY)
    tempX = phopl->xStepPri
    tempY = phopl->yStepPri
    phopl->qtrX = phopl->xStepPri/2
    phopl->qtrY = phopl->yStepPri/2
    phopl->qtrCenX = phopl->qtrX/2
    phopl->qtrCenY = phopl->qtrY/2
    phopl->NEcenter = list(phopl->qtrCenX:phopl->qtrCenY) 
    phopl->SWcenter = list(-phopl->qtrCenX:-phopl->qtrCenY) 
    phopl->NWcenter = list(-phopl->qtrCenX:phopl->qtrCenY)
    phopl->SEcenter = list(phopl->qtrCenX:-phopl->qtrCenY) 
  )
)

procedure( getSecQtrCenData()
  let( (tempX tempY)
    tempX = phopl->xStepSec
    tempY = phopl->yStepSec
    phopl->qtrXSec = phopl->xStepSec/2
    phopl->qtrYSec = phopl->yStepSec/2
    phopl->qtrSecCenX = phopl->qtrX/2
    phopl->qtrSecCenY = phopl->qtrY/2
    phopl->NEcenterSec = list(phopl->qtrSecCenX:phopl->qtrSecCenY) 
    phopl->SWcenterSec = list(-phopl->qtrSecCenX:-phopl->qtrSecCenY) 
    phopl->NWcenterSec = list(-phopl->qtrSecCenX:phopl->qtrSecCenY)
    phopl->SEcenterSec = list(phopl->qtrSecCenX:-phopl->qtrSecCenY) 
  )
)

procedure( kwGetOatCells()
  tmpOatCell = nil
  phopl->oatCells = nil
  phopl->oatCV = dbOpenCellViewByType(phopl->design phopl->dropin "layout" "maskLayout" "a")

  foreach( cell phopl->oatCV~>instances
    if(((strncmp(cell~>cellName phopl->oldStyle 5 ) == 0) ||
	(strncmp(cell~>cellName phopl->newStyle 3 ) == 0)) then
      name    =   cell~>cellName
      xy      =   cell~>xy
      orient  =   cell~>orient

      tmpOatCell = list(name xy orient)
      if(! member(tmpOatCell phopl->priCells) then
	phopl->oatCells= cons(tmpOatCell phopl->oatCells)
      )
    )
  )
  dbClose(phopl->oatCV)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( kwGetGlobalMarks()
  let( (cellName cellLength endOfCell newPriCellList)
    newPriCellList = nil
    foreach( cell phopl->priCells
      if(rexMatchp("GM" car(cell)) || rexMatchp("global_mark" car(cell)) ||
	 rexMatchp("ASML_PM" car(cell)) || rexMatchp("ASML_SPM" car(cell)) then
	phopl->Gmarks = cons(cell phopl->Gmarks)
      else 
	newPriCellList = cons(cell newPriCellList)
      );if
    );foreach
    phopl->priCells = newPriCellList
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( getSecGlobalMarks()
  let( (cellName cellLength endOfCell newSecCellList)
    newSecCellList = nil
    foreach( cell phopl->secCells
      if(rexMatchp("GM" car(cell)) || rexMatchp("global_mark" car(cell)) ||
	 rexMatchp("ASML_PM" car(cell)) || rexMatchp("ASML_SPM" car(cell)) then
	phopl->GmarksSec = cons(cell phopl->GmarksSec)
      else 
	newSecCellList = cons(cell newSecCellList)
      )

    );foreach

    phopl->secCells = newSecCellList
  )
) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure(getMetroFET(master @optional (transform list(0:0 "R0" 1)) (hierInstPath "/"))
  let( (InternalCellInfo)
    foreach(inst master~>instances
      when(inst~>objType=="inst"
	if( rexMatchp("MetroFet" inst~>cellName) || rexMatchp("metroFET" inst~>cellName) then
	  InternalCellInfo = list(inst~>cellName  dbTransformPoint(inst~>xy transform) inst~>orient)
	  phopl->Metro = cons(InternalCellInfo phopl->Metro)
	);if
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This is a generic recursive, breadth first search procedure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure(getSecMetroFET(master @optional (transform list(0:0 "R0" 1)) (hierInstPath "/"))
  let( (InternalCellInfo)
    foreach(inst phopl->inst
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( kwGetBoxnBox()
  let( (   )
    ;phopl->boxnbox = nil
    newPriCellList = nil
    foreach( cell phopl->priCells
      if( rexMatchp("boxnbox" car(cell)) then 
	phopl->BnB = cons(cell phopl->BnB)
      else
	newPriCellList = cons(cell newPriCellList)
      )
    ) 
    phopl->priCells = newPriCellList
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( getSecBoxnBox()
  let( ( newSecCellList  )
    phopl->BnBSec = nil
    newSecCellList = nil
    foreach( cell phopl->secCells
      if( rexMatchp("boxnbox" car(cell)) then 
	phopl->BnBSec = cons(cell phopl->BnBSec)
      else
	newSecCellList = cons(cell newSecCellList)
      )
    ) 
    phopl->secCells = newSecCellList
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure(kwEvaluateBnB(cell)
  let((tmpCellName tmpCellOrigin tmpCellOrient tmpIntInsts tmpBnBList)
    tmpIntInst = nil
    tmpBnBList = nil
    tmpCellName = cell~>cellName
    tmpCellOrigin = cell~>xy
    tmpCellOrient = cell~>orient
    if(! (strcmp(tmpCellOrient "R0") == 0) && !(strcmp(tmpCellOrient "R90") == 0) then
      printf("BoxNBox at %16L is not at a R0 or R90 rotation \n" tmpCellOrigin)
    else
/*
 	if it reaches this point then it's a good BnB 
 	now we must see if it has subCells           
*/
      tmpIntInsts = cell~>master~>instances
      
      if(tmpIntInsts then
	iniPosX = car(tmpCellOrigin)
	iniPosY = cadr(tmpCellOrigin)
	foreach(icell tmpIntInsts
	  BnBName = icell~>cellName
	  if( rexMatchp("BNB"  BnBName) || rexMatchp("boxnbox"  BnBName) then
	    relBnBLoc = icell~>xy
	    relBnBX = car(relBnBLoc)
	    relBnBY = cadr(relBnBLoc)
	    if( strcmp(tmpCellOrient "R0") == 0 then
	      AbsBnBX = iniPosX + relBnBX
	      AbsBnBY = iniPosY + relBnBY
	    else
	      AbsBnBX = iniPosX - relBnBY
	      AbsBnBY = iniPosY + relBnBX 
	    )
	    AbsBnBLoc = list(AbsBnBX AbsBnBY)
	    InternalCellInfo = list(BnBName AbsBnBLoc tmpCellOrient)
	    phopl->BnB = cons(InternalCellInfo phopl->BnB)
	  else 
	    if( rexMatchp("_LeicaMark_" BnBName) then
	      relBnBLoc = icell~>xy
	      relBnBX = car(relBnBLoc)
	      relBnBY = cadr(relBnBLoc)
	      AbsBnBX = iniPosX + relBnBX
	      AbsBnBY = iniPosY + relBnBY
	      AbsBnBLoc = list(AbsBnBX AbsBnBY)
	      InternalCellInfo = list(BnBName AbsBnBLoc tmpCellOrient)
	      phopl->Lmarks = cons(InternalCellInfo phopl->Lmarks)
	    )
	  )
	)
      else
	tmpBnBList = list(tmpCellName tmpCellOrigin tmpCellOrient)
	phopl->BnB = cons(tmpBnBList phopl->BnB)
      )
    ) 
  )
) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure(kwEvaluateGM(cell)
  let((tmpCellName tmpCellOrigin tmpCellOrient tmpIntInsts tmpGMList)
    tmpIntInst = nil
    tmpGMList = nil
    tmpCellName = cell~>cellName
    tmpCellOrigin = cell~>xy
    tmpCellOrient = cell~>orient

    tmpIntInsts = cell~>master~>instances
      
    if(tmpIntInsts then
      iniPosX = car(tmpCellOrigin)
      iniPosY = cadr(tmpCellOrigin)

      foreach(icell tmpIntInsts
	GMName = icell~>cellName
	if( rexMatchp("L0_X"  GMName) || rexMatchp("L0_Y"  GMName) then
	  relGMLoc = icell~>xy
	  relGMX = car(relGMLoc)
	  relGMY = cadr(relGMLoc)
	  AbsGMX = iniPosX + relGMX
	  AbsGMY = iniPosY + relGMY
	  AbsGMLoc = list(AbsGMX AbsGMY)
	  InternalCellInfo = list(GMName AbsGMLoc tmpCellOrient)
	  phopl->Gmarks = cons(InternalCellInfo phopl->Gmarks)
	)
      )
    )
  )
) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( kwGetDFASkeys()
  let( (tmpPriCells)
    tmpPriCells = nil	
    phopl->dfas = nil
    rexMagic( t )
    foreach( cell phopl->priCells
      if( rexMatchp("dfas" car(cell) ) ||
	  rexMatchp("isi"  car(cell) )
      then
	phopl->dfas = cons(cell phopl->dfas)
      else
	tmpPriCells = cons(cell tmpPriCells)
      )
      phopl->priCells = tmpPriCells
    )
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( getSecDFASkeys()
  let( (tmpSecCells)
    tmpSecCells = nil	
    phopl->dfasSec = nil
    rexMagic( t )
    foreach( cell phopl->secCells
      if( rexMatchp("dfas" car(cell) ) ||
	  rexMatchp("isi"  car(cell) )
      then
	phopl->dfasSec = cons(cell phopl->dfasSec)
      else
	tmpSecCells = cons(cell tmpSecCells)
      )
      phopl->secCells = tmpSecCells
    )
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( evaluateSecDFASkeys()
  let( (cellInfo layer code tmpDfas finalDfasList letterCode)
    tmpDfas = nil
    finalDfasList = nil
    foreach( cell phopl->dfasSec
      if((strncmp(car(cell) phopl->newStyle 3 ) == 0) || rexMatchp("mmc66" car(cell)) then
        tmpcellName = car(cell)
        cellName = substring(tmpcellName 12 10)
	  cond( 
	    ( rexMatchp("Mesa_1_2_l" car(cell)) 
	      letterCode = "C (mesa)"
	    )
	    ( rexMatchp("Mesa_6_bar" car(cell))
	      letterCode = "I (mesa)"
	    )
	    ( rexMatchp("Mesa_6_mic" car(cell))
	      letterCode = "H (mesa)"
	    )
	    ( rexMatchp("SD_1_2_seg" car(cell))
	      letterCode = "F (sd)"
	    )
	    ( rexMatchp("SD_4_4_bar" car(cell))
	      letterCode = "G (sd)"
	    )
	    ( rexMatchp("SD_5_4_bar" car(cell))
	      letterCode = "A (sd)"
	    )
	    ( rexMatchp("SD_6_6_bar" car(cell))
	      letterCode = "D (sd)"
	    )
	    ( rexMatchp("MM_6_micro" car(cell))
	      letterCode = "A (MM)"
	    )                   
	    ( rexMatchp("MM_6_bar_r" car(cell))
	      letterCode = "B (MM)"
	    )
	    ( rexMatchp( "EB_6_micro" car(cell))
	      letterCode = "A (EBeam)"
	    )
	    ( rexMatchp("MM_6_micro" car(cell))
	      letterCode = "A (MM)"
	    )
	    ( rexMatchp("M_6_micro_" car(cell))
	      letterCode = "A (mesa)"
	    )
	    ( rexMatchp("SD_6_micro" car(cell))
	      letterCode = "A (sd)")
	    ( rexMatchp("SD_mkr_6_m" car(cell))
	      letterCode = "A (sdText)"
	    )
	    ( rexMatchp("SD_text_6_" car(cell))
	      letterCode = "A (sdText)"
	    )
	    ( rexMatchp("Scan_6_mic" car(cell))
	      letterCode = "A (scan)"
	    )
	  )
      else
	tmpcellName = car(cell)
	endofcell=strlen(tmpcellName)
	if( (strncmp(substring(car(cell) 8 1) "_" 1) == 0) then
	  cellName=substring(tmpcellName 9 endofcell-8)
	else
	  cellName=substring(tmpcellName 10 endofcell-9)
	)
	letterCode = 
	  case( cellName
	    ("isi_Mesa_6_4_bars" "A (mesa)")
	    ("isi_Mesa_6_4_micro_mark_solid" "A (mesa)")
	    ("isi_Mesa_1_4_seg_rev" "B (mesa)")
	    ("isi_Mesa_1_2_longbars" "C (mesa)")
	    ("isi_Mesa_1_2x3_6longbars" "C (mesa)")
	    ("isi_Mesa_1_4_seg" "D (mesa)")
	    ("isi_Mesa_1_4_micro_mark_seg" "D (mesa)")
	    ("isi_Mesa_1_2_shortbars" "E (mesa)")
	    ("isi_Mesa_1_2_seg" "F (mesa)")
	    ("isi_Mesa_1_6_seg" "G (mesa)")
	    ("isi_Mesa_1_6um_segmented" "G (mesa)")
	    ("isi_SD_5_4_bars" "A (sd)")
	    ("isi_SD_1_4_seg_rev" "B (sd)")
	    ("isi_SD_6_6_bar_rev" "C (sd)")
	    ("isi_SD_1_4_seg" "D (sd)")
	    ("isi_SD_1_2_shortbars" "E (sd)")
	    ("isi_SD_1_2_seg" "F (sd)")
	    ("isi_SD_4_4_bars" "G (sd)")
	    ("isi_SD_5_4_seg_rev" "A (sd)")
	    ("isi_SD_1_4_seg_rev" "B (sd)")
	    ("isi_SD_6_6_seg_rev" "C (sd)")
	    ("isi_SD_1_4_micro_mark_seg" "D (sd)")
	    ("isi_SD_1_2x2_4_shortbars" "E (sd)")
	    ("isi_SD_1_2seg_tre" "F (sd)")
	    ("isi_SD_4_4_seg_rev" "G (sd)")
	    ("isi_sd_5_4_seg_rev" "A (sd)")
	    ("isi_sd_1_4_seg_rev" "B (sd)")
	    ("isi_sd_6_6_seg_rev" "C (sd)")
	    ("isi_sd_1_4_micro_mark_seg" "D (sd)")
	    ("isi_sd_1_2x2_4_shortbars" "E (sd)")
	    ("isi_Mesa_1_2x2_4_shortbars" "E (mesa)")
	    ("isi_Mesa_1_2seg_tre" "F (mesa)")
	    ("isi_sd_1_2seg_tre" "F (sd)")
	    ("isi_sd_4_4_seg_rev" "G (sd)")
	    ("isi_Mesa_6_micro_mark_solid" "H (mesa)")
	    ("isi_Mesa_6_bar_rev" "I (mesa)")
	    ("isi_SD_1_2_seg" "F (sd)")
	  )
      )
      cellInfo = list(car(cell) cadr(cell) letterCode)
      tmpDfas = cons(cellInfo tmpDfas)
    )
/*******  Code to weed out unreference dfas stuff  ****/
    foreach( i tmpDfas
      if( caddr(i) then
	finalDfasList= cons(i finalDfasList)	
      else
	phopl->priCells = cons(i phopl->priCells)
	phopl->tmp = i 
      )	
    )
	phopl->dfas = finalDfasList

  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( kwEvaluateDFASkeys()
  let( (cellInfo layer code tmpDfas finalDfasList)
    tmpDfas = nil
    finalDfasList = nil
    foreach( cell phopl->dfas
      if((strncmp(car(cell) phopl->newStyle 3 ) == 0) || rexMatchp("mmc66" car(cell)) then
        tmpcellName = car(cell)
        cellName = substring(tmpcellName 12 10)
	  cond( 
	    ( rexMatchp("Mesa_1_2_l" car(cell)) 
	      letterCode = "C (mesa)"
	    )
	    ( rexMatchp("Mesa_6_bar" car(cell))
	      letterCode = "I (mesa)"
	    )
	    ( rexMatchp("Mesa_6_mic" car(cell))
	      letterCode = "H (mesa)"
	    )
	    ( rexMatchp("SD_1_2_seg" car(cell))
	      letterCode = "F (sd)"
	    )
	    ( rexMatchp("SD_4_4_bar" car(cell))
	      letterCode = "G (sd)"
	    )
	    ( rexMatchp("SD_5_4_bar" car(cell))
	      letterCode = "A (sd)"
	    )
	    ( rexMatchp("SD_6_6_bar" car(cell))
	      letterCode = "D (sd)"
	    )
	    ( rexMatchp("MM_6_micro" car(cell))
	      letterCode = "A (MM)"
	    )                   
	    ( rexMatchp("MM_6_bar_r" car(cell))
	      letterCode = "B (MM)"
	    )
	    ( rexMatchp( "EB_6_micro" car(cell))
	      letterCode = "A (EBeam)"
	    )
	    ( rexMatchp("MM_6_micro" car(cell))
	      letterCode = "A (MM)"
	    )
	    ( rexMatchp("M_6_micro_" car(cell))
	      letterCode = "A (mesa)"
	    )
	    ( rexMatchp("SD_6_micro" car(cell))
	      letterCode = "A (sd)")
	    ( rexMatchp("SD_mkr_6_m" car(cell))
	      letterCode = "A (sdText)"
	    )
	    ( rexMatchp("SD_text_6_" car(cell))
	      letterCode = "A (sdText)"
	    )
	    ( rexMatchp("Scan_6_mic" car(cell))
	      letterCode = "A (scan)"
	    )
	  )
      else
	tmpcellName = car(cell)
	endofcell=strlen(tmpcellName)
	if( (strncmp(substring(car(cell) 8 1) "_" 1) == 0) then
	  cellName=substring(tmpcellName 9 endofcell-8)
	else
	  cellName=substring(tmpcellName 10 endofcell-9)
	)
	letterCode = 
	  case( cellName
	    ("isi_Mesa_6_4_bars" "A (mesa)")
	    ("isi_Mesa_6_4_micro_mark_solid" "A (mesa)")
	    ("isi_Mesa_1_4_seg_rev" "B (mesa)")
	    ("isi_Mesa_1_2_longbars" "C (mesa)")
	    ("isi_Mesa_1_2x3_6longbars" "C (mesa)")
	    ("isi_Mesa_1_4_seg" "D (mesa)")
	    ("isi_Mesa_1_4_micro_mark_seg" "D (mesa)")
	    ("isi_Mesa_1_2_shortbars" "E (mesa)")
	    ("isi_Mesa_1_2_seg" "F (mesa)")
	    ("isi_Mesa_1_6_seg" "G (mesa)")
	    ("isi_Mesa_1_6um_segmented" "G (mesa)")
	    ("isi_SD_5_4_bars" "A (sd)")
	    ("isi_SD_1_4_seg_rev" "B (sd)")
	    ("isi_SD_6_6_bar_rev" "C (sd)")
	    ("isi_SD_1_4_seg" "D (sd)")
	    ("isi_SD_1_2_shortbars" "E (sd)")
	    ("isi_SD_1_2_seg" "F (sd)")
	    ("isi_SD_4_4_bars" "G (sd)")
	    ("isi_SD_5_4_seg_rev" "A (sd)")
	    ("isi_SD_1_4_seg_rev" "B (sd)")
	    ("isi_SD_6_6_seg_rev" "C (sd)")
	    ("isi_SD_1_4_micro_mark_seg" "D (sd)")
	    ("isi_SD_1_2x2_4_shortbars" "E (sd)")
	    ("isi_SD_1_2seg_tre" "F (sd)")
	    ("isi_SD_4_4_seg_rev" "G (sd)")
	    ("isi_sd_5_4_seg_rev" "A (sd)")
	    ("isi_sd_1_4_seg_rev" "B (sd)")
	    ("isi_sd_6_6_seg_rev" "C (sd)")
	    ("isi_sd_1_4_micro_mark_seg" "D (sd)")
	    ("isi_sd_1_2x2_4_shortbars" "E (sd)")
	    ("isi_Mesa_1_2x2_4_shortbars" "E (mesa)")
	    ("isi_Mesa_1_2seg_tre" "F (mesa)")
	    ("isi_sd_1_2seg_tre" "F (sd)")
	    ("isi_sd_4_4_seg_rev" "G (sd)")
	    ("isi_Mesa_6_micro_mark_solid" "H (mesa)")
	    ("isi_Mesa_6_bar_rev" "I (mesa)")
	    ("isi_SD_1_2_seg" "F (sd)")
	  )
      )
      cellInfo = list(car(cell) cadr(cell) letterCode)
      tmpDfas = cons(cellInfo tmpDfas)
    )
/*******  Code to weed out unreference dfas stuff  ****/
    foreach( i tmpDfas
      if( caddr(i) then
	finalDfasList= cons(i finalDfasList)	
      else
	phopl->priCells = cons(i phopl->priCells)
	phopl->tmp = i 
      )	
    )
	phopl->dfas = finalDfasList

  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( kwPrintData()
  let( (tmpCellName tmpCOX tmpCOY tmpCellCoords gmCount cellX cellY cellOrient quadList newBnBList)
    gmCount = 1
    fprintf(phopl->port "****************************************************************************\n")
    fprintf(phopl->port "******                        Global Marks                            ******\n")
    fprintf(phopl->port "****************************************************************************\n")

    foreach(i phopl->Gmarks
	    tmpCellName = car(i)
	    tmpCOX = caadr(i)
	    tmpCOY = cadadr(i)
	    fprintf( phopl->port "Global Mark%d:     %-36s %10.2f %10.2f\n", gmCount tmpCellName tmpCOX tmpCOY)
	    gmCount = gmCount + 1
    )
    fprintf(phopl->port "****************************************************************************\n")
    fprintf(phopl->port "******                        DFAS Keys                               ******\n")
    fprintf(phopl->port "****************************************************************************\n")
    fprintf(phopl->port " \n")
    fprintf(phopl->port "       Code      CellName                                      X        Y\n")
    foreach(i phopl->dfas
    cellCode = caddr(i)
    cellName = car(i)
    cellX = caadr(i)
    cellY = cadadr(i)
    fprintf(phopl->port "PRI   %-10s %-40s  %8.2f %8.2f \n", cellCode cellName cellX cellY)
    )
    fprintf(phopl->port "\n")
    fprintf(phopl->port "****************************************************************************\n")
    fprintf(phopl->port "******                      Other Cells                               ******\n")
    fprintf(phopl->port "****************************************************************************\n")
    foreach(i phopl->priCells
    cellCode=" "
    cellName = car(i)
    cellX = caadr(i)
    cellY = cadadr(i)
    fprintf(phopl->port "PRI   %-10s %-40s  %8.2f %8.2f \n", cellCode cellName cellX cellY)
    )
    fprintf(phopl->port "\n")
    fprintf(phopl->port "Oat Cells only show up if they are different from the Primary \n")
    fprintf(phopl->port "\n")
    foreach(i phopl->oatCells
    cellCode=" "
    cellName = car(i)
    cellX = caadr(i)
    cellY = cadadr(i)
    fprintf(phopl->port "Oat   %-10s %-40s  %8.2f %8.2f \n", cellCode cellName cellX cellY)
    )
    /* Make sure Aeble alignment marks are defined and print them out */
    if( phopl->alignCells && phopl->eBeam=="Aeble" then
      fprintf(phopl->port "\n")
      fprintf(phopl->port "****************************************************************************\n")
      fprintf(phopl->port "******                   Aeble Local Marks                            ******\n")
      fprintf(phopl->port "****************************************************************************\n")
      fprintf(phopl->port "\n")
      fprintf(phopl->port "Aeble Local Mark coordinates relate to the center of the upper most sd cross\n")
      fprintf(phopl->port "\n")

	sortList = phopl->alignCells
	quadList=nil
	sortList = sort(sortList lambda((a b) multi_sort(a b '(1 3 2))))
	
	fprintf(phopl->port "\n")
	quadList = printQuad(1 sortList "LL Quad \"A\"     " quadList)
	quadList = printQuad(2 sortList "LL Quad \"B\"     " quadList)
	quadList = printQuad(6 sortList "LR Quad \"B\"     " quadList)
	quadList = printQuad(8 sortList "LR Quad \"C\"     " quadList)
	quadList = printQuad(4 sortList "LL Quad \"C\"     " quadList)
	quadList = printQuad(3 sortList "LL Quad \"D\"     " quadList)
	quadList = printQuad(11 sortList "UL Quad \"D\"     " quadList)
	quadList = printQuad(15 sortList "UR Quad \"D\"     " quadList)
	quadList = printQuad(16 sortList "UR Quad \"C\"     " quadList)
	fprintf(phopl->port "\n")

      foreach(q quadList
	sortList=remove(q sortList)
      )

      foreach(i sortList
	cellCode=" "
	cellName = car(i)
	cellX = cadr(i)
	cellY = caddr(i)
	fprintf(phopl->port "ALIGN %-10s %-40s  %8.2f %8.2f \n", cellCode cellName cellX cellY)
      )

      get_ebeam_window(phopl->design phopl->primary phopl->port)

    )

    if( phopl->eBeam=="Leica" then
      fprintf(phopl->port "\n")
      fprintf(phopl->port "****************************************************************************\n")
      fprintf(phopl->port "******                       Leica Marks                              ******\n")
      fprintf(phopl->port "****************************************************************************\n")
      fprintf(phopl->port "\n")

      sortList = phopl->Lmarks
      sortList = sort(sortList lambda((a b) multi_sort(a b '(1))))
      phopl->Lmarks = sortList
      foreach(i phopl->Lmarks
	cellCode=" "
	cellName = car(i)
	cellX = caadr(i)
	cellY = cadadr(i)
	fprintf(phopl->port "PRI   %-10s %-40s  %8.2f %8.2f \n", cellCode cellName cellX cellY)
      )

      get_ebeam_window(phopl->design phopl->primary phopl->port)
    )


    fprintf(phopl->port "\n")
    fprintf(phopl->port "****************************************************************************\n")
    fprintf(phopl->port "****** Box In Box Structures      Inside->Outside (Center of both)    ******\n")
    fprintf(phopl->port "****************************************************************************\n")

    newBnBList = phopl->BnB
    newBnBList = sort(newBnBList lambda((a b) multi_sort(a b '(1))))
    phopl->BnB = newBnBList

    foreach(i phopl->BnB
      cellCode=" "
      cellName = car(i)
      cellX = caadr(i)
      cellY = cadadr(i)
      fprintf(phopl->port "      %-10s %-40s  %8.2f %8.2f \n", cellCode cellName cellX cellY)
    )
    
    if( phopl->Metro then
      fprintf(phopl->port "\n")
      fprintf(phopl->port "****************************************************************************************************\n")
      fprintf(phopl->port "****** Metro FETS         Lower Left Corner when R0 or Upper Right when R180      Orientation ******\n")
      fprintf(phopl->port "****************************************************************************************************\n")

      foreach(i phopl->Metro
	cellCode=" "
	cellName = car(i)
	cellX = caadr(i)
	cellY = cadadr(i)
	cellOrient = caddr(i)
	fprintf(phopl->port "      %-10s %-40s  %8.2f %8.2f      %s\n", cellCode cellName cellX cellY cellOrient)
      )
    )

  )
) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( printSecData()
  let( (tmpCellName tmpCOX tmpCOY tmpCellCoords gmCount cellX cellY cellOrient quadList newBnBList)
    gmCount = 1
    fprintf(phopl->port "****************************************************************************\n")
    fprintf(phopl->port "******              Secondary Global Marks                            ******\n")
    fprintf(phopl->port "****************************************************************************\n")

    foreach(i phopl->GmarksSec
	    tmpCellName = car(i)
	    tmpCOX = caadr(i)
	    tmpCOY = cadadr(i)
	    fprintf( phopl->port "Global Mark%d:     %-36s %10.2f %10.2f\n", gmCount tmpCellName tmpCOX tmpCOY)
	    gmCount = gmCount + 1
    )
    fprintf(phopl->port "****************************************************************************\n")
    fprintf(phopl->port "******              Secondary DFAS Keys                               ******\n")
    fprintf(phopl->port "****************************************************************************\n")
    fprintf(phopl->port " \n")
    fprintf(phopl->port "       Code      CellName                                      X        Y\n")
    foreach(i phopl->dfasSec
    cellCode = caddr(i)
    cellName = car(i)
    cellX = caadr(i)
    cellY = cadadr(i)
    fprintf(phopl->port "PRI   %-10s %-40s  %8.2f %8.2f \n", cellCode cellName cellX cellY)
    )
    fprintf(phopl->port "\n")
    fprintf(phopl->port "****************************************************************************\n")
    fprintf(phopl->port "******            Secondary Other Cells                               ******\n")
    fprintf(phopl->port "****************************************************************************\n")
    foreach(i phopl->secCells
    cellCode=" "
    cellName = car(i)
    cellX = caadr(i)
    cellY = cadadr(i)
    fprintf(phopl->port "SEC   %-10s %-40s  %8.2f %8.2f \n", cellCode cellName cellX cellY)
    )
    fprintf(phopl->port "\n")
    fprintf(phopl->port " Cells only show up if they are different from the Primary \n")
    fprintf(phopl->port "\n")
    foreach(i phopl->oatCells
    cellCode=" "
    cellName = car(i)
    cellX = caadr(i)
    cellY = cadadr(i)
    fprintf(phopl->port "Oat   %-10s %-40s  %8.2f %8.2f \n", cellCode cellName cellX cellY)
    )
    /* Make sure Aeble alignment marks are defined and print them out */
    if( phopl->alignSecCells && phopl->eBeam=="Aeble" then
      fprintf(phopl->port "\n")
      fprintf(phopl->port "****************************************************************************\n")
      fprintf(phopl->port "******        Secondary Aeble Local Marks                            ******\n")
      fprintf(phopl->port "****************************************************************************\n")
      fprintf(phopl->port "\n")
      fprintf(phopl->port "Aeble Local Mark coordinates relate to the center of the upper most sd cross\n")
      fprintf(phopl->port "\n")

	sortList = phopl->alignSecCells
	quadList=nil
	sortList = sort(sortList lambda((a b) multi_sort(a b '(1 3 2))))
	
	fprintf(phopl->port "\n")
	quadList = printQuad(1 sortList "LL Quad \"A\"     " quadList)
	quadList = printQuad(2 sortList "LL Quad \"B\"     " quadList)
	quadList = printQuad(6 sortList "LR Quad \"B\"     " quadList)
	quadList = printQuad(8 sortList "LR Quad \"C\"     " quadList)
	quadList = printQuad(4 sortList "LL Quad \"C\"     " quadList)
	quadList = printQuad(3 sortList "LL Quad \"D\"     " quadList)
	quadList = printQuad(11 sortList "UL Quad \"D\"     " quadList)
	quadList = printQuad(15 sortList "UR Quad \"D\"     " quadList)
	quadList = printQuad(16 sortList "UR Quad \"C\"     " quadList)
	fprintf(phopl->port "\n")

      foreach(q quadList
	sortList=remove(q sortList)
      )

      foreach(i sortList
	cellCode=" "
	cellName = car(i)
	cellX = cadr(i)
	cellY = caddr(i)
	fprintf(phopl->port "ALIGN %-10s %-40s  %8.2f %8.2f \n", cellCode cellName cellX cellY)
      )

      get_ebeam_window(phopl->design phopl->primary phopl->port)

    )

    if( phopl->eBeam=="Leica" then
      fprintf(phopl->port "\n")
      fprintf(phopl->port "****************************************************************************\n")
      fprintf(phopl->port "******             Secondary Leica Marks                              ******\n")
      fprintf(phopl->port "****************************************************************************\n")
      fprintf(phopl->port "\n")

      sortList = phopl->LmarksSec
      sortList = sort(sortList lambda((a b) multi_sort(a b '(1))))
      phopl->LmarksSec = sortList
      foreach(i phopl->LmarksSec
	cellCode=" "
	cellName = car(i)
	cellX = caadr(i)
	cellY = cadadr(i)
	fprintf(phopl->port "SEC   %-10s %-40s  %8.2f %8.2f \n", cellCode cellName cellX cellY)
      )

      get_ebeam_window(phopl->design phopl->dropin phopl->port)
    )


    fprintf(phopl->port "\n")
    fprintf(phopl->port "****************************************************************************\n")
    fprintf(phopl->port "****** SEC Box In Box Structures  Inside->Outside (Center of both)    ******\n")
    fprintf(phopl->port "****************************************************************************\n")

    newBnBList = phopl->BnBSec
    newBnBList = sort(newBnBList lambda((a b) multi_sort(a b '(1))))
    phopl->BnBSec = newBnBList

    foreach(i phopl->BnBSec
      cellCode=" "
      cellName = car(i)
      cellX = caadr(i)
      cellY = cadadr(i)
      fprintf(phopl->port "      %-10s %-40s  %8.2f %8.2f \n", cellCode cellName cellX cellY)
    )
    
    if( phopl->MetroSec then
      fprintf(phopl->port "\n")
      fprintf(phopl->port "****************************************************************************************************\n")
      fprintf(phopl->port "****** SEC Metro FETS     Lower Left Corner when R0 or Upper Right when R180      Orientation ******\n")
      fprintf(phopl->port "****************************************************************************************************\n")

      foreach(i phopl->MetroSec
	cellCode=" "
	cellName = car(i)
	cellX = caadr(i)
	cellY = cadadr(i)
	cellOrient = caddr(i)
	fprintf(phopl->port "      %-10s %-40s  %8.2f %8.2f      %s\n", cellCode cellName cellX cellY cellOrient)
      )
    )

  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( kwComputeDisFromCenter(dfasX dfasY)
let( (NEcenX NEcenY XdfCNE YdfCNE NWcenX NWcenY XdfCNW YdfCNW
      SWcenX SWcenY XdfCSW YdfCSW SEcenX SEcenY XdfCSE YdfCSE)
NEcenX = caar(phopl->NEcenter)
NEcenY = cadar(phopl->NEcenter)
XdfCNE = dfasX - NEcenX
YdfCNE = dfasY - NEcenY
NWcenX = caar(phopl->NWcenter)
NWcenY = cadar(phopl->NWcenter) 
XdfCNW = dfasX - NWcenX
YdfCNW = dfasY - NWcenY
SWcenX = caar(phopl->SWcenter)
SWcenY = cadar(phopl->SWcenter)
XdfCSW = dfasX - SWcenX
YdfCSW = dfasY - SWcenY
SEcenX = caar(phopl->SEcenter)
SEcenY = cadar(phopl->SEcenter)
XdfCSE = dfasX - SEcenX
YdfCSE = dfasY - SEcenY
list(`(,XdfCNE ,YdfCNE) `(,XdfCNW ,YdfCNW) `(,XdfCSW ,YdfCSW) `(,XdfCSE ,YdfCSE))
))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure(kwGetQuadrant(x y)
  let( ()
    if( ((x>0) && (y>0))
    then quad = "NE")
    if( ((x<0) && (y>0))
    then quad = "NW")
    if( ((x<0) && (y<0))
    then quad = "SW")
    if( ((x>0) && (y<0))
    then quad = "SE")
    list(quad)
    );let
);procedure

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( kwGetQtrPrintData()
let( (quadrant relX relY qtrDfasDataLocal)

qtrDfasDataLocal= nil
qtrGmarkDataLocal= nil
phopl->dfasQtr = nil
phopl->gmarkQtr = nil

foreach( i phopl->dfas
dis2dfas = kwComputeDisFromCenter( caadr(i) cadadr(i)) 
quadrant = kwGetQuadrant(caadr(i) cadadr(i))
qtrDfasDataLocal = list(car(i) caddr(i) dis2dfas quadrant)  
phopl->dfasQtr = cons(qtrDfasDataLocal phopl->dfasQtr)
)

foreach(i phopl->Gmarks
dis2gmark = kwComputeDisFromCenter( caadr(i) cadadr(i))
quadrant = kwGetQuadrant(caadr(i) cadadr(i))
qtrGmarkDataLocal = list(car(i) caddr(i) dis2gmark quadrant)
phopl->gmarkQtr = cons(qtrGmarkDataLocal phopl->gmarkQtr)
)

))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( getSecQtrPrintData()
let( (quadrant relX relY qtrDfasDataLocal)

qtrDfasDataLocal= nil
qtrGmarkDataLocal= nil
phopl->dfasQtrSec = nil
phopl->gmarkQtrSec = nil

foreach( i phopl->dfasSec
dis2dfas = kwComputeDisFromCenter( caadr(i) cadadr(i)) 
quadrant = kwGetQuadrant(caadr(i) cadadr(i))
qtrDfasDataLocal = list(car(i) caddr(i) dis2dfas quadrant)  
phopl->dfasQtrSec = cons(qtrDfasDataLocal phopl->dfasQtrSec)
)

foreach(i phopl->GmarksSec
dis2gmark = kwComputeDisFromCenter( caadr(i) cadadr(i))
quadrant = kwGetQuadrant(caadr(i) cadadr(i))
qtrGmarkDataLocal = list(car(i) caddr(i) dis2gmark quadrant)
phopl->gmarkQtrSec = cons(qtrGmarkDataLocal phopl->gmarkQtrSec)
)

))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( kwPrintQtrInfo()
let( (nfo) 
fprintf(phopl->port "\n")
fprintf(phopl->port "\n")
fprintf(phopl->port "\n")

fprintf(phopl->port "DATA Based On Quarter Reticles\n")
fprintf(phopl->port "\n")
fprintf(phopl->port "1/4 reticle size %8.2f %8.2f \n", phopl->xStepPri/2 phopl->yStepPri/2)
fprintf(phopl->port "1/4 reticle OVERsized to %8.2f %8.2f \n", phopl->xStepPri/2+1 phopl->yStepPri/2+1)
fprintf(phopl->port "\n")

fprintf(phopl->port "Center of NE Reticle %22L\n", car(phopl->NEcenter))
fprintf(phopl->port "Center of NW Reticle %22L\n", car(phopl->NWcenter))
fprintf(phopl->port "Center of SW Reticle %22L\n", car(phopl->SWcenter))
fprintf(phopl->port "Center of SE Reticle %22L\n", car(phopl->SEcenter))
fprintf(phopl->port "\n")


fprintf(phopl->port "\n")
fprintf(phopl->port "\n")

foreach(i phopl->dfasQtr
dis2 = caddr(i)
fprintf(phopl->port "%-40s DFAS Reference %-12s  Quadrant %-10s\n",car(i) cadr(i) car(cadddr(i)))
fprintf(phopl->port "Distance From Center of NE Reticle %22L\n", car(dis2))
fprintf(phopl->port "Distance From Center of NW Reticle %22L\n", cadr(dis2))
fprintf(phopl->port "Distance From Center of SW Reticle %22L\n", caddr(dis2))
fprintf(phopl->port "Distance From Center of SE Reticle %22L\n", cadddr(dis2))
fprintf(phopl->port "\n")
)


fprintf(phopl->port "\n")
fprintf(phopl->port "\n")

foreach(i phopl->gmarkQtr
dis2 = caddr(i)
fprintf(phopl->port "%-40s Quadrant %-10s\n", car(i) car(cadddr(i)))
fprintf(phopl->port "Distance From Center of NE Reticle %22L\n", car(dis2))
fprintf(phopl->port "Distance From Center of NW Reticle %22L\n", cadr(dis2))
fprintf(phopl->port "Distance From Center of SW Reticle %22L\n", caddr(dis2))
fprintf(phopl->port "Distance From Center of SE Reticle %22L\n", cadddr(dis2))
fprintf(phopl->port "\n")
)

))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( printSecQtrInfo()
let( (nfo) 
fprintf(phopl->port "\n")
fprintf(phopl->port "\n")
fprintf(phopl->port "\n")

fprintf(phopl->port "SEC DATA Based On Quarter Reticles\n")
fprintf(phopl->port "\n")
fprintf(phopl->port "SEC 1/4 reticle size %8.2f %8.2f \n", phopl->xStepSec/2 phopl->yStepSec/2)
fprintf(phopl->port "SEC 1/4 reticle OVERsized to %8.2f %8.2f \n", phopl->xStepSec/2+1 phopl->yStepSec/2+1)
fprintf(phopl->port "\n")

fprintf(phopl->port "SEC Center of NE Reticle %22L\n", car(phopl->NEcenterSec))
fprintf(phopl->port "SEC Center of NW Reticle %22L\n", car(phopl->NWcenterSec))
fprintf(phopl->port "SEC Center of SW Reticle %22L\n", car(phopl->SWcenterSec))
fprintf(phopl->port "SEC Center of SE Reticle %22L\n", car(phopl->SEcenterSec))
fprintf(phopl->port "\n")


fprintf(phopl->port "\n")
fprintf(phopl->port "\n")

foreach(i phopl->dfasQtrSec
dis2 = caddr(i)
fprintf(phopl->port "SEC %-40s DFAS Reference %-12s  Quadrant %-10s\n",car(i) cadr(i) car(cadddr(i)))
fprintf(phopl->port "SEC Distance From Center of NE Reticle %22L\n", car(dis2))
fprintf(phopl->port "SEC Distance From Center of NW Reticle %22L\n", cadr(dis2))
fprintf(phopl->port "SEC Distance From Center of SW Reticle %22L\n", caddr(dis2))
fprintf(phopl->port "SEC Distance From Center of SE Reticle %22L\n", cadddr(dis2))
fprintf(phopl->port "\n")
)


fprintf(phopl->port "\n")
fprintf(phopl->port "\n")

foreach(i phopl->gmarkQtrSec
dis2 = caddr(i)
fprintf(phopl->port "SEC %-40s Quadrant %-10s\n", car(i) car(cadddr(i)))
fprintf(phopl->port "SEC Distance From Center of NE Reticle %22L\n", car(dis2))
fprintf(phopl->port "SEC Distance From Center of NW Reticle %22L\n", cadr(dis2))
fprintf(phopl->port "SEC Distance From Center of SW Reticle %22L\n", caddr(dis2))
fprintf(phopl->port "SEC Distance From Center of SE Reticle %22L\n", cadddr(dis2))
fprintf(phopl->port "\n")
)

))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( mpss(multi)
  let( ( mpss_cmd mpssfile forked output, multiCMD)
    if( (phopl->print) then 
      if( (multi==t) then
            multiCMD = "multi"
       else
            multiCMD = "single"
      )
      buildMpssPythonFile = "/net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa3/cad/scripts/python/buildMPSS/buildMPSS.py"
      sprintf(mpss_cmd "%s %s %s %s" buildMpssPythonFile phopl->release phopl->design multiCMD)
      forked = ipcBeginProcess( mpss_cmd "")
    
;     wait for it to start, then acknowledge:
      ipcWaitForProcess( forked )
      printf( "Building MPSS Report ... \n")
      printf( "MPSS Build Command: %s \n" mpss_cmd)
;      printf( "MPSS Python Location: %s \n" buildMpssFile)
      ipcWait(forked)
      output = ipcReadProcess(forked)
      printf("%s" output)
      ;if something unexpected happened
      if( (output != "MPSS complete, check release folder\n") then
        printf("Unable to build MPSS, see above error message for details\n")
      )
    )
    phopl->multi = nil
  )
  
)

procedure( multi_sort( a b order)
  let((less v1 v2)
    forall(n order
      if( numberp(nthelem(n a)) then
        (v1=nthelem(n a))==(v2=nthelem(n b)) || (less=lessp(v1 v2))&& nil
      else
        (v1=nthelem(n a))==(v2=nthelem(n b)) || (less=alphalessp(v1 v2))&& nil
      )
    )
    less
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( printQuad(n aList cellCode qList) 
  let( (cellName cellX cellY l)

    l=nthelem(n aList)
    cellName = car(l)
    cellX = cadr(l) 
    cellY = caddr(l)
    printf("%L\n" cellName)
    fprintf(phopl->port "%-10s %-40s  %8.2f %8.2f \n", cellCode cellName cellX cellY)
    qList=cons(l qList)
    qList
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( get_ebeam_window(lib cell REPORT)

  let( (minX maxX minY maxY newcell ocv cv i layer shape llX urX llY urY path1 gateLayer max_win_size min_win_size)
  
    declare(gates[20000])
    declare(x[2])

    if( phopl->eBeam == "Aeble" then
      max_win_size=1800.0
      min_win_size=1200.0
    else 
      max_win_size=325.0
      min_win_size=50.0
    )

    minX = 0.0
    maxX = 0.0
    minY = 0.0
    maxY = 0.0

    if( (rexMatchp("GaN" phopl->process) || rexMatchp("P80" phopl->process) || rexMatchp("P81" phopl->process)
         || rexMatchp("P82" phopl->process) || rexMatchp("D83" phopl->process)) then
      gateLayer = "gateStem"
    else
      gateLayer = "gate1"
    )
    sprintf( newcell "temp_%s" cell)
    ocv  = dbOpenCellViewByType(lib cell "layout" "maskLayout" "r" )
    cv  = dbCopyCellView(ocv lib newcell "layout" "" nil t)
    dbClose(ocv)
    
    sprintf(path1 "%s/deck1.rul" getTempDir())
    write_deck(cv path1 gateLayer)

    i = 0
    foreach(layer cv~>lpps
      if( layer~>layerName == gateLayer && layer~>purpose == "drawing" then
	foreach(shape layer~>shapes
	  if(shape~>objType == "rect" || shape~>objType == "polygon" then
	    llX = xCoord(car(shape~>bBox))
	    urX = xCoord(cadr(shape~>bBox))
	    gates[i] = list(llX urX)
	    i++
	  )
	)
      )
      if( layer~>layerName == "GRID" && layer~>purpose == "drawing" then
	foreach(shape layer~>shapes
	  llX = xCoord(car(shape~>bBox))
	  urX = xCoord(cadr(shape~>bBox))
	  llY = yCoord(car(shape~>bBox))
	  urY = yCoord(cadr(shape~>bBox))
	  if( llX < minX then
	    minX = llX
	  )
	  if( urX > maxX then
	    maxX = urX
	  )
	  if( llY < minY then
	    minY = llY 
	  )
	  if( urY > maxY then
	    maxY = urY
	  )
	)
      )
    )
    dbClose(cv)

    num_gates=i
    win_size=max_win_size
    winList = nil
    min_intersect = 100000

    while( win_size >= min_win_size
      num_intersect = 0
      num_windows=ceiling((maxX-minX)/win_size)
      declare(win[num_windows])

      for(j 1 num_windows
	win_coord = win_size*j+minX+2
	for( k 0 num_gates-1

	  if((car(gates[k]) <= win_coord) && (win_coord <= cadr(gates[k])) then
	    num_intersect++
	  )
	)
      )
      winList = cons(list(win_size num_intersect) winList)      

      if( num_intersect < min_intersect then
	min_intersect = num_intersect
      )
      win_size=win_size-1.0
    )
    winList = sort(winList lambda((a b) multi_sort(a b '(2))))

    maxWin = min_win_size
    k=1
    printf("\nWriting Scan Window data to Photo Info File ...\n\n")
    fprintf(REPORT "\n")
    fprintf(REPORT "Scan Window Size    No. Intersections\n")
    fprintf(REPORT "----------------    -----------------\n")
    foreach( line winList
      win = car(line)
      num = cadr(line)
      if( k <= 10 then
        if(maxWin < win && num == min_intersect then
	  maxWin = win
	)
        fprintf(REPORT "%6.2f             %d\n" win num)
	k++
      )
    )

    cv  = dbOpenCellViewByType(lib newcell "layout" "maskLayout" "a" )
    dbCreateRect(cv list("break" "drawing") list(minX+2:minY minX+0.5+2:maxY))
    dbX = minX + 2
    num_windows=ceiling((maxX-minX)/maxWin)
    for(i 1 num_windows
      dbX = dbX + maxWin 
      dbCreateRect(cv list("break" "drawing") list(dbX:minY dbX+0.5:maxY))
    )
    dbSave(cv)
    dbClose(cv)
      
  ) t
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( runDRC(cv rules_path)
  let( ()
    ivDRC(
      ?cell cv
      ?echo nil
      ?full t
      ?rulesFromUnix t
      ?rulesFilePath rules_path
    )
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure(write_deck(cv path gate)
  let( (RULES i)
    RULES = outfile(path)
    
    /* Flatten instances in cv */ 
    foreach( i cv~>instances
      dbFlattenInst(i 10 t)
    )
    
    /* Write rules to OR/Merge all the shapes on each layer*/
    fprintf(RULES "drcExtractRules(\n")
    fprintf(RULES "  %s = geomStraddle(\"%s\" \"mesa\")\n" gate gate)
    fprintf(RULES "  GRID = geomOr(\"GRID\")\n")

    foreach(layer cv~>lpps
      if( layer~>purpose == "drawing" && stringp(layer~>layerName) then
        fprintf(RULES "  geomErase(\"%s\")\n" layer~>layerName layer~>layerName)
      )
    )

    fprintf(RULES "\n")
    fprintf(RULES "  saveDerived(%s (\"%s\" \"drawing\"))\n" gate gate)
    fprintf(RULES "  saveDerived(GRID (\"GRID\" \"drawing\"))\n")
    fprintf(RULES ")\n")
    close(RULES)

    /* Run the DRC code save the cell view and delete the runset */ 
    runDRC(cv path)
    dbSave(cv)
    deleteFile(path)

  )
)

