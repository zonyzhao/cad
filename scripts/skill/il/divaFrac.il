procedure(divaFrac()
  prog( (cv lib)


/*  Setting up the form
*/
        cv=geGetWindowCellView()
	lib = cv~>libName
	
        Fld1 = hiCreateStringField(
                ?name           'design
		?value          lib
                ?prompt         "Design Name (ex pa0999) "
                                )
/* 9/14/10 - removed many options from form and added P80, P81 and P82*/
        Fld2 = hiCreateRadioField(
                ?name           'process
                ?choices        list("P46"
                                     "P51E"
				     "P51F"
                                     "P70"
                                     "P80"
                                     "P81"
				     "P82"
				     "other"
                                    )
                ?prompt         "Process: "
                                 )

	Fld3 = hiCreateRadioField(
		?name		'data_rev
		?choices	list("1" "2" "3" "4" "5" "6")
		?prompt		"Gate File Rev #  "
				)


        Fld4 = hiCreateRadioField(
                ?name           'Standard_Bias  
                ?choices        list("yes" "no")
                ?prompt         "Standard Bias:  "
                                 )

        Fld5 = hiCreateStringField(
                ?name           'runset
                ?prompt         "Non STD Runset "
        )

        Frac_Form = hiCreateAppForm(
                ?name   'Frac_Form
		?formTitle "DivaFrac Form"
		?callback "runDivaFrac()"
		?initialSize t
                ?fields list(Fld1 Fld2 Fld3 Fld4 Fld5)
                ?dialogStyle    'modal
                        )

        hiDisplayForm(Frac_Form)
  ) t
)

procedure( runDivaFrac()
  let( (cv lib cell view nci ncv saveShapes design process BiasValues runset)

    prog( ()

; assigning the data to their variable names
        design=Fld1->value
        process=Fld2->value
	dataRev=Fld3->value
        BiasValues=Fld4->value
	runset=Fld5->value
	
        lib = ddGetObj("DivaFracLib")
        libPath = ddGetObjReadPath(lib)

        sprintf(rules_path "%s/%s" libPath runset)

        unless( isFileName(rules_path) 
	  printf("%s is not a valid runset\n\n" runset)
	  return(nil)
        )

/*
; Verifying that something was inputed in design name
        if(design==""
        then
        printf( "You must enter a Design Name" )
        photoInfo()
        return( nil); causes routine to exit initial run or routine and
        )           ; only store data from the final routine

*/


	gateBias = case(process
                                ("P46" -0.007813)
                                ("P51E" -0.0125)
                                ("P51F" 0.003125)
                                ("P70" 0.003125)
				("P80" 0.0)
                                ("P81" 0.0)
                                ("P82" 0.0)
                                ( t 0.0))
        capGateBias = case(process
                                ("P46" 0.0)
                                ("P51E" 0.0)
                                ("P51F" 0.0)
                                ("P70" 0.0)
				("P80" 0.0)
                                ("P81" 0.0)
                                ("P82" 0.0)
                                ( t 0.0))
        capPadBias = case(process
                                ("P46" 0.0)
                                ("P51E" 0.0)
                                ("P51F" 0.0)
                                ("P70" 0.0)
				("P80" 0.0)
                                ("P81" 0.0)
                                ("P82" 0.0)
                                ( t 0.0))

        recessBias = case(process
                                ("P46" 0.0)
                                ("P51E" -0.225)
                                ("P51F" -0.225)
                                ("P70" 0.0)
				("P80" 0.0)
                                ("P81" 0.0)
                                ("P82" 0.0)
                                ( t 0.0))
        




if( strcmp(BiasValues "no") == 0
then

        printf("gateBias is %f\n" gateBias)
        printf("capGateBias is %f\n" capGateBias)
        printf("capPadBias is %f\n" capPadBias)
        printf("recessBias is %f\n" recessBias)


       BiasFld1 = hiCreateFloatField(
                ?name   'gateBias       
		?value	gateBias
		?acceptNil nil
		?prompt	"gateBias"
		?range (-1.0: 1.0)
		?editable t
        )
        BiasFld2 = hiCreateFloatField(
                ?name   'capGateBias      
                ?value capGateBias 
                ?acceptNil nil
                ?prompt "capGateBias"
                ?range (-1.0: 1.0)
                ?editable t
	)
        BiasFld3 = hiCreateFloatField(
                ?name   'capPadBias      
                ?value  capPadBias
                ?acceptNil nil
                ?prompt "capPadBias"
                ?range (-1.0: 1.0)
                ?editable t
	)

        BiasFld4 = hiCreateFloatField(
                ?name   'recessBias
                ?value  recessBias
                ?acceptNil nil
                ?prompt "recessBias"
                ?range (-1.0: 1.0)
                ?editable t
        )



        Bias_Form = hiCreateAppForm(
                ?name   'Bias_Form
                ?fields list(BiasFld1 BiasFld2 BiasFld3 BiasFld4)
                ?dialogStyle    'modal
                        )

        hiDisplayForm(Bias_Form)
	gateBias=BiasFld1->value
        capGateBias=BiasFld2->value
        capPadBias=BiasFld3->value
	recessBias=BiasFld4->value
)

        printf("gateBias is %f\n" gateBias)
        printf("capGateBias is %f\n" capGateBias)
        printf("capPadBias is %f\n" capPadBias)
        printf("recessBias is %f\n" recessBias)



	bias = case(BiasValues
			("yes" "std")
			("no" "nonStd")
			( t 0.0))
			


        DivaSwitch = case(process
                               ("P46" "P46")
                               ("P51E" "P51")
                               ("P51F" "P51")
                               ("P70" "P70")
			       ("P80" "P80")
			       ("P81" "mmw")
 			       ("P82" "mmw")
			       ("other" "other")
                                ( t 0))

cv = geGetWindowCellView()
lib = "DivaFracLib"
cell = cv~>cellName 
view = "layout"
nci  = list(lib cell view)

;sprintf( outcell "%s_%s_Rev%s_%s" cell DivaSwitch dataRev bias)
sprintf( outcell "%s_%s_Rev%s_%s" cell process dataRev bias)

/* nd to check if file exist before doing a copy */
ncv  = dbCopyCellView(cv car(nci) outcell cddr(nci) "" nil t) 



saveShapes = nil
ncv  = dbOpenCellViewByType(car(nci) outcell cddr(nci) "maskLayout" "a" )

techRefreshTechFile( techGetDeviceTechFile(ncv))

/******************************************************************/
/* This section will flatten the cells in the new cell view (ncv) */ 

foreach( i ncv~>instances
  if(i~>mosaic then 
    dbFlattenInst(i~>mosaic 10 t)
  else
    dbFlattenInst(i 10 t)
  )
)
printf("flattening cells\n")

foreach(i ncv~>shapes
	 if( !(strcmp( i~>objType "label") == 0) && !(strcmp( i~>objType "line") == 0) then
               leConvertShapeToPolygon(i)
	 )
)
/*****************************************************************/
/*****************************************************************/
/* This section takes all the shapes not on the specified layers */
/* and deletes them then saves the file                          */
/* 9/14/10 - updated shapes to pass more layers for Leica team   */
/*           to use when doing SEM comparisons                   */
 
foreach(i ncv~>shapes
        layName = i~>layerName
  	obj	= i~>objType

unless( rexMatchp("other" process) 

    if( stringp(layName) 
       && !(strcmp(layName "gate1") == 0) && !(strcmp(layName "gatePad") == 0)
       && !(strcmp(layName "sd") == 0) && !(strcmp(layName "GateFlag") == 0)
       && !(strcmp(layName "mesa") == 0) && !(strcmp(layName "recess") == 0)
       && !(strcmp(layName "capPad") == 0) && !(strcmp(layName "sdText") == 0)
       && !(strcmp(layName "GRID") == 0) && !(strcmp(layName "nitEtch") == 0)
       && !(strcmp(layName "poly") == 0) && !(strcmp(layName "l0") == 0)
       && !(strcmp(layName "gate") == 0) && !(strcmp(layName "SCFP") == 0)
       && !(strcmp(layName "scan") == 0)
       && !(strcmp(layName "Tgate") == 0)
       && !(strcmp(layName "eBeamMark") == 0)
       && !(strcmp(layName "TgateTop") == 0)
       && !(strcmp(layName "recTar") == 0)
       && !(strcmp(layName "outline") == 0)
       && !(strcmp(layName "stepRepeat") == 0)
       && !(strcmp(layName "l106") == 0)
       && !(strcmp(layName "l107") == 0)
       && !(strcmp(layName "l108") == 0)
       && !(strcmp(layName "noDrc") == 0)
       && !(strcmp(layName "keepout") == 0)
       && !(strcmp(layName "leGatePad") == 0)
       && !(strcmp(layName "leGate") == 0)
       && !(strcmp(layName "leGateFlag") == 0)
       && !(strcmp(layName "gateStem") == 0)
       && !(strcmp(layName "gateTop") == 0)
       && !(strcmp(layName "EBeamMark") == 0)    
       && !(strcmp(layName "capBot") == 0)
       && !(strcmp(layName "thick") == 0)
       && !(strcmp(layName "nitEtch1") == 0)
       && !(strcmp(layName "ta") == 0)
       && !(strcmp(layName "thinTa") == 0)
       && !(strcmp(layName "via") == 0)
       && !(strcmp(layName "GRID") == 0)
       && !(strcmp(layName "Metal2") == 0)
       && !(strcmp(layName "bridge") == 0)
       && !(strcmp(layName "TMPost") == 0)
       && !(strcmp(layName "tmPlate") == 0)


        then
        dbDeleteObject(i)
    )
)

)
dbSave(ncv)


/*****************************************************************/
/*****************************************************************/
/* This section calls the DRC, the defaults are set in the form  */
/* We run the DRC, save and close the file.                      */
/* If "other" is selected then run the otherDRC.rul file in the  */
/* DivaFracLib directory if not run divaDRC.rul                  */

cond( 
  ( rexMatchp("other" process)

      ivDRC(
	?cell ncv
	?echo nil
	?full t
	?set DivaSwitch
	?rulesFromUnix t
	?rulesFilePath rules_path
      )
      
  )
  (t 
        printf("gateBias is %f\n" gateBias)
        printf("capGateBias is %f\n" capGateBias)
        printf("capPadBias is %f\n" capPadBias)
        printf("recessBias is %f\n" recessBias)

ivDRC(	?cell ncv
	?echo t
	?full t
	?set DivaSwitch 
	?rulesLibName "DivaFracLib"
     )	
  )
)
/*
gateBias = 'nil
capGateBias = 'nil
capPadBias = 'nil
recessBial = 'nil
*/
dbSave(ncv)
dbClose(ncv)
/****************************************************************/

 
filePath =   ddGetObjReadPath(cv~>lib) 
owner	= ddGetObjOwner(cv~>lib)
design  = cv~>libName
op = ddGetObjOwner(ncv~>cell)
date = getCurrentTime()

sprintf( outfile "%s/release/%s.gds" filePath outcell)
sprintf( logfile "%s/release/%s.log" filePath outcell)


streamOutKeys = list( nil
'libName "DivaFracLib"
'primaryCell outcell 
'viewName "layout"
'caseSensitivity "preserve"
'outFile outfile
'errFile logfile
)

pipoDisplay( transStreamOutForm )


; port = outfile( "~parkesm/divaFrac.log" "a")
port = outfile( strcat(libPath "/release/divaFrac.log") "w")

fprintf(port "%s   \n" design)
fprintf(port "%s   %s        Layouter - %s         Fracturer - %s \n" design date owner op)
fprintf(port "%s   Process= %s \n" design  process)
fprintf(port "%s   Filename=%s \n" design outfile)
fprintf(port "%s   gateBias=%f capGateBias=%f capPadBias=%f recessBias=%f \n" design gateBias capGateBias capPadBias recessBias)
fprintf(port "%s   DivaFrac runset used: %s\n" design runset)
fprintf(port "\n")
close(port)




/*
hiFormDone(transStreamOutForm)
*/


  )
)) ; end prog and proc
