/*--------------------------	
	4.4 migration
	8/2000 M Mezger
	lint score:  83
--------------------------*/

libraryName = ""
primName = ""
oatName = ""
oatlocX = "-1"
oatlocY = "-2"
 
procedure( getInfoP()
  prog(( form)

    form = hiCreateForm( 'startmapF "Create Start Map:" ""
	    list(
		hiCreateStringField( ?name 'libraryName ?prompt 
			"Library Name:" ?value libraryName)
		hiCreateStringField( ?name 'primName ?prompt 
			"Primary Name:" ?value primName)
		hiCreateStringField( ?name 'oatName ?prompt 
			"Oat Name:" ?value oatName)
		hiCreateStringField( ?name 'oatlocX ?prompt
			"X-Location of Lower Left Oat:" ?value oatlocX)
		hiCreateStringField( ?name 'oatlocY ?prompt
			"Y-Location of Lower Left Oat:" ?value oatlocY)
		))
    when( hiDisplayForm( form)
	libraryName = form->libraryName->value
	primName = form->primName->value
	oatName = form->oatName->value
	oatlocX = form->oatlocX->value
	oatlocY = form->oatlocY->value
    )
    hiDeleteForm( form)
  )
)

procedure(IsRightLabel(labelName1 labelName2)
   prog((charPos theLabel )
	charPos = nindex(labelName1 "=")
	if(charPos==nil then
		return(nil)
	)
	theLabel = substring(labelName1 1 charPos-1)	
	if(strcmp(theLabel labelName2)==0 then
		return(t)
	else
		return(nil)
	)
))

procedure(GetLabel(label)
   prog((charPos theLabel )
        charPos = nindex(label "=")
        theLabel = substring(label 1 charPos-1)    
	return(theLabel)
))

procedure(GetValue(label)
   prog((charPos theValue )
        charPos = nindex(label "=")
        theValue = substring(label charPos+1 strlen(label))    
	theValue = evalstring(theValue)
        return(theValue)
))

procedure(FindLabel(rep labelName)
   prog((shapeList theLabel theValue )

        shapeList = rep~>shapes
        foreach(shape shapeList
		if(stringp(shape~>theLabel) then
                if(IsRightLabel(shape~>theLabel labelName) then
                theLabel = GetLabel(shape~>theLabel)
                theValue = GetValue(shape~>theLabel)
		return(theValue)
		)
	)
	)
	return(nil)
))

procedure(DeleteObjects(rep llX llY urX urY)
   prog((shapeList box llBox urBox llX2 llY2 urX2 urY2)
 

	shapeList = rep~>shapes
	foreach(shape shapeList
	box = shape~>bBox
	llBox = car(box)
	urBox = cadr(box)
	llX2 = car(llBox)
	llY2 = cadr(llBox)
	urX2 = car(urBox)
	urY2 = cadr(urBox)
	if(llX2>=llX && llY2>=llY && urX2<=urX && urY2<=urY then
		dbDeleteObject(shape)
	)
	)
)) 
procedure(DeleteLabels(rep)
   prog((shapeList)
 
        shapeList = rep~>shapes
	foreach(shape shapeList
                if(index(shape~>layerName "text") then
		dbDeleteObject(shape)
		)
	)
))

procedure(startMapValue()
  prog((msg formLabel Fld1 Form status procType)
 
        sprintf(msg "Start Map")
        formLabel = hiCreateLabel(?name 'frLabel ?labelText msg)
 
        Fld1 = hiCreateRadioField(
             ?name              'buttonPath2
             ?choices           list("NOT HBT" "HBT")
             ?prompt            "Process Type:"
        )
 
;        Form = hiCreateForm('dataMap ""
;              msg
;              list('ok 'cancel)
;              list( formLabel Fld1)
;        )
 	 Form = hiCreateAppForm(?name 'dataMap
	                        ?formTitle msg
				?buttonLayout 'OKCancel
              			?fields list( formLabel Fld1)
         )

        status = hiDisplayForm(Form)
        if(status == nil then
                return(nil)
        )
        procType=Fld1->value
        return(procType)
))

/***********************************************************/
/****   Name: startMap					****/
/****   Function: This program will plot out the 	****/
/****		startMap the following way. It will 	****/
/****		delete the nitEtch and put a label on 	****/
/****		map and then plot out the map with an	****/
/****		oat filled in the lower left oat 	****/
/****		location and a primary in the location	****/
/****		above. The user should copy the aebleMap****/
/****		to startMap and then run the program 	****/
/****		from startMap				****/
/***********************************************************/
procedure(startMap()
prog((rep lX1 lY1 labelHeight label1 llX llY urX urY
		windowId label2 procType layer2Use 
		retOffsetX retOffsetY retXm retYm)
	getInfoP()
	procType = startMapValue() 
        if(procType=="HBT" then
                layer2Use = "v2"
        else
                layer2Use = "nitEtch"
        )

	aebleName = strcat(primName "/aeblemap" )
	;rep = dbOpenCellView(libId~>libName aebleName "layout" nil "a")

	startName = strcat(primName "/startMap")

	leSetAllLayerSelectable(t)
	;dbCopyCellView(rep rep~>libName startName "layout" nil t)
	rep = geGetWindowCellView(hiGetCurrentWindow())
	windowId = hiGetCurrentWindow()

	leSetAllLayerSelectable(nil)
	leSetLayerSelectable(list(layer2Use "drawing") t)
	geSelectAllFig()
	leHiDelete()
	leSetAllLayerSelectable(t)

	retXm = FindLabel(rep "retXm")
	retYm = FindLabel(rep "retYm")
	retOffsetX = FindLabel(rep "retOffsetX")
	retOffsetY = FindLabel(rep "retOffsetY")

	if(retOffsetX==nil then
		retOffsetX=FindLabel(rep "retOffsetXm")
		retOffsetY = 0
		llX = retXm * (evalstring(oatlocX) - .5)
	else
		retOffsetX = retOffsetX- .125*retXm
		retOffsetY = 0
		llX = retXm * (evalstring(oatlocX) - .5)
	)
	llY = retOffsetY + retYm * (evalstring(oatlocY) - .5)	
	urX = llX + retXm
	urY = llY + retYm

	DeleteObjects(rep llX llY urX urY)

      	oatRep = dbOpenCellViewByType(libraryName oatName "layout" 
			"maskLayout"  "r")
      	dbCreateInst(rep oatRep nil llX+retXm/2:llY+retYm/2 "R0" 1)
	dbClose(oatRep)

	llY = llY + retYm
        urY = llY + retYm

	DeleteObjects(rep llX llY urX urY)
        primRep = dbOpenCellViewByType(libraryName primName "layout" 
			"maskLayout"  "r")
        dbCreateInst(rep primRep nil llX+retXm/2:llY+retYm/2 "R0" 1)
        dbClose(primRep)

	DeleteLabels(rep)

lX1 = xCoord(car(cdr(rep~>bBox)))
lY1 = yCoord(car(cdr(rep~>bBox)))
lX1 = lX1 - 3000
 
labelHeight = yCoord(car(rep~>bBox))-yCoord(car(cdr(rep~>bBox)))
labelHeight = abs(labelHeight/50)
lY1 = lY1 + labelHeight*4
label1=dbCreateLabel(rep "text" -800:lY1 rep~>cellName "centerLeft" "R0" "stick" labelHeight)
dbSave(rep)
;PlotOptions(rep)
;rfcLePlot(plotoptions)
dbSave(rep)	
lX1 = evalstring(oatlocX)*retXm - .5*retXm
lY1 = evalstring(oatlocY)*retYm - .5*retYm
label2=dbCreateLabel(rep "text" lX1+.5*retXm:lY1+2*retYm+100.0 rep~>cellName "centerLeft" "R0" "stick" 300.0)
hiiZoom(windowId list(lX1:lY1 lX1+retXm:lY1+2*retYm+400.0))
        ;PlotOptions(rep)
;plotoptions->bBox = list(lX1:lY1 lX1+retXm:lY1+2*retYm+400.0)
;lePlot(plotoptions)
;dbDeleteObject(label2)
;dbSave(rep)
))

procedure( rfcLePlot( plotdpl)

    lePlotOptions = copy( plotdpl)
    lePlot()
)
