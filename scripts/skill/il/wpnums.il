/*--------------------------	
	4.4 migration
	8/2000 M Mezger
	lint score:  37

	wpWafPlot COMMENTED OUT (invokes plotDFile())
--------------------------*/

; If the ham is on the wafer it returns true
; else return nil
procedure(HamOnWafer(ham iX iY )
   prog((xll yll xur yur xc yc)

	if(ham==nil then
		return(nil)
	)
 
        xll = car(car(ham))
        yll = car(cadr(ham))
        xur = car(cadr(ham))
        yur = cadr(cadr(ham))
 
        xc = float( iX) * retX
        yc = float( iY) * retY
 
        if(isOnWafer(xc+xll yc+yll) && isOnWafer(xc+xur yc+yur) then
                return(t)
        else
                return(nil)
        )
))
; Returns the number of hams in the current die
; that are inside the wafer
procedure(HamsOnWafer(rep iX iY)
  prog((bBoxHam leftHam rightHam count)
 
        count = 0
 
        bBoxHam = anFindBox(rep ham 1)
        leftHam = car(bBoxHam)
        rightHam = cadr(bBoxHam)
 
        if(HamOnWafer(leftHam iX iY) then
                count = count + 1
        )
 
        if(HamOnWafer(rightHam iX iY) then
                count = count + 1
        )
 
        return(count)
))
; This procedure will count the number of hams on 
; the wafer  
procedure(wpCountHams()
  prog(( hamCount)
 
        hamCount = 0
	for(iY llCornerY urCornerY
  		for(iX llCornerX urCornerX
			if( isNavSite( iX iY) then
        			if(processNav( iX iY) then
				hamCount = hamCount + HamsOnWafer(oatRep iX iY)
				)
			else
			hamCount = hamCount + HamsOnWafer(reticleRep iX iY)
			)
  		)
	)
 
        return(hamCount)
))

procedure(calcWaferShift()
  prog((arrayStartX arrayStartY arrayOffX arrayOffY)

        arrayStartX = (llCornerXm-0.5)*retXm
        arrayStartY = (llCornerYm-0.5)*retYm
        arrayOffX = (urCornerXm - llCornerXm) + 1
        arrayOffY = (urCornerYm - llCornerYm) + 1
        arrayOffX = arrayOffX/2.0
        arrayOffY = arrayOffY/2.0
        arrayOffX = arrayOffX * retXm
        arrayOffY = arrayOffY * retYm
; The next two values are the location of the center
; of the array
        arrayOffX = arrayStartX + arrayOffX
        arrayOffY = arrayStartY + arrayOffY
; The next two values are global variables and
; these are the values that Joe Zangri needs for
; the backside mask
        waferShiftX = arrayOffX + retOffsetXm
        waferShiftY = arrayOffY + retOffsetY
	waferShiftX = -waferShiftX
	waferShiftY = -waferShiftY
))

procedure(checkWaferLimits()
  prog((outlineRadius xLimitRight xLimitLeft yLimitLow yLimitUp
	dummy placeX placeY rightOkX leftOkX nRetXwafm nRetYwafm)

	outlineRadius = wafSize/2.0 + 200.0
	; The next two coordinates represent the center
	; of the wafer
	placeX = -retOffsetX
	placeY = -retOffsetY

	xLimitRight = (urCornerX + 0.5) * retXm
	xLimitLeft = (llCornerX - 0.5) * retXm
	yLimitUp = (urCornerY + 0.5) * retYm
	yLimitLow = (llCornerY + 0.5) * retYm

        rightOkX = t
        leftOkX = t

	; Make sure that the wafer is not outside the
	; array in the x-directions 
        dummy = placeX+outlineRadius
        if(dummy > xLimitRight then
                rightOkX = nil
        )
        dummy = placeX - outlineRadius
        if(dummy < xLimitLeft then
                leftOkX = nil
        )
        if(leftOkX==nil then
                placeX = xLimitLeft + outlineRadius
        )
        if(rightOkX==nil then
                placeX = xLimitRight - outlineRadius
        )
	; Make sure that the wafer is not outside the
        ; array in the y-directions
	dummy = placeY + outlineRadius
        while(dummy > yLimitUp 
		urCornerY = urCornerY + 1
		yLimitUp = (urCornerY + 0.5) * retYm
        )
        dummy = placeY - outlineRadius
        while(dummy < yLimitLow 
		llCornerY = llCornerY - 1
		yLimitLow = (llCornerY + 0.5) * retYm
        )
        while(!isAlmostPartialRet(0 llCornerY) 
                llCornerY = llCornerY + 1
        )
        while(!isAlmostPartialRet(0 urCornerY) 
                urCornerY = urCornerY - 1
        )
	retOffsetX = -placeX
        llCornerXm = llCornerX/Xm
        llCornerYm = llCornerY
	urCornerXm = urCornerX/Xm
	urCornerYm = urCornerY/Ym

nRetXwafm = urCornerXm - llCornerXm + 1
nRetYwafm = urCornerYm - llCornerYm + 1
if(mod(nRetXwafm  nAdieXm) == 0 then
  aRetXm = fix( nRetXwafm / nAdieXm )
else
  aRetXm = fix( nRetXwafm / nAdieXm + 1 )
  )
if(mod(nRetYwafm  nAdieYm) == 0 then
  aRetYm = fix( nRetYwafm / nAdieYm )
else
  aRetYm = fix( nRetYwafm / nAdieYm + 1 )
  )
aRetX = aRetXm * Xm
aRetY = aRetYm * Ym
nRetXwaf = nRetXwafm * Xm
nRetYwaf = nRetYwafm * Ym

	return(t)
))
	
procedure(Optimize(mX mY dX dY )
  prog((ham0 ham1 ham2 ham3 ham4 newX newY newMax)

	mX = float(fix(mX))
	mY = float(fix(mY))
	dX = float(fix(dX))
	dY = float(fix(dY))
 
        retOffsetX = mX
        retOffsetY = mY
        ham0 = wpCountHams()
 
        retOffsetX = mX + dX
        retOffsetY = mY
        ham1 = wpCountHams()
 
        retOffsetX = mX
        retOffsetY = mY + dY
        ham2 = wpCountHams()
 
        retOffsetX = mX - dX
        retOffsetY = mY
        ham3 = wpCountHams()
 
        retOffsetX = mX
        retOffsetY = mY - dY
        ham4 = wpCountHams()

 
        newX = dX
        newY = 0.0
        newMax = ham1
        if(ham2 > newMax then
                newX = 0.0
                newY = dY
                newMax = ham2
        )
        if(ham3 > newMax then
                newX = -dX
                newY = 0.0
                newMax = ham3
        )
        if(ham4 > newMax then
                newX = 0.0
                newY = -dY
                newMax = ham4
        )
 
        if(newX==0.0 then
                dY = dY/2.0
        else
                dX = dX/2.0
        )
 
        mX = mX + newX/2.0
        mY = mY + newY/2.0
 
        mX = float(fix(mX))
        mY = float(fix(mY))
        dX = float(fix(dX))
        dY = float(fix(dY))
 
        return(list(mX mY dX dY))
))
 
procedure(OptHam(layerStr)
  prog(( mX mY dX dY optCount)

 
        if(layerStr=="mmic"
        then ham = "ret_req_ham"
        )
        if(layerStr=="d_mmic"
        then ham = "ret_req_ham_dig"
        )
        if(layerStr=="ed_mmic"
        then ham = "ret_req_ham_ed"
        )
        if(layerStr=="hbt"
        then ham = "ret_req_ham_hbt"
        )
 
        optCount = 0
 
 
        mX = 0
        mY = 0
        dX = retXm
        dY = retYm
        while(optCount<20
	optCount = optCount + 1
        listValues = Optimize(mX mY dX dY)
        mX = car(listValues)
        mY = cadr(listValues)
        dX = cadr(cdr(listValues))
        dY = cadr(cddr(listValues))
        )
	checkWaferLimits()
        retOffsetXm = retOffsetX*Xm
        retOffsetYm = retOffsetY*Ym
if(newOat=="false" then
findNavSites()                                  ; from retX, retY, retXm, retYm,
)
oat1X = xCoord( car(navaidSites))
oat1Y = yCoord( car(navaidSites))
oat2X = xCoord( cadr(navaidSites))
oat2Y = yCoord( cadr(navaidSites))
oat3X = xCoord( caddr(navaidSites))
oat3Y = yCoord( caddr(navaidSites))
;oat3X = 0
;oat3Y = 0
if(oat1Y+1 >= oat3Y then
        oat3Y = oat1Y + 2
)
FixTheNav() 
findOatFieldOffsets()

))
;********************************************************************
; otherwise known as:

;global variable for XYnumber placement 
padOrientation = "R0"

procedure(Enter1Pad()
   prog((msg padDwg1 formLabel Fld1 Form status)
    	sprintf( msg "Specify the xy number pad")
	sprintf(padDwg1 "%s_keys_xy_num" retDwg) ;

        formLabel = hiCreateLabel(?name 'frLabel ?labelText msg)
 
        Fld1 = hiCreateStringField(
             ?name              'buttonPath1
             ?value             padDwg1
             ?defValue         	padDwg1 
             ?prompt            "xy number pad"
           )
 
        Form = hiCreateForm(
             'entP1
             msg
             list('ok 'cancel)
             list(formLabel Fld1)
        )
 
        status = hiDisplayForm(Form)
        if(status == nil then
                return(nil)
        )
 
	padDwg1 = Fld1->value

	padDwgList = nil
	padDwgList = list(padDwg1)
        return(padDwgList)
))
procedure(Enter2Pad()
   prog((msg padDwg1 padDwg2 formLabel Fld1 Fld2 Form status)
        sprintf( msg "Specify the xy number pad")
        sprintf(padDwg1 "%s_keys_xy_num" retDwg) ;
	sprintf(padDwg2 "%s_keys_xy_num" retDwg)  
        padDwgList = nil

        formLabel = hiCreateLabel(?name 'frLabel ?labelText msg)
 
        Fld1 = hiCreateStringField(
             ?name              'buttonPath1
             ?value             padDwg1
             ?defValue          padDwg1 
             ?prompt            "xy number pad"
           )

        Fld2 = hiCreateStringField(
             ?name              'buttonPath2
             ?value             padDwg2
             ?defValue          padDwg2
             ?prompt            "xy number pad"
           )
 
        Form = hiCreateForm(
             'entP2
             msg
             list('ok 'cancel)
             list(formLabel Fld1 Fld2)
        )
 
        status = hiDisplayForm(Form)
        if(status == nil then
                return(nil)
        )
 
        padDwg1 = Fld1->value
	padDwg2 = Fld2->value
 
        padDwgList = list(padDwg1 padDwg2)
        return(padDwgList)
))
procedure(Enter3Pad()
   prog((msg padDwg1 padDwg2 padDwg3 formLabel Fld1 Fld2 Fld3 Form status)
        sprintf( msg "Specify the xy number pad")
        sprintf(padDwg1 "%s_keys_xy_num" retDwg) ;
        sprintf(padDwg2 "%s_keys_xy_num" retDwg)
        sprintf(padDwg3 "%s_keys_xy_num" retDwg)

        padDwgList = nil

        formLabel = hiCreateLabel(?name 'frLabel ?labelText msg)
 
        Fld1 = hiCreateStringField(
             ?name              'buttonPath1
             ?value             padDwg1
             ?defValue          padDwg1 
             ?prompt            "xy number pad"
           )
 
        Fld2 = hiCreateStringField(
             ?name              'buttonPath2
             ?value             padDwg2
             ?defValue          padDwg2 
             ?prompt            "xy number pad"
           )

        Fld3 = hiCreateStringField(
             ?name              'buttonPath3
             ?value             padDwg3
             ?defValue          padDwg3
             ?prompt            "xy number pad"
           )
 
        Form = hiCreateForm(
             'entP3
             msg
             list('ok 'cancel)
             list(formLabel Fld1 Fld2 Fld3)
        )
 
        status = hiDisplayForm(Form)
        if(status == nil then
                return(nil)
        )
 
        padDwg1 = Fld1->value
        padDwg2 = Fld2->value
	padDwg3 = Fld3->value
 
        padDwgList = list(padDwg1 padDwg2 padDwg3)
        return(padDwgList)
))
procedure(Enter4Pad()
   prog((msg padDwg1 padDwg2 padDwg3 padDwg4
	 formLabel Fld1 Fld2 Fld3 Fld4 Form status)
        sprintf( msg "Specify the xy number pad")
        sprintf(padDwg1 "%s_keys_xy_num" retDwg) ;
        sprintf(padDwg2 "%s_keys_xy_num" retDwg)
        sprintf(padDwg3 "%s_keys_xy_num" retDwg)
	sprintf(padDwg4 "%s_keys_xy_num" retDwg)
 
        padDwgList = nil

        formLabel = hiCreateLabel(?name 'frLabel ?labelText msg)
 
        Fld1 = hiCreateStringField(
             ?name              'buttonPath1
             ?value             padDwg1
             ?defValue          padDwg1
             ?prompt            "xy number pad"
           )
 
        Fld2 = hiCreateStringField(
             ?name              'buttonPath2
             ?value             padDwg2
             ?defValue          padDwg2
             ?prompt            "xy number pad"
           )
 
        Fld3 = hiCreateStringField(
             ?name              'buttonPath3
             ?value             padDwg3
             ?defValue          padDwg3
             ?prompt            "xy number pad"
           )

        Fld4 = hiCreateStringField(
             ?name              'buttonPath4
             ?value             padDwg4
             ?defValue          padDwg4
             ?prompt            "xy number pad"
           )
 
        Form = hiCreateForm(
             'entP4
             msg
             list('ok 'cancel)
             list(formLabel Fld1 Fld2 Fld3 Fld4)
        )
 
        status = hiDisplayForm(Form)
        if(status == nil then
                return(nil)
        )
 
        padDwg1 = Fld1->value
        padDwg2 = Fld2->value
        padDwg3 = Fld3->value
	padDwg4 = Fld4->value
 
        padDwgList = list(padDwg1 padDwg2 padDwg3 padDwg4)
        return(padDwgList)
))
procedure(Enter5Pad()
   prog((msg padDwg1 padDwg2 padDwg3 padDwg4 padDwg5
	 formLabel Fld1 Fld2 Fld3 Fld4 Fld5 Form status)
        sprintf( msg "Specify the xy number pad")
        sprintf(padDwg1 "%s_keys_xy_num" retDwg) ;
        sprintf(padDwg2 "%s_keys_xy_num" retDwg)
        sprintf(padDwg3 "%s_keys_xy_num" retDwg)
        sprintf(padDwg4 "%s_keys_xy_num" retDwg) 
        sprintf(padDwg5 "%s_keys_xy_num" retDwg) 
 
        padDwgList = nil

        formLabel = hiCreateLabel(?name 'frLabel ?labelText msg)
 
        Fld1 = hiCreateStringField(
             ?name              'buttonPath1
             ?value             padDwg1
             ?defValue          padDwg1
             ?prompt            "xy number pad"
           )
 
        Fld2 = hiCreateStringField(
             ?name              'buttonPath2
             ?value             padDwg2
             ?defValue          padDwg2
             ?prompt            "xy number pad"
           )
 
        Fld3 = hiCreateStringField(
             ?name              'buttonPath3
             ?value             padDwg3
             ?defValue          padDwg3
             ?prompt            "xy number pad"
           )
 
        Fld4 = hiCreateStringField(
             ?name              'buttonPath4
             ?value             padDwg4
             ?defValue          padDwg4
             ?prompt            "xy number pad"
           )

        Fld5 = hiCreateStringField(
             ?name              'buttonPath5
             ?value             padDwg5
             ?defValue          padDwg5
             ?prompt            "xy number pad"
           )
 
        Form = hiCreateForm(
             'entP5
             msg
             list('ok 'cancel)
             list(formLabel Fld1 Fld2 Fld3 Fld4 Fld5)
        )
 
        status = hiDisplayForm(Form)
        if(status == nil then
                return(nil)
        )
 
        padDwg1 = Fld1->value
        padDwg2 = Fld2->value
        padDwg3 = Fld3->value
        padDwg4 = Fld4->value
	padDwg5 = Fld5->value
 
        padDwgList = list(padDwg1 padDwg2 padDwg3 padDwg4 padDwg5)
        return(padDwgList)
))

procedure(Get1NameNumber(nameList passFlag)
   prog((msg chipName form)
        if(passFlag==0 then
    sprintf( msg "Specify the number and name for each chip")
        else
    sprintf( msg "Specify the names for the rest of the chips")
        )
 
    form = hiCreateForm( 'Get1Name msg "" 
	     list(
		hiCreateCyclicField( ?name 'chipName ?value car( nameList)
		  ?choices nameList ?prompt "Chip cell name")
	     ))
    unless( hiDisplayForm( form) hiDeleteForm( form) return( nil))
    chipName = form->chipName->value
    hiDeleteForm( form)
 
        if(passFlag==0 then
        return(list(chipName chipName))
        else
        return(list(chipName))
        )
))
 
procedure(Get2NameNumber(nameList passFlag)
   prog((msg dummyName dummyNum chipName chipName1 chipName2 form)
	if(passFlag==0 then
    sprintf( msg "Specify the number and name for each chip")
        else
    sprintf( msg "Specify the names for the rest of the chips")
        )

        dummyName = car(nameList)
        dummyNum = substring(dummyName strlen(dummyName)-1 1)

	if(passFlag==0 then 

	  form = hiCreateForm( 'Get2A msg ""
		   list(
			hiCreateStringField( ?name 'chipName ?value dummyName
				?prompt "Map Name")
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))

	else

	  form = hiCreateForm( 'Get2A msg ""
		   list(
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))
	)
	unless( hiDisplayForm( form) hiDeleteForm( form) return( nil))
	when( passFlag == 0 chipName = form->chipName->value)
	chipName1 = form->chipName1->value
	chipName2 = form->chipName2->value
	hiDeleteForm( form)

	if(passFlag==0 then
        return(list(chipName chipName1 chipName2))
	else
	return(list(chipName1 chipName2))
	)
))
 
procedure(Get3NameNumber(nameList passFlag)
   prog((msg dummyName chipName chipName1 chipName2 chipName3 dummyNum form)

	if(passFlag==0 then
    sprintf( msg "Specify the number and name for each chip")
	else
    sprintf( msg "Specify the names for the rest of the chips")
        )

        dummyName = car(nameList)
	dummyNum = substring(dummyName strlen(dummyName)-1 1) 

	if(passFlag==0 then 

	  form = hiCreateForm( 'Get3A msg ""
		   list(
			hiCreateStringField( ?name 'chipName ?value dummyName
				?prompt "Map Name")
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))

	else

	  form = hiCreateForm( 'Get3A msg ""
		   list(
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))
	)
	unless( hiDisplayForm( form) hiDeleteForm( form) return( nil))
	when( passFlag == 0 chipName = form->chipName->value)
	chipName1 = form->chipName1->value
	chipName2 = form->chipName2->value
	chipName3 = form->chipName3->value
	hiDeleteForm( form)

	if(passFlag==0 then
        return(list(chipName chipName1 chipName2 chipName3))
	else
	return(list(chipName1 chipName2 chipName3))
	)
))
 
procedure(Get4NameNumber(nameList passFlag)
   prog((msg dummyName chipName1 chipName2 chipName3 chipName4 chipName 
	dummyNum form)
	if(passFlag==0 then
    sprintf( msg "Specify the number and name for each chip")
	else
    sprintf( msg "Specify the names for the rest of the chips")
        )

        dummyName = car(nameList)
	dummyNum = substring(dummyName strlen(dummyName)-1 1) 

	if(passFlag==0 then

	  form = hiCreateForm( 'Get4A msg ""
		   list(
			hiCreateStringField( ?name 'chipName ?value dummyName
				?prompt "Map Name")
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))

	else

	  form = hiCreateForm( 'Get4A msg ""
		   list(
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))
	)
	unless( hiDisplayForm( form) hiDeleteForm( form) return( nil))
	when( passFlag == 0 chipName = form->chipName->value)
	chipName1 = form->chipName1->value
	chipName2 = form->chipName2->value
	chipName3 = form->chipName3->value
	chipName4 = form->chipName4->value
	hiDeleteForm( form)

        if(passFlag==0 then
	return(list(chipName chipName1 chipName2 chipName3 chipName4 ))
	else
	return(list(chipName1 chipName2 chipName3 chipName4))
	)
))

procedure(Get5NameNumber(nameList passFlag)
   prog((msg dummyName chipName1 chipName2 chipName3 chipName4 
	chipName5 chipName dummyNum form)
        if(passFlag==0 then
    sprintf( msg "Specify the number and name for each chip")
        else
    sprintf( msg "Specify the names for the rest of the chips")
        )

        dummyName = car(nameList)
        dummyNum = substring(dummyName strlen(dummyName)-1 1)

	if(passFlag==0 then

	  form = hiCreateForm( 'Get5A msg ""
		   list(
			hiCreateStringField( ?name 'chipName ?value dummyName
				?prompt "Map Name")
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName5 ?value
				nth( 4 nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))

	else

	  form = hiCreateForm( 'Get5A msg ""
		   list(
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName5 ?value
				nth( 4 nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))
	)
	unless( hiDisplayForm( form) hiDeleteForm( form) return( nil))
	when( passFlag == 0 chipName = form->chipName->value)
	chipName1 = form->chipName1->value
	chipName2 = form->chipName2->value
	chipName3 = form->chipName3->value
	chipName4 = form->chipName4->value
	chipName5 = form->chipName5->value
	hiDeleteForm( form)

	if(passFlag==0 then
        return(list(chipName chipName1 chipName2 chipName3 chipName4 chipName5))
	else
	return(list(chipName1 chipName2 chipName3 chipName4 chipName5))
	)
))

procedure(Get6NameNumber(nameList passFlag)
   prog((msg dummyName chipName1 chipName2 chipName3 chipName4 
        chipName5 chipName6 chipName dummyNum form)
        if(passFlag==0 then
    sprintf( msg "Specify the number and name for each chip")
        else
    sprintf( msg "Specify the names for the rest of the chips")
        )

        dummyName = car(nameList)
        dummyNum = substring(dummyName strlen(dummyName)-1 1)

        if(passFlag==0 then

	  form = hiCreateForm( 'Get6A msg ""
		   list(
			hiCreateStringField( ?name 'chipName ?value dummyName
				?prompt "Map Name")
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName5 ?value
				nth( 4 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName6 ?value
				nth( 5 nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))

	else

	  form = hiCreateForm( 'Get6A msg ""
		   list(
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName5 ?value
				nth( 4 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName6 ?value
				nth( 5 nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))
	)
	unless( hiDisplayForm( form) hiDeleteForm( form) return( nil))
	when( passFlag == 0 chipName = form->chipName->value)
	chipName1 = form->chipName1->value
	chipName2 = form->chipName2->value
	chipName3 = form->chipName3->value
	chipName4 = form->chipName4->value
	chipName5 = form->chipName5->value
	chipName6 = form->chipName6->value
	hiDeleteForm( form)

	if(passFlag==0 then
        return(list(chipName chipName1 chipName2 chipName3 chipName4 chipName5 
chipName6))
	else
	return(list(chipName1 chipName2 chipName3 chipName4 chipName5 chipName6))	)
))

procedure(Get7NameNumber(nameList passFlag)
   prog((msg dummyName chipName1 chipName2 chipName3 chipName4 
        chipName5 chipName6 chipName7 chipName dummyNum form)
        if(passFlag==0 then
    sprintf( msg "Specify the number and name for each chip")
        else
    sprintf( msg "Specify the names for the rest of the chips")
        )

        dummyName = car(nameList)
        dummyNum = substring(dummyName strlen(dummyName)-1 1)

	if(passFlag==0 then

	  form = hiCreateForm( 'Get7A msg ""
		   list(
			hiCreateStringField( ?name 'chipName ?value dummyName
				?prompt "Map Name")
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName5 ?value
				nth( 4 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName6 ?value
				nth( 5 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName7 ?value
				nth( 6 nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))

	else

	  form = hiCreateForm( 'Get7A msg ""
		   list(
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName5 ?value
				nth( 4 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName6 ?value
				nth( 5 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName7 ?value
				nth( 6 nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))
	)
	unless( hiDisplayForm( form) hiDeleteForm( form) return( nil))
	when( passFlag == 0 chipName = form->chipName->value)
	chipName1 = form->chipName1->value
	chipName2 = form->chipName2->value
	chipName3 = form->chipName3->value
	chipName4 = form->chipName4->value
	chipName5 = form->chipName5->value
	chipName6 = form->chipName6->value
	chipName7 = form->chipName7->value
	hiDeleteForm( form)

	if(passFlag==0 then
        return(list(chipName chipName1 chipName2 chipName3 chipName4 chipName5 
chipName6 chipName7))
	else
	return(list(chipName1 chipName2 chipName3 chipName4 chipName5 chipName6 chipName7))
	)
))
procedure(Get8NameNumber(nameList passFlag)
   prog((msg dummyName chipName1 chipName2 chipName3 chipName4
        chipName5 chipName6 chipName7 chipName8 chipName dummyNum form)
        if(passFlag==0 then
    sprintf( msg "Specify the number and name for each chip")
        else
    sprintf( msg "Specify the names for the rest of the chips")
        )

        dummyName = car(nameList)
        dummyNum = substring(dummyName strlen(dummyName)-1 1)

	if(passFlag==0 then

	  form = hiCreateForm( 'Get8A msg ""
		   list(
			hiCreateStringField( ?name 'chipName ?value dummyName
				?prompt "Map Name")
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName5 ?value
				nth( 4 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName6 ?value
				nth( 5 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName7 ?value
				nth( 6 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName8 ?value
				nth( 7 nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))

	else

	  form = hiCreateForm( 'Get8A msg ""
		   list(
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName5 ?value
				nth( 4 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName6 ?value
				nth( 5 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName7 ?value
				nth( 6 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName8 ?value
				nth( 7 nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))
	)
	unless( hiDisplayForm( form) hiDeleteForm( form) return( nil))
	when( passFlag == 0 chipName = form->chipName->value)
	chipName1 = form->chipName1->value
	chipName2 = form->chipName2->value
	chipName3 = form->chipName3->value
	chipName4 = form->chipName4->value
	chipName5 = form->chipName5->value
	chipName6 = form->chipName6->value
	chipName7 = form->chipName7->value
	chipName8 = form->chipName8->value
	hiDeleteForm( form)

	if(passFlag==0 then
        return(list(chipName chipName1 chipName2 chipName3 chipName4 chipName5 
chipName6 chipName7 chipName8))
	else
        return(list(chipName1 chipName2 chipName3 chipName4 chipName5
chipName6 chipName7 chipName8))
	)
))

procedure(Get9NameNumber(nameList passFlag)
   prog((msg dummyName chipName1 chipName2 chipName3 chipName4
        chipName5 chipName6 chipName7 chipName8 chipName9 chipName dummyNum
	form)
        if(passFlag==0 then
    sprintf( msg "Specify the number and name for each chip")
        else
    sprintf( msg "Specify the names for the rest of the chips")
        )
        dummyName = car(nameList)
        dummyNum = substring(dummyName strlen(dummyName)-1 1)
	if(passFlag==0 then

	  form = hiCreateForm( 'Get9A msg ""
		   list(
			hiCreateStringField( ?name 'chipName ?value dummyName
				?prompt "Map Name")
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName5 ?value
				nth( 4 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName6 ?value
				nth( 5 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName7 ?value
				nth( 6 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName8 ?value
				nth( 7 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName9 ?value
				nth( 8 nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))

	else

	  form = hiCreateForm( 'Get9A msg ""
		   list(
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName5 ?value
				nth( 4 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName6 ?value
				nth( 5 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName7 ?value
				nth( 6 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName8 ?value
				nth( 7 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName9 ?value
				nth( 8 nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))
	)
	unless( hiDisplayForm( form) hiDeleteForm( form) return( nil))
	when( passFlag == 0 chipName = form->chipName->value)
	chipName1 = form->chipName1->value
	chipName2 = form->chipName2->value
	chipName3 = form->chipName3->value
	chipName4 = form->chipName4->value
	chipName5 = form->chipName5->value
	chipName6 = form->chipName6->value
	chipName7 = form->chipName7->value
	chipName8 = form->chipName8->value
	chipName9 = form->chipName9->value
	hiDeleteForm( form)

	if(passFlag==0 then
        return(list(chipName chipName1 chipName2 chipName3 chipName4 chipName5 
chipName6 chipName7 chipName8 chipName9))
	else
	return(list(chipName1 chipName2 chipName3 chipName4 chipName5
chipName6 chipName7 chipName8 chipName9))
	)
))

procedure(Get10NameNumber(nameList)
   prog((msg dummyName chipName1 chipName2 chipName3 chipName4
        chipName5 chipName6 chipName7 chipName8 chipName9 chipName10
		chipName dummyNum form)
    sprintf( msg "Specify the number and name for each chip")
        dummyName = car(nameList)
        dummyNum = substring(dummyName strlen(dummyName)-1 1)

	form = hiCreateForm( 'Get10A msg ""
		   list(
			hiCreateStringField( ?name 'chipName ?value dummyName
				?prompt "Map Name")
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName5 ?value
				nth( 4 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName6 ?value
				nth( 5 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName7 ?value
				nth( 6 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName8 ?value
				nth( 7 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName9 ?value
				nth( 8 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName10 ?value
				nth( 9 nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))

	unless( hiDisplayForm( form) hiDeleteForm( form) return( nil))
	chipName  = form->chipName->value
	chipName1 = form->chipName1->value
	chipName2 = form->chipName2->value
	chipName3 = form->chipName3->value
	chipName4 = form->chipName4->value
	chipName5 = form->chipName5->value
	chipName6 = form->chipName6->value
	chipName7 = form->chipName7->value
	chipName8 = form->chipName8->value
	chipName9 = form->chipName9->value
	chipName10 = form->chipName10->value
	hiDeleteForm( form)

        return(list(chipName chipName1 chipName2 chipName3 chipName4 chipName5 chipName6 chipName7 chipName8 chipName9 chipName10))
))
procedure(First10NameNumber(nameList)
   prog((msg dummyName chipName1 chipName2 chipName3 chipName4
        chipName5 chipName6 chipName7 chipName8 chipName9 chipName10
                chipName dummyNum form)
    sprintf( msg "Specify the number and name for the first 10 chips")
        dummyName = car(nameList)
        dummyNum = substring(dummyName strlen(dummyName)-1 1)

	form = hiCreateForm( 'Get10B msg ""
		   list(
			hiCreateStringField( ?name 'chipName ?value dummyName
				?prompt "Map Name")
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName5 ?value
				nth( 4 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName6 ?value
				nth( 5 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName7 ?value
				nth( 6 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName8 ?value
				nth( 7 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName9 ?value
				nth( 8 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName10 ?value
				nth( 9 nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))

	unless( hiDisplayForm( form) hiDeleteForm( form) return( nil))
	chipName  = form->chipName->value
	chipName1 = form->chipName1->value
	chipName2 = form->chipName2->value
	chipName3 = form->chipName3->value
	chipName4 = form->chipName4->value
	chipName5 = form->chipName5->value
	chipName6 = form->chipName6->value
	chipName7 = form->chipName7->value
	chipName8 = form->chipName8->value
	chipName9 = form->chipName9->value
	chipName10 = form->chipName10->value
	hiDeleteForm( form)

        return(list(chipName chipName1 chipName2 chipName3 chipName4 chipName5 chipName6 chipName7 chipName8 chipName9 chipName10))
))
procedure(Next10NameNumber(nameList)
   prog((msg dummyName chipName1 chipName2 chipName3 chipName4
        chipName5 chipName6 chipName7 chipName8 chipName9 chipName10
                 dummyNum form)
    sprintf( msg "Specify the number and name for the next 10 chips")
        dummyName = car(nameList)
        dummyNum = substring(dummyName strlen(dummyName)-1 1)

	form = hiCreateForm( 'Get10C msg ""
		   list(
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName5 ?value
				nth( 4 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName6 ?value
				nth( 5 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName7 ?value
				nth( 6 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName8 ?value
				nth( 7 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName9 ?value
				nth( 8 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName10 ?value
				nth( 9 nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))

	unless( hiDisplayForm( form) hiDeleteForm( form) return( nil))
	chipName1 = form->chipName1->value
	chipName2 = form->chipName2->value
	chipName3 = form->chipName3->value
	chipName4 = form->chipName4->value
	chipName5 = form->chipName5->value
	chipName6 = form->chipName6->value
	chipName7 = form->chipName7->value
	chipName8 = form->chipName8->value
	chipName9 = form->chipName9->value
	chipName10 = form->chipName10->value
	hiDeleteForm( form)

        return(list(chipName1 chipName2 chipName3 chipName4 chipName5 chipName6 chipName7 chipName8 chipName9 chipName10))
))

procedure(Get11NameNumber(nameList)
   prog((msg dummyName chipName1 chipName2 chipName3 chipName4
        chipName5 chipName6 chipName7 chipName8 chipName9 chipName10
		chipName11 chipName dummyNum form)
    sprintf( msg "Specify the number and name for each chip")
        dummyName = car(nameList)
        dummyNum = substring(dummyName strlen(dummyName)-1 1)

	form = hiCreateForm( 'Get11A msg ""
		   list(
			hiCreateStringField( ?name 'chipName ?value dummyName
				?prompt "Map Name")
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName5 ?value
				nth( 4 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName6 ?value
				nth( 5 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName7 ?value
				nth( 6 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName8 ?value
				nth( 7 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName9 ?value
				nth( 8 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName10 ?value
				nth( 9 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName11 ?value
				nth( 10 nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))

	unless( hiDisplayForm( form) hiDeleteForm( form) return( nil))
	chipName  = form->chipName->value
	chipName1 = form->chipName1->value
	chipName2 = form->chipName2->value
	chipName3 = form->chipName3->value
	chipName4 = form->chipName4->value
	chipName5 = form->chipName5->value
	chipName6 = form->chipName6->value
	chipName7 = form->chipName7->value
	chipName8 = form->chipName8->value
	chipName9 = form->chipName9->value
	chipName10 = form->chipName10->value
	chipName11 = form->chipName11->value
	hiDeleteForm( form)

        return(list(chipName chipName1 chipName2 chipName3 chipName4 chipName5 chipName6 chipName7 chipName8 chipName9 chipName10 chipName11))
))

procedure(Get12NameNumber(nameList)
   prog((msg dummyName chipName1 chipName2 chipName3 chipName4
        chipName5 chipName6 chipName7 chipName8 chipName9 chipName10
                chipName11 chipName12 chipName dummyNum form)
    sprintf( msg "Specify the number and name for each chip")
        dummyName = car(nameList)
        dummyNum = substring(dummyName strlen(dummyName)-1 1)

	form = hiCreateForm( 'Get12A msg ""
		   list(
			hiCreateStringField( ?name 'chipName ?value dummyName
				?prompt "Map Name")
			hiCreateCyclicField( ?name 'chipName1 ?value
				car( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName2 ?value
				cadr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName3 ?value
				caddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName4 ?value
				cadddr( nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName5 ?value
				nth( 4 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName6 ?value
				nth( 5 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName7 ?value
				nth( 6 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName8 ?value
				nth( 7 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName9 ?value
				nth( 8 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName10 ?value
				nth( 9 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName11 ?value
				nth( 10 nameList) ?choices nameList
				?prompt "Chip cell name")
			hiCreateCyclicField( ?name 'chipName12 ?value
				nth( 11 nameList) ?choices nameList
				?prompt "Chip cell name")
		   ))

	unless( hiDisplayForm( form) hiDeleteForm( form) return( nil))
	chipName  = form->chipName->value
	chipName1 = form->chipName1->value
	chipName2 = form->chipName2->value
	chipName3 = form->chipName3->value
	chipName4 = form->chipName4->value
	chipName5 = form->chipName5->value
	chipName6 = form->chipName6->value
	chipName7 = form->chipName7->value
	chipName8 = form->chipName8->value
	chipName9 = form->chipName9->value
	chipName10 = form->chipName10->value
	chipName11 = form->chipName11->value
	chipName12 = form->chipName12->value
	hiDeleteForm( form)

        return(list(chipName chipName1 chipName2 chipName3 chipName4 chipName5 
chipName6 chipName7 chipName8 chipName9 chipName10 chipName11 chipName12))
))
 
 
;*******************************************************************
; Name: GetPassChips
; Parameters: It receives the passlist
; Function: Returns the new chipList
procedure(GetPassChips(passList)
   prog((passName chipNames passSites passOrient passBBox chip)

	passName = car(passList)
	chipNames = cdr(passList)

	passSites = nil
	foreach(chipName chipNames
		foreach(chip1 chipList
			if(strcmp(chipName car(chip1))==0 then
				passSites = append(passSites caddr(chip1))
				passBBox = cadr(cddr(chip1))
				passOrient = cadr(chip1)
			)
		)
	)


	passList = nil
	passSites = wpXySort(passSites)
	if(passSites!=nil then
	chip = list(passName passOrient passSites passBBox)
	passList = cons(chip passList)
	)
	return(passList)
))
;*******************************************************************
; Name: GetOmitChips
; Parameters: It receives the passlist
; Function: Returns the chips not used 
procedure(GetOmitChips(passList)
   prog((passName chipNames omitList)
 
        passName = car(passList)
        chipNames = cdr(passList)
 
        omitList = nil
        foreach(chip chipList
                if(!member(car(chip) chipNames) then
                        omitList = cons(chip omitList)
                )
        )
 
 
        return(omitList)
))

;*******************************************************************
; Name: GetOatPassChips
; Parameters: It receives the passlist
; Function: Returns the new chipList
procedure(GetOatPassChips(passList)
   prog((passName chipNames passSites passOrient passBBox chip)
 
        passName = car(passList)        
        chipNames = cdr(passList)      
 
        passSites = nil
        foreach(chipName chipNames 
                foreach(chip1 oatChipList  
                        if(strcmp(chipName car(chip1))==0 then  
                                passSites = append(passSites caddr(chip1))
                                passBBox = cadr(cddr(chip1))
                                passOrient = cadr(chip1)
                        )
                )
        )

        passList = nil

	passSites = wpXySort(passSites) 
        if(passSites!=nil then
        chip = list(passName passOrient passSites passBBox)
        passList = cons(chip passList)
        )

        return(passList)       
))

;*******************************************************************
; Name: GetOatOmitChips
; Parameters: It receives the passlist
; Function: Returns the new chipList
procedure(GetOatOmitChips(passList)
   prog((passName chipNames omitList)
 
        passName = car(passList) 
        chipNames = cdr(passList)
 
        omitList = nil
        foreach(chip oatChipList
                if(!member(car(chip) chipNames) then
                        omitList = cons(chip omitList)
                )
        )
 
        return(omitList)
))

procedure(GetChips(passList)
  prog((useList omitList)
        useList = GetPassChips(passList)
        omitList = GetOmitChips(passList)
	if(useList==nil then
	chipList = omitList
	else
        chipList = append(useList omitList)
	)
))
 
procedure(GetOatChips(passList)
  prog((useList omitList)
        useList = GetOatPassChips(passList)
        omitList = GetOatOmitChips(passList)
	if(useList==nil then
	oatChipList = omitList
	else
        oatChipList = append(useList omitList)
	)
))

;*******************************************************************
; Name: IsCouponChip
; Parameters: It receives name of chip
; Function: Returns t if the chip is a coupon
procedure(isCouponChip(chipName)
   prog((chipNum couponChip numName)
	if(chipName==nil then
		return(nil)
	)
	if(index(chipName ".") then
		numName = nindex(chipName ".")
		chipName = substring(chipName 1 numName-1)
	)

	couponChip = nil
	chipNum = substring(chipName strlen(chipName)-1 2)
	chipName = chipNum
        if(index(chipName "99") then
            couponChip = t
        )
        if(index(chipName "98") then
            couponChip = t
        )
        if(index(chipName "97") then
            couponChip = t
        )
        if(index(chipName "96") then
            couponChip = t
        )
        if(index(chipName "95") then
            couponChip = t
        )
        if(index(chipName "94") then
            couponChip = t
        )
        if(index(chipName "90") then
            couponChip = t
        )

	return(couponChip)
))
procedure(isNCouponChip(chipName)
   prog((chipNum couponChip numName)
	if(chipName==nil then
		return(nil)
	)
        if(index(chipName ".") then
                numName = nindex(chipName ".")
                chipName = substring(chipName 1 numName-1)
        )
        couponChip = nil
        chipNum = substring(chipName strlen(chipName)-1 2)
        chipName = chipNum
        if(index(chipName "89") then
            couponChip = t
        )
        if(index(chipName "88") then
            couponChip = t
        )
        if(index(chipName "87") then
            couponChip = t
        )
        if(index(chipName "86") then
            couponChip = t
        )
        if(index(chipName "85") then
            couponChip = t
        )
        if(index(chipName "84") then
            couponChip = t
        )
        if(index(chipName "83") then
            couponChip = t
        )
        if(index(chipName "82") then
            couponChip = t
        )
        if(index(chipName "81") then
            couponChip = t
        )
        if(index(chipName "80") then
            couponChip = t
        )
 
        return(couponChip)
))
;*******************************************************************
; Name: GetNumX
; Parameters: It receives die number(iX iY),the number of
; 		chips in x direction in primary(nX),
;		the number of chips in x direction in oat(nX2),
;		and the number of chips in x direction in left hand
;		side of oat(nX4).
; Function: Returns the wafer number x
procedure(GetNumX(chipName)
   prog(( listChips nX oldMaxX oldMaxY)
	listChips = chipList
	oldMaxX = maxX
 	oldMaxY = maxY

	foreach(chip chipList
		if(chipName==car(chip) then
			sites = caddr(chip)
		)
	)
	sites = wpXySort(sites)
	nX = maxX
	maxX = oldMaxX
        maxY = oldMaxY

        return(nX)
))
procedure(GetNumY(chipName)
   prog(( listChips nY oldMaxX oldMaxY)
        listChips = chipList
        oldMaxX = maxX
        oldMaxY = maxY
 
        foreach(chip chipList
                if(chipName==car(chip) then
                        sites = caddr(chip)
                )
        )
        sites = wpXySort(sites)
        nY = maxY
        maxX = oldMaxX
        maxY = oldMaxY
 
        return(nY)
))

;*******************************************************************
; Name: GetY
; Parameters: It receives list of sites in chip.
;		It receives the number of chips in x direction
;		in primary(nX) and the number of chips in y direction.
;		It also receives the y position of the chip.
; Function: Returns the wafer number in y direction
procedure(GetY(listSites nX nY y)
   prog((found yList site x0 y0 yCount listY x1 y1)
	yList = nil
	site = car(listSites)
	x0 = xCoord(site)
	y0 = yCoord(site)
	yCount = 0
	yCount++
	listY = nil
	listY = cons(y0 listY)
	listSites = cdr(listSites)
	found = nil
	while(!found
		site = car(listSites)
		listSites = cdr(listSites)
		x1 = xCoord(site)
		y1 = yCoord(site)
		if(x1 == x0 then
			yCount++
			listY = cons(y1 listY)
		else
			yCount = 1 
			listY = nil
			listY = cons(y1 listY)
		)
		x0 = x1
		y0 = y1
		if(yCount==nY then
			listY = reverse(listY)	
			found = t	
		)
	)
	return(listY)
))

;*******************************************************************
; Name: GetOff
; Parameters: No parameters passed
; Function: Returns the distance between lower left corner x of reticle
;     		and location of first chip.
procedure(GetOff(listChips)
   prog((dOffsetX dOffsetY sites listSites x y)
        sites = nil
        listSites = nil
        foreach(chip listChips
                sites = caddr(chip)
                listSites = append(listSites sites)
        )
        listSites = wpXySort(listSites)
        x = xCoord(car(listSites))
	y = yCoord(car(listSites))
	dOffsetX = x - xCoord(car(reticleRep~>bBox))
	dOffsetY = y - yCoord(car(reticleRep~>bBox))
	return(list(dOffsetX dOffsetY)) 
))

;*******************************************************************
; Name: GetNxy
; Parameters: None
; Function: Returns number in x direction and y direction
procedure(GetNxy()
   prog((sites listChips listSites listY nX nY oldMaxX oldMaxY)
	oldMaxX = maxX
	oldMaxY = maxY
        sites = nil
        listSites = nil
        listY = nil
        listChips = chipList
        foreach(chip listChips
                sites = caddr(chip)
                listSites = append(listSites sites)
        )
	listSites = wpXySort(listSites)
        nX = maxX
        nY = maxY
	maxX = oldMaxX
	maxY = oldMaxY
	return(list(nX nY))
))

;*******************************************************************
; Name: GetNumXY
; Parameters: die number(iX iY) and x-y postion
; Function: Returns number in x direction and y direction
procedure(GetNumXY(chipName iX iY x y)
   prog((found nX nY sites listSites listS2 numX numY listChips x2 y2 numY2 x3 y3)

        found = nil
	listSites = nil

	if(couponChip then
		nX = GetNumX(chipName)
		nY = GetNumY(chipName)
	else
        	nX = car(GetNxy())
        	nY = cadr(GetNxy())
 	)
 
        numX = (iX-llCornerX)*nX 
        numY = (iY-llCornerY)*nY
; lahey
	if(isNavSite(iX iY) && !processNav(iX iY) then
		numX = numX - nX
	)

        numY2 = numY
        if(isNavSite(iX iY) then
                listChips = oatChipList
        else
                listChips = chipList
        )
        if(couponChip then
        foreach(chip listChips
                sites = caddr(chip)
                if(chipName==car(chip) then
                listSites = append(listSites sites)
                )
        )
        else
        foreach(chip listChips
                sites = caddr(chip)
                listSites = append(listSites sites)
        )
        )
        listSites = wpXySort(listSites)
	listS2 = listSites

        x2 = xCoord(car(listSites))
        y2 = yCoord(car(listSites))
        x3 = x2
        y3 = y2
	if(x==x2 && y==y2 then
		found = t
		if(couponChip then
			return(list(numX numY))
		)
	)
	listSites = cdr(listSites)

	if(listSites==nil then
                        return(nil)
        )

        while(!found
		x2 = xCoord(car(listSites))
		y2 = yCoord(car(listSites))
		if(y2>y3 then
			numY++
		)
		if(y2<y3 || x2 > x3 then
			numX++
			numY = numY2
		)
                if(x2==x then
			found=t
		)
		listSites = cdr(listSites)
		y3 = y2
		x3 = x2
        )
	found = nil
	numY = 0
	listSites = GetY(listS2 nX nY y)

	y2 = car(listSites)	
	while(!found && y2!=nil
		y2 = car(listSites)
		listSites = cdr(listSites)
		if(y2==y then
			found = t
		else
			numY++
		)
	)
	numY = numY + (iY-llCornerY)*nY
        return(list(numX numY))
))

procedure(isThere(chipName iX iY sites)
   prog(( sites2 listChips listSites x y x2 y2)
        sites2 = nil
        listSites = nil
        if(isNavSite(iX iY) then
                listChips = oatChipList
                listSites = nil
                foreach(chip listChips
			if(car(chip)==chipName then
                        sites2 = caddr(chip)
                        listSites = append(listSites sites2)
			)
                )
                if(processNav(iX iY) then
                        listSites = negOatList(listSites)
		else
			listSites = posOatList(listSites)
                )
        else
        listChips = chipList
        foreach(chip listChips
		if(car(chip)==chipName then
                sites2 = caddr(chip)
                listSites = append(listSites sites2)
		)
        )
	)

        listSites = wpXySort(listSites)
        x = xCoord(car(listSites))
	y = yCoord(car(listSites))

	sites = wpXySort(sites)
	x2 = xCoord(car(sites))
	y2 = yCoord(car(sites))
 
	if(x2==x && y==y2 then
		return(t)
	)
        return(nil)
))
procedure(GetInitial(chipName iX iY)
   prog((sites2 listChips listSites x y)
        sites2 = nil
        listSites = nil
        if(isNavSite(iX iY) then
                listChips = oatChipList
                listSites = nil
                foreach(chip listChips
			if(car(chip)==chipName then
                        	sites2 = caddr(chip)
                        	listSites = append(listSites sites2)
			)
                )
		if(Xm==2 then
                if(processNav(iX iY) then
                        listSites = negOatList(listSites)
                else
                        listSites = posOatList(listSites)
                )
		)
        else
        listChips = chipList
        foreach(chip listChips
		if(car(chip)==chipName then
                	sites2 = caddr(chip)
                	listSites = append(listSites sites2)
		)
        )
        )

        listSites = wpXySort(listSites)
        x = xCoord(car(listSites))
        y = yCoord(car(listSites))
        return(list(x y))
))

procedure(CheckNavSite(xNum yNum)
   prog(()
        xNum = xNum + llCornerX
        yNum = yNum + llCornerY
        return(isNavSite(xNum yNum))
)
)
procedure(GetOats(readPort1 writePort deltaX deltaY dieCount)
   prog((lineCount found fileFlag localList xNum yNum nMoves1 
	xNum2 yNum2 xItem yItem line1)
if(readPort1==nil then
        return(nil)
)
 
lineCount=0
while(lineCount<6
        fileFlag=gets(line1 readPort1)
        if(!fileFlag then
                return(nil)
        )
        lineCount++
)
 
lineCount = 0
found = nil
while(!found
        fileFlag=gets(line1 readPort1)
        if(fileFlag==nil then
                return(nil)
        )
        localList=linereadstring(line1)
        xNum = car(localList)*nX
        localList = cdr(localList)
        yNum = car(localList)*nY
        localList = cdr(localList)
        localList = cdr(localList)
        localList = cdr(localList)
 
        nMoves1 = car(localList)
        fprintf(writePort "%s" line1)
        dieCount++
        while(nMoves1>0
                fileFlag=gets(line1 readPort1)
                localList=linereadstring(line1)
                xItem = car(localList)
                localList = cdr(localList)
                yItem = car(localList)
                localList = cdr(localList)
                xNum2 = car(localList)
                localList = cdr(localList)
                yNum2 = car(localList)
                localList = cdr(localList)
                xItem = (xNum2-xNum)*deltaX/1000.0
		yItem = (yNum2-yNum)*deltaY/1000.0
                fprintf(writePort " %f %f %d %d\n" xItem yItem xNum2 yNum2)
                nMoves1--
                xNum = xNum2
                yNum = yNum2
                xNum = xNum2
                yNum = yNum2
        )
        lineCount++
 
        if(lineCount==oatCount then
                found = t
        )

)
	return(dieCount)
))
procedure(GetCop(readPort2)
   prog((lineCount fileFlag found copList localList xNum yNum xDie yDie
	nMoves2 line2)
lineCount=0
while(lineCount<7
        fileFlag=gets(line2 readPort2)
        if(!fileFlag then
                return(nil)
        )
        lineCount++
)
found = nil
copList = nil
while(!found
        fileFlag=gets(line2 readPort2)
        if(fileFlag==nil then
                return(nil)
        )
        localList=linereadstring(line2)
        xDie = car(localList)
        localList = cdr(localList)
        yDie = car(localList)
        localList = cdr(localList)
        nMoves2 = caddr(localList)
	if(!isNavSite(xDie+llCornerX yDie+llCornerY) then
        if(isFullReticle(xDie+llCornerX yDie+llCornerY) then
                found = t
        )
	)
        if(!found then
        while(nMoves2>0
                fileFlag=gets(line2 readPort2)
                nMoves2--
        )
	)
	if(found then
	xNum = car(localList)
	yNum = cadr(localList)
	copList = cons(list(xNum yNum) copList)
        while(nMoves2>0
                fileFlag=gets(line2 readPort2)
                localList=linereadstring(line2)
                localList = cdr(localList)
                localList = cdr(localList)
                xNum = car(localList)
                localList = cdr(localList)
                yNum = car(localList)
                copList = cons(list(xNum yNum) copList)
                nMoves2--
        )
        )
)
	copList = reverse(copList)
	return(list(xDie yDie copList))
)) 
procedure(GetCop2(copList nX nY xDie yDie )
   prog((found copList2 copList3 copList4 startX startY
	stopX stopY xItem yItem)  
found = nil
copList2 =nil
        startX = xDie * nX
        startY = yDie * nY
        stopX = startX + nX - 1
        stopY = startY + nY - 1
        xItem = startX
        yItem = startY + 1

        for(i 1 nX
                while(yItem<=stopY
                        copList2 = cons(list(xItem yItem) copList2)
                        yItem++
                )
                yItem = startY
                xItem++
        )
        copList3 = nil
        foreach(item copList2
                if(!member(item copList) then
                        copList3 = cons(item copList3)
                )
        )
 
        copList4 = nil
        foreach(item copList3
                xItem = car(item)
                yItem = cadr(item)
                xItem = xItem - startX
                yItem = yItem - startY
                copList4 = cons(list(xItem yItem) copList4)
        )
        copList4 = reverse(copList4)

	return(copList4)
))
procedure(WantCoupon(xDie yDie copX copY deltaX deltaY)
   prog((xc yc)
	xDie = xDie + llCornerX
	yDie = yDie + llCornerY
      xc = float( xDie) * retX + retOffsetXm - retOffsetX
      yc = float( yDie) * retY + retOffsetYm - retOffsetY
        xc = xc - .5 * retXm
        yc = yc - .5 * retYm
	xc = xc + deltaX * copX
	yc = yc + deltaY * copY
	if(chipOnWafer2(xc yc deltaX deltaY) then
		return(t)
	else
		return(nil)
	)
))

procedure(NewEdgeFile(writeFile)
   prog((readFile1 readFile2 readPort1 readPort2 writePort lineCount fileFlag
        line1 line2 xNum xDie yDie localList dieCount writeFile2 writePort2
        found nMoves2 oatCount copList item numberList
        startX startY sites xPos yPos xItem2 yItem2 nX nY
	useCList copX copY deltaX deltaY xItem xNum2 yItem yNum yNum2)

	dieCount = 0
        readFile1 = edg2File
        readFile2 = kFile
	writeFile2 = substring(retDwg 1 nindex(retDwg "_"))
	writeFile2 = strcat(writeFile2 "eco.ink")

        sites = car(cddr(car(chipList)))
        sites = wpXySort(sites)
        nX = maxX
        nY = maxY
 
        deltaX = diffX2(sites)
        deltaY = diffY2(sites)
 
        oatCount = length(navaidSites)
 
        lineCount = 0
 
        readFile1 = strcat(strcat(releasePath "/") readFile1)
        readFile2 = strcat(strcat(releasePath "/") readFile2)
        writeFile = strcat(strcat(releasePath "/") writeFile)
	writeFile2 = strcat(strcat(releasePath "/") writeFile2)
        writePort = outfile(writeFile "w")
 
 
readPort1 = infile(readFile1)
if(readPort1==nil then
        return(nil)
)
dieCount = GetOats(readPort1 writePort deltaX deltaY dieCount) 

readPort2 = infile(readFile2)
if(readPort2==nil then
        return(nil)
)
copList = GetCop(readPort2)
global1 = copList
xDie = car(copList)
yDie = cadr(copList)
copList = caddr(copList)

copList = GetCop2(copList nX nY xDie yDie )
global2 = copList 

close(readPort2)
readPort2 = infile(readFile2)
if(readPort2==nil then
	fprintf(writePort "Error reading readPort2\n")
	close(writePort)
        return(nil)
)
lineCount=0
while(lineCount<7
        fileFlag=gets(line2 readPort2)
        if(!fileFlag then
		fprintf(writePort "Error reading readPort2 line\n")
		close(writePort)
                return(nil)
        )
        lineCount++
)
found = nil
while(!found
        fileFlag=gets(line2 readPort2)
        if(!fileFlag then
                fprintf(writePort "Error reading readPort2 l3\n")
                close(writePort)
                return(nil)
        )
        if(index(line2 "*") then
                found = t
        else
        localList=linereadstring(line2)
        xDie = car(localList)
        localList = cdr(localList)
        yDie = car(localList)
        localList = cdr(localList)
        nMoves2 = caddr(localList)
        while(nMoves2>0
                fileFlag=gets(line2 readPort2)
                nMoves2--
        )
	useCList=nil
        if(!isNavSite(xDie+llCornerX yDie+llCornerY) then
		if(isFullReticle(xDie+llCornerX yDie+llCornerY) then
	useCList = nil
	foreach(coup copList
		copX = xCoord(coup)
		copY = yCoord(coup)
		if(WantCoupon(xDie yDie copX copY deltaX deltaY) then	
			useCList = cons(coup useCList)
		)	
	)
	useCList = reverse(useCList)
	if(useCList!=nil then
        fprintf(writePort "%d %d 0 0 %d\n" xDie yDie length(useCList))
	dieCount++
        startX = xDie * nX
        startY = yDie * nY
        xPos = startX * deltaX
        yPos = startY * deltaY
        item = car(useCList)
        xItem = car(item) + startX
        yItem = cadr(item) + startY
        xPos = (xItem - startX) * deltaX
        yPos = (yItem - startY) * deltaY
        fprintf(writePort " %f %f %d %d\n" xPos/1000.0 yPos/1000.0 xItem yItem)
        foreach(item2 cdr(useCList)
                xItem2 = car(item2) + startX
                yItem2 = cadr(item2) + startY
                xPos = (xItem2 - xItem) * deltaX
                yPos = (yItem2 - yItem) * deltaY
                fprintf(writePort " %f %f %d %d\n" xPos/1000.0 yPos/1000.0 xItem2 yItem2)
                xItem = xItem2
                yItem = yItem2
        )
	)
	)
        )
        )
)
        close(readPort2)

found = nil
while(!found
        fileFlag=gets(line1 readPort1)
        if(fileFlag==nil then
                fprintf(writePort "Error reading readPort1\n")
                close(writePort)
                return(nil)
        )
        if(index(line1 "*") then
                found = t
                fprintf(writePort "%s" line1)
        )
        if(!found then
        localList=linereadstring(line1)
        xDie = car(localList)
        localList = cdr(localList)
        yDie = car(localList)
        localList = cdr(localList)
        xNum = car(localList)
        localList = cdr(localList)
        yNum = car(localList)
        localList = cdr(localList)
        nMoves2 = car(localList)
        startX = xDie * nX
        startY = yDie * nY
	dieCount++
	numberList = nil
	while(nMoves2>0
		fileFlag=gets(line1 readPort1)
		localList=linereadstring(line1)
		xNum2 = car(cddr(localList))
		yNum2 = cadr(cddr(localList))
		numberList = cons(list(xNum2 yNum2) numberList)
		nMoves2--
	)
        useCList = nil
        foreach(coup copList
                copX = xCoord(coup)
                copY = yCoord(coup)
                if(WantCoupon(xDie yDie copX copY deltaX deltaY) then
                        useCList = cons(coup useCList)
                )
        )
	foreach(item2 useCList

numberList = cons(list(xCoord(item2)+startX yCoord(item2)+startY) numberList)
	)
	numberList = wpXySort(numberList)

fprintf(writePort "%d %d %d %d %d\n" xDie yDie xNum yNum length(numberList))
	foreach(item2 numberList
		xNum2 = car(item2)
		yNum2 = cadr(item2)
		xDist = (xNum2-startX)*deltaX
		yDist = (yNum2-startY)*deltaY
		xDist = xDist/1000.0
		yDist = yDist/1000.0
		fprintf(writePort "%f %f %d %d\n" xDist yDist xNum2 yNum2)
		startX = xNum2
		startY = yNum2
)
))
        close(readPort1)

        close(writePort)

readPort1 = infile(writeFile)
readPort2 = infile(readFile2)
writePort2 = outfile(writeFile2 "w")
if(readPort1==nil then
                fprintf(writePort2 "Error reading readPort1 l5\n")
                close(writePort2)
	return(nil)
)
if(readPort2==nil then
                fprintf(writePort2 "Error reading readPort2 l5\n")
                close(writePort2)
        return(nil)
)
lineCount=0
while(lineCount<5
        fileFlag=gets(line2 readPort2)
        if(!fileFlag then
                fprintf(writePort2 "Error reading l5\n")
                close(writePort2)
                return(nil)
        )
	fprintf(writePort2 "%s" line2)
        lineCount++
)
	fprintf(writePort2 "%d\n" dieCount)
	fprintf(writePort2 "*  Die Loc. / Aeble Numbers\n")

while(fileFlag=gets(line1 readPort1)
	fprintf(writePort2 "%s" line1)
)
found = nil
while(fileFlag=gets(line2 readPort2)
        if(found==t then
                fprintf(writePort2 "%s" line2)
        )

	if(index(line2 "Start") then
		found = t
	)
)
	close(readPort1)
	close(readPort2)
	close(writePort2) 

))

procedure(minEdgY(aList)
prog((miY)
	miY = yCoord(car(aList))
	aList = cdr(aList)
	foreach(item aList
		if(yCoord(item)<miY then
			miY = yCoord(item)
		)
	)
	return(miY)
))
procedure(maxEdgY(aList)
prog((maY)
        maY = yCoord(car(aList))
        aList = cdr(aList)
        foreach(item aList
                if(yCoord(item)>maY then
                        maY = yCoord(item)
                )
        )
        return(maY)
))
procedure(minEdgX(aList)
prog((miX)
        miX = xCoord(car(aList))
        aList = cdr(aList)
        foreach(item aList
                if(xCoord(item)<miX then
                        miX = xCoord(item)
                )
        )
        return(miX)
))
procedure(maxEdgX(aList)
prog((maX)
        maX = xCoord(car(aList))
        aList = cdr(aList)
        foreach(item aList
                if(xCoord(item)>maX then
                        maX = xCoord(item)
                )
        )
        return(maX)
))
procedure(SortEdges(aList)
prog((miX miY maX maY halfX halfY bList cList numY)
	
	if(aList==nil then
		return(nil)
	)
	miX = minEdgX(aList)
	miY = minEdgY(aList)
	maX = maxEdgX(aList)
	maY = maxEdgY(aList)
	numX = miX
	numY = miY
	halfX = fix((maX - miX)/2)
	halfY = fix((maY - miY)/2)
	bList = nil
	foreach(item aList
		if(yCoord(item)==miY then
			bList = cons(item bList)
		)
	)
	bList = wpXySort(bList)


	numY++
	while(numY<=maY
		cList = nil
	foreach(item aList
                if(yCoord(item)==numY then
			if(xCoord(item)>halfX then	
                        cList = cons(item cList)
                	)
		)
        )
	cList = wpXySort(cList)
	if(numY>halfY then
		cList = reverse(cList)
	)
	bList = append(bList cList)
	numY = numY+1
	)

	while(numY>miY
		cList = nil
	foreach(item aList
                if(yCoord(item)==numY then
                        if(xCoord(item)<=halfX then      
                        cList = cons(item cList)
                        )
                )
        )
        cList = wpXySort(cList)
        if(numY>halfY then
                cList = reverse(cList)
        )

        bList = append(bList cList)
	numY--
	)
	return(bList)
))



procedure(MySort(useList copNum)
  prog((found xItem yItem newList tempList)
 
        found = nil
        xItem = nil
        yItem = nil
        newList = nil
        tempList = nil
 
        foreach(coupon useList
                tempList = cons(car(coupon) tempList)
	)

	tempList = wpXySort(tempList)


	foreach(item tempList
	foreach(coupon useList
		if(xCoord(item)==xCoord(car(coupon)) && yCoord(item)==yCoord(car(coupon)) then
		if(caddr(coupon)==copNum && found == nil then
			found = coupon
		else
			newList = cons(coupon newList)
		)
		)
	))
	newList = reverse(newList) 
	if(found!=nil then
        newList = cons(found newList)
	)
        return(newList)
))
procedure(negOatList(useList)
  prog((negList)
        negList = nil
	if(useList==nil then
                return(nil)
        )

        foreach(item useList
                if(xCoord(item)<-10.0 then
                        negList = cons(item negList)
                )
        )
        return(negList)
))
procedure(posOatList(useList)
  prog(( posList)
	if(useList==nil then
		return(nil)
	)
        posList = nil
        foreach(item useList
                if(xCoord(item)>-10.0 then
                        posList = cons(item posList)
                )
        )
        return(posList)
))
procedure(negOatList2(useList)
  prog((negList item2)
        negList = nil
        if(useList==nil then
                return(nil)
        )
 
        foreach(item useList
		item2 = cadr(item)
                if(xCoord(item2)<-10.0 then
                        negList = cons(item negList)
                )
        )
        return(negList)
))
procedure(posOatList2(useList)
  prog(( posList item2)
        if(useList==nil then
                return(nil)
        )
        posList = nil
        foreach(item useList
		item2 = cadr(item)
                if(xCoord(item2)>-10.0 then
                        posList = cons(item posList)
                )
        )
        return(posList)
))

procedure(negCopList(useList)
  prog((negList)
	negList = nil
	foreach(item useList
		if(xCoord(car(item))<-10.0 then
			negList = cons(item negList)
		)
	)
	return(negList)
))
procedure(posCopList(useList)
  prog(( posList)
        posList = nil
        foreach(item useList
                if(xCoord(car(item))>-10.0 then
                        posList = cons(item posList)
                )       
        )
        return(posList)
))

procedure(loopFFS(useList writePort xNum yNum chipNum)
  prog((deltaX deltaY itemNum nMoves
	newX newY startX startY usedList foundList xNum2 copNum)

	if(useList==nil then
		return(nil)
	)
        nMoves = length(useList) - 1

	xNum = fix(xNum)
	yNum = fix(yNum)

	if(chipNum==81 then
		checkErr = useList
	)

println( useList)
        foreach(coupon useList
                itemNum=caddr(coupon)
                if(itemNum==99 || itemNum==81 then
                        copNum = itemNum
                )
        )
println( caddr( car( useList)))
println( copNum)

	xNum2 = nil
	if(Xm==1 then
	foundList = nil
	foreach(coupon useList
		itemNum=caddr(coupon)
		if(itemNum==99 || itemNum==81 then
			foundList = cons(itemNum foundList)
		)
	)	
	xNum2 = fix(xNum * length(foundList))
	else
	xNum2 = xNum
	)
	if(xNum2==nil then
		return(nil)
	)
;fprintf(writePort "%d %d %d %d %d %d\n" xNum yNum xNum2 yNum nMoves copNum)
fprintf(writePort "%L %L %L %L %L %L\n" xNum yNum xNum2 yNum nMoves copNum)
        useList = MySort(useList copNum)
        startItem = car(useList)
        useList = cdr(useList)
	usedList = nil
	usedList = cons(copNum usedList)
        startX = xCoord(car(startItem))+xCoord(cadr(startItem))
        startY = yCoord(car(startItem))+yCoord(cadr(startItem))

        foreach(coupon useList
	itemNum=caddr(coupon)
	newX = xCoord(car(coupon))+xCoord(cadr(coupon))
	newY = yCoord(car(coupon))+yCoord(cadr(coupon))
	deltaX = (newX-startX)*1e-3
	deltaY = (newY-startY)*1e-3
	if(member(itemNum usedList) then
		xNum2++
	fprintf(writePort "%f %f %d %d %d\n" deltaX deltaY xNum2 yNum itemNum)
		xNum2--
	else
	fprintf(writePort "%f %f %d %d %d\n" deltaX deltaY xNum2 yNum itemNum)
	)

	startX = newX
	startY = newY
	usedList = cons(itemNum usedList)
        )
))
procedure(writeFFS(writePort xNum yNum chipNum)
  prog((useList negList posList useList2 chipNum2)
	; Make sure that chipNum is a string
        if(stringp(chipNum) then
                chipNum = readstring(chipNum)
        )

        if(CheckNavSite(xNum yNum) then
		useList = couponList2
	else
		wpCouponList()
                useList = couponList
	)
	useList2 = nil
	foreach(coupon useList
		chipNum2 = caddr(coupon)	
		if(chipNum2/10==chipNum/10 then
			useList2 = cons(coupon useList2)
		)
	)
	if(useList2==nil then
		return(nil)
	)
        if(Xm==1 then
		loopFFS(useList2 writePort xNum yNum chipNum)
	else
		if(CheckNavSite(xNum yNum) then
		if(CheckNavSite(xNum+1 yNum) then
			negList = negCopList(useList2)
			posList = posCopList(useList2)
			loopFFS(negList writePort xNum yNum chipNum)
			xNum++
			loopFFS(posList writePort xNum yNum chipNum)
		)
		else
                        loopFFS(useList2 writePort xNum yNum chipNum)
                )
	)
)) 

procedure(CreateFFS(readFile chipNum)
   prog((readPort writeFile writePort lineCount
        fileFlag xNum yNum nMoves line dieCount found localList)


	dieCount = 0
        lineCount = 0
; open file for reading
	found = nil
	 
        writeFile = strcat(substring(readFile 1 nindex(readFile "_")+2) ".all")
	readFile = strcat("/" readFile)
	readFile = strcat(releasePath readFile)
	readPort=infile(readFile)
	if(readPort==nil then
        	return(nil)
	)
	writeFile=strcat("/" writeFile ) 
	writeFile=strcat(releasePath writeFile)
	writePort = outfile(writeFile "w")
	if(writePort==nil then
        	return(nil)
	)
 
	while(lineCount<7
		fileFlag=gets(line readPort)
        	if(!fileFlag then
                	return(nil)
        	else
                	fprintf(writePort "%s" line)
        	)
        	lineCount++
	)
 
	found = nil 

	while(fileFlag=gets(line readPort) && !found

	if(index(line "*") then
		fprintf(writePort "%s" line)
		found = t
	else
        	localList=linereadstring(line)
        	xNum = car(localList)
        	localList = cdr(localList)
        	yNum = car(localList)
        	localList = cdr(localList)
        	nMoves = caddr(localList)
		if(xNum!="*" && nMoves!=nil then 
			dieCount++
			if(stringp(chipNum) then
				chipNum = readstring(chipNum)
        		)
			writeFFS(writePort xNum yNum chipNum)
		)
	)
	)
	fprintf(writePort "%s" line)
	close(readPort)
	close(writePort)

))

procedure(wpnums()
prog((designName sepPos  oatName dummyStr chipNum chipName
	checkSort writeNum layerName formLabel Form msg nameList
	newChipList numPadDwg passNames nPasses
	Fld1 Fld2 Fld4 Fld5 Fld7 Fld8)

printf("INFO: Beginning of WPNUMS Program Processing.\n")
 
; initialize program variables

wpnInit()
if(!wpGetReticleWindow() then
  println("ERROR: Please run with the primary reticle cell view opened")
  return(nil)
  )
 
        designName=reticleRep~>cellName
        sepPos=strlen(designName) - 1
        oatName=substring(designName 1 sepPos)
        oatName=strcat(oatName "o")

        oatRep=dbOpenCellViewByType(reticleRep~>libName oatName "layout" 
				    "maskLayout" "a")
        hiSetCurrentWindow(windowID)
 
; we have a correct window  -  calculate program values
 
libraryName = reticleRep~>libName
sprintf(wafDwg "%s_aeblemap" retDwg) ;wafermap drawing name
sprintf(numDwg "%s_wpnums" retDwg) ;aeble numbers drawing name
;sprintf(padDwg "%s/keys/xynum" retDwg) ;XY number pad cell name (cellName)
sprintf(padDwg "%s_keys_xy_num" retDwg) ;XY number pad cell name (cellName)
sprintf(releasePath "%s/release" 
	ddGetObjReadPath( ddGetObj( reticleRep~>libName)))
 
; test for release directory
 
if(!isDir(releasePath) then
  if(hiDisplayAppDBox(?name 'zz
                      ?dboxBanner "USER Query5."
                      ?dboxText "Release directory not found. Create it?") then
    printf("Creating release directory:  %s\n" releasePath)
    createDir(releasePath)
    )
  )
; query the user for necessary program values.
 
if(getFormValues3() then
  wpInitWaferParameters()


        Fld1 = hiCreateRadioField(
             ?name              'buttonPath
             ?choices           list("true" "false")
             ?prompt            "Production Reticle" 
           )
	Fld2 = hiCreateRadioField(
             ?name              'buttonPath2
             ?choices           list("false" "true")
             ?prompt            "New Oat Locations"
           )
        Fld4 = hiCreateRadioField(
             ?name              'buttonPath4
             ?choices           list("RF" "DC" "BOTH")
             ?prompt            "Process Type:"
           )
        Fld5 = hiCreateRadioField(
             ?name              'buttonPath5
             ?choices           list("false" "true")
             ?prompt            "Write Numbers"
           )
        Fld7 = hiCreateRadioField(
             ?name              'buttonPath7
             ?choices           list("mmic" "d_mmic" "ed_mmic" "hbt")
             ?prompt            "Layers Type:"
           )
	Fld8 = hiCreateIntField(
             ?name              'buttonPath8
             ?value		2	
	     ?defValue		2	
	     ?range		'(1 5)
             ?prompt            "Number of xy pads used"
           )
        Form = hiCreateForm(
             'retPLot
             "Wpnums+Dies"
             list('ok 'cancel)
             list( Fld1 Fld2 Fld4 Fld5 Fld7 Fld8)
        )
        status = hiDisplayForm(Form)
	if(status == nil then
		return(nil)
	)
        retType=Fld1->value
	newOat=Fld2->value 
	numPadDwg = Fld8->value
	processType = Fld4->value
	writeNum = Fld5->value
	layersType = Fld7->value

	if(retType=="true" then
		edgeDie = "true"
		optHam = "true"
	else
		edgeDie = "true"
		optHam = "false"
	)

        layerName = "sd"
        if(layersType=="mmic" then
                layersDs = "/usr/local/raytheon/tech/plotter.lyr"
        )
 
        if(layersType=="d_mmic" then
                layersDs = "/usr/local/raytheon/tech/plotterdm.lyr"
        )
 
        if(layersType=="ed_mmic" then
                layersDs = "/usr/local/raytheon/tech/plottered.lyr"
        )
 
        if(layersType=="hbt" then
                layersDs = "/usr/local/raytheon/tech/plotterhbt.lyr"
                layerName = "c"
		xyDieLayer = "v2"
        )

; re-center the reticle just in case

        if(layersType!="hbt" then 
  		geSelectAll(windowID)
  		centerSel()
  		geDeselectAll(windowID)
		removeChangeLayer()
	)
; open the number pad cell,
; their data is used for setting defaults in wafer map generation
; and in chip search for XY number generation.
; calculate defaults for the wafer map, prompt the user for changes:
 
  if(wpGetPadRep(numPadDwg) then
    if(wpSetWaferMap() then

	if(optHam=="true" then
	OptHam(layersType) 
	)
	calcWaferShift()
; search the reticle for dice-able chips,
; recognized by having the number pad in them,
; build the chip list for the reticle:

	wholeChipList = nil
	wholeOatList = nil
	foreach(padDwg padDwgList
		chipList = nil
		oatChipList = nil
		chipList=wpFindChips( chipList reticleRep)
		oatChipList=wpFindChips( oatChipList oatRep)
if(!isCouponChip(car(car(chipList))) && !isNCouponChip(car(car(chipList))) then
		sprintf( msg "Specify for pad %s" padDwg)
		newChipList = getNewChipList()
		nPasses = length(newChipList)

        formLabel = hiCreateLabel(?name 'frLabel ?labelText msg)
 
        Fld1 = hiCreateIntField(
             ?name              'buttonPath1
             ?value             nPasses
             ?defValue         	nPasses 
             ?prompt            "No. of probe passes"
           )
 
        Form = hiCreateForm(
             'entNPasses
             msg
             list('ok 'cancel)
             list(formLabel Fld1)
        )
 
        status = hiDisplayForm(Form)
        if(status == nil then
                return(nil)
        )
 
        nPasses = Fld1->value


		for(pass 1 nPasses
        	newChipList=getNewChipList()
        	nameList = getNames(newChipList)
        	passNames = GetPassNames(pass nameList)
		if(passNames==nil then
			return(nil)
		)
        	GetChips(passNames)
        	GetOatChips(passNames)
        	newChipList = getNewChipList()
		)	

		else
		newChipList = getNewChipList()
		)
		wholeChipList = cons(chipList wholeChipList)
		wholeOatList = cons(oatChipList wholeOatList)
	)

	padDwgList = reverse(padDwgList)
	foreach(padDwg padDwgList 
        chipList=car(wholeChipList)
	wholeChipList = cdr(wholeChipList)
	oatChipList = car(wholeOatList)
	wholeOatList = cdr(wholeOatList)
        wpChipNames()
        OatNames()
	;GetOff()
 
	checkSort = CheckXySort()

	if(checkSort==nil then
		return(nil)
	)
; setup log file

      sprintf(logFileName "%s/%s" releasePath logFile)
      logPort = outfile(logFileName "w")
      if(logPort then
 
; create the wafer map for the Aeble - with user ok
;PSS I have updated this procedure to support Rich Novo's request for 
;specific deatils
;/8/31/95
	beginLogFile()
        wpCreateWaferMap()
 
; create the FFS probe patterns - with user ok
	 
        wpCreateProbPattens(logPort)
	wpChipNames() 
	OatNames()
; create the XY numbers layout for the Aeble - with user ok
	if(writeNum=="true" then
        	wpCreateXYNumLayout()
	)
        close(logPort)
	if(couponChip==nil then
	wpPlaceDieWP()
	)
      else
        hiGetAttention()
        printf("Program Abort - Unable to open log file: %s\n" logFileName)
        ) ; endif - log file
	)
    else
      hiGetAttention()
      printf("Program Abort - From Wafer map.\n")
      ) ;endif-wpSetWaferMap
  else
    hiGetAttention()
    printf("Program Abort - Unable to open pad layout\n")
    ) ;endif-pad opened
else
  hiGetAttention()
  printf("User Aborted\n")
  ) ;endif-values from form input
printf("End of WPN Program Processing.\n")
dbClose(oatRep)
foreach(chip chipList
	chipName = car(chip)
	chipNum = substring(chipName strlen(chipName)-1 1)
	if(chipNum=="9" then
	chipNum = substring(chipName strlen(chipName)-1 2) 
	sprintf( dummyStr "rm %s/%s_%s.ffs"  releasePath newLibName chipNum)
	system(dummyStr)
	)
	chipNum = substring(chipName strlen(chipName)-1 2)
	sprintf( dummyStr "rm %s/%s_%s.edg2" releasePath newLibName chipNum)
	system(dummyStr)
	sprintf( dummyStr "rm %s/%s_%s.sample" releasePath newLibName chipNum)
        system(dummyStr)
)
foreach(chip oatChipList
        chipName = car(chip)
        chipNum = substring(chipName strlen(chipName)-1 2)
        sprintf( dummyStr "rm %s/%s_%s.edg2" releasePath newLibName chipNum)
        system(dummyStr)
	sprintf( dummyStr "rm %s/%s_%s.sample" releasePath newLibName chipNum)
        system(dummyStr)
)
sprintf( dummyStr "mv %s/%s_99.all %s/%s_99.ffs" releasePath newLibName releasePath newLibName)
system(dummyStr)
sprintf( dummyStr "mv %s/%s_81.all %s/%s_81.ffs" releasePath newLibName releasePath newLibName)
system(dummyStr)
        if(layersType!="hbt" then
		Plot2(layerName)
	)
;println("goodBYE")
))
procedure(wpChipNames()
prog((item list2)
        chipNames2 = nil
        list2 = chipList
        while(list2 != nil
                item = car(list2);
                chipNames2 = cons(car(item) chipNames2)
                list2 = cdr(list2)
        )
))

procedure(OatNames()
prog((item list2)
	oatNames = nil
	list2 = oatChipList
	while(list2 != nil
		item = car(list2);
		oatNames = cons(car(item) oatNames)
		list2 = cdr(list2)
	)			
))
;*****************************************************************************
procedure(wpCreateXYNumLayout()
	prog(( delRep viewRep)
  printf("Creating Aeble XY numbering drawing.\n")
; The following for loop was added to eliminate the problem of duplicate
; numbers.  The program was placing the wpnums-1 thru wpnums-3 on top of
; the wpnums cell.  This was creating duplicate numbers on the chip
; that was run first.  This code opens the instances in write
; mode and then saves and closes it.  This essentially deletes all data
; within the cell. 6/21/95 PSS and H2R3
  for(i 1 3
  sprintf(delName "%s-%d" numDwg i)
  print(delName)
  delRep = dbOpenCellViewByType(libraryName delName "layout" "maskLayout" "w") 
  dbSave(delRep)
  dbClose(delRep)
  )
  sprintf(fullName "%s" numDwg)
  xYNumRep = dbOpenCellViewByType(libraryName fullName "layout" 
				  "maskLayout"  "r")
 
 println( list( libraryName fullName))

  if(xYNumRep != nil then
 
 
        if(wpnumsType=="append" then
                xYNumRep = dbOpenCellViewByType(libraryName fullName "layout" 
						"maskLayout"  "a")
        )
        if(wpnumsType=="write" then
                xYNumRep = dbOpenCellViewByType(libraryName fullName "layout"
						"maskLayout"  "w")
        )
   else
        xYNumRep = dbOpenCellViewByType(libraryName fullName "layout"
						"maskLayout"  "w")
   )

println( list( 'xYNumRep xYNumRep))

wpnumsType = "append"
; fill the numbers layout
 
    if(wpSetNumbers() then
printf("I'm here.\n")
      wpMakeNumCells("squareFlush")
      wpMakeNumDwg(xYNumRep)
      dbSave(xYNumRep)
 
; create another numbers layout with dies superimposed - for visual alignment
 
      sprintf(fullName "%s_wpnums+dies" reticleRep~>cellName)

      viewRep = dbOpenCellViewByType(libraryName fullName "layout" 
				     "maskLayout" "w")

      dbCreateInst(viewRep xYNumRep nil 0:0 "R0" 1)
      wpPlaceOutline(viewRep -retOffsetXm:-retOffsetY)
printf("I'm here2.\n")
      wpPlaceXyDie(viewRep)
      dbSave(viewRep)
      dbClose(viewRep)
      dbSave(xYNumRep)
      dbClose(xYNumRep)
  else
    hiGetAttention()
    printf("Program Abort - Unable to open num rep\n")
    return( nil)
    ) ; endif - open num rep
))
;*************************************************************************
procedure( wpMoveXYLayersFourinch()
prog( ( x1 y1 layerNumber inst numRep)
;pd("wpMoveXYLayersFourinch" "")

; Code for shifting the four inch xy numbers according to improvements on the ultratech.

; printf( "nAdieXm = %n\nnAdieYm = %n\n" nAdieXm nAdieYm )
;      distance from matrix center to        Dist. from aeble die  Incremental distance as      wafer center to
;      to ll corner                          center to ll          you step across aeble dies   matrix center
;      ___________________________________   __________________    ________________________   ____________
; x1 = (llCornerXm * retXm) - (.5 * retXm) + (aRetXm * retXm)/2. + (i - 1) * aRetXm * retXm + retOffsetXm 

layerNumber = 1
for(i 1 nAdieXm
  x1 = (llCornerXm - .5 + (i - .5) * aRetXm ) * retXm 
  for(j 1 nAdieYm
    y1 = (llCornerYm - .5 + (j - .5) * aRetYm ) * retYm 
    sprintf(fullName "%s-%d" numDwg layerNumber)
    numRep = dbOpenCellViewByType(libraryName fullName "layout"
 				   "maskLayout" "r") 
    inst = dbCreateInst(xYNumRep numRep nil x1:y1 "R0" 1)
    leFlattenInst(inst 1)
    layerNumber++
    )
  )
))
;***************************************************************************
procedure(wpMakeNumDwg(drawRep)
prog(( i n newChipList)
;pd("wpMakeNumDwg" "")

; Main routine for calling the xy numbers procedures
; create X/Y numbers for each chip one at a time:

i = 1
newChipList=nil
foreach(chip oatChipList
        if(!member(car(chip) chipNames2) then
                newChipList=cons(chip newChipList)
        )
)
newChipList=append(chipList newChipList)
n = length(newChipList)
foreach(chip newChipList
;	if(member(car(chip) probeNames2) then
  printf( "Creating numbers for chip: %s  # %d of %d\n" car(chip) i n)
  wpChipNumLoop(drawRep chip) 
  i++
;  )
)

;  wpMoveXYLayersFourinch()
; add bounding boxes to each layer for Aeble,

printf("Adding bounding boxes\n")
wpAddBBoxes1(drawRep retX*aRetX retY*aRetY nAdieXm nAdieYm)
))
;***************************************************************************
procedure(wpChipNumLoop(drawRep chip)
prog((oatFlag padX padY chipSites x y nX nY padData
      oPad o90 format chipName sites2 chipSites2 posSites negSites orient)
;pd("wpChipNumLoop" "")

; Code for finding the correct orientation of the xy boxes and creating
;   the correct numbers in them on each test block
;	compute relative posn of xypad from reticle origin,
;	include offset from pad origin to location of first char,
;	(all chars assumed to be lower-left justified),
;	create format string for numbers:
chipName = car(chip)
padData = cadr(chip)
x = xCoord(car(padData))
y = yCoord(car(padData))
oPad = cadr(padData)
padOrientation = oPad

if(oPad == "R180" || oPad == "MX" || oPad == "MY" then
  oPad = "R0"
  )
if(oPad == "R270" || oPad == "MXR90" || oPad == "MYR90" then
  oPad = "R90"
  )
; process chip orientation

; if there's more than 1 instance of the chip per reticle,
; sort them by x and y position,
; also determine the number of X and Y chip positions per reticle:
chipSites = caddr(chip)
nX = 1
nY = 1
if(length(chipSites) > 1 then
  chipSites = wpXySort(chipSites)
  nX = maxX
  nY = maxY
  )
; loop through all reticle positions on the wafer, and call wpNumRet for each
; after completing each XY die, convert the number cells to primitive polygons
; and move these to the appropriate stream layer number:

	sites2 = nil
	foreach(chip2 oatChipList
		if(car(chip2)==chipName then
			sites2 = caddr(chip2)
		)
	)
        chipSites2 = wpXySort(sites2)
	negSites = wpXySort(negOatList(chipSites2))
	posSites = wpXySort(posOatList(chipSites2))

case(caddr(padData)
  ("R0" 
  padX = x
  padY = y
  orient = oPad
  )
  ("R90" 
  padX = -y
  padY = x
  if(oPad == "R0" then 
    orient = "R90"
  else 
    orient = "R0" 
    )
  )
  ("R180" 
    padX = -x
    padY = -y
    orient = oPad
  )
  ("R270"	
  padX = y
  padY = -x
  if(oPad == "R0" then 
    orient = "R90"
  else 
    orient = "R0" 
  )
  )
)

if(orient == "R90" then 
  orient = "R270"
  ) ;ts-14
if(orient == "R0" then
  o90 = nil
  padX = padX + cXOffset
  padY = padY + cYOffset
else
  o90 = t
  padX = padX + cYOffset            ; changed signs for ts-14
  padY = padY - cXOffset            ;      ""
  )
sprintf(format "%s%d%s%d%s" "%0" nDigits "d-%0" nDigits "d")

	if(member(car(chip) chipNames2) then
		oatFlag = nil 
	else
		oatFlag = t
	)	
  for(i llCornerX urCornerX            ;XY die X-loop
  for(j llCornerY urCornerY            ;XY die Y-loop
    if(isPartialRet(i j) then
	if(Ym==2 then
		y = float(j) * retY + padY
	else
		y = float(j-.5) * retY + padY 
	)
	if(Xm==2 then
		x = float(i-.5) * retX + padX 
        else
		x = float(i-.5) * retX + padX 	
	)
	if(!isNavSite(i j) && !oatFlag then
		wpNumRet3(drawRep chipName chipSites i j x y nX nY format o90)
	)
        if(isNavSite(i j) && processNav(i j) then
		if(Xm==2 then
                wpNumRet3(drawRep chipName negSites i j x y nX nY format o90)
		wpNumRet3(drawRep chipName posSites i+1 j x y nX nY format o90)
		else
		wpNumRet3(drawRep chipName chipSites2 i j x y nX nY format o90)
		)
        )
    )
))

; put the numbers on the appropriate layer

))

procedure(wpNumRet4(numRep chipName chipSites iX iY xOfs yOfs nX nY format o90)
   prog(( found listChips listSites smallX smallY x y numX
	numY x2 y2 xDis yDis dOffsetX dOffsetY)


        if(isNavSite(iX iY) then
                listChips = oatChipList
        else
                listChips = chipList
        )
	listSites = nil
        foreach(chip listChips
                sites = caddr(chip)
                listSites = append(sites listSites)
        )
        listSites = wpXySort(listSites)
	smallX = xCoord(car(listSites))
	smallY = yCoord(car(listSites))
        foreach(chip listChips
		if(car(chip)==chipName then
			xDis = diffX2(cadddr(chip))
			yDis = diffY2(cadddr(chip))
		)
	)
        found = nil

	foreach(site chipSites
	x = xCoord(site)
	y = yCoord(site)
	numX = car(GetNumXY(chipName iX iY x y))
	numY = cadr(GetNumXY(chipName iX iY x y))

        sprintf(numString format numX numY)
        x = x + xOfs
        y = y + yOfs
	dOffsetX = car(GetOff(listChips))
	dOffsetY = cadr(GetOff(listChips))
	x = x + dOffsetX
	y = y + dOffsetY 
        x = x - smallX
        y = y - smallY
	x2 = float(iX)*retX
	y2 = float(iY)*retY
	x2 = x2 + xCoord(site)
	y2 = y2 + yCoord(site)
;	if(isNavSite(iX iY) && Xm==2 then
;		x2 = x2 + .5*retX
;	)	

	if(Xm==2 && !isNavSite(iX iY) then
	x = x - .5*retX
	)
	if(Xm==2 && isNavSite(iX iY) then
		wpPlaceXyNum(numRep numString x y o90 numPath )
	else
	if(chipOnWafer(x2 y2 xDis yDis) then
		wpPlaceXyNum(numRep numString x y o90 numPath )
	)
	)
	)
	return(t)
))
procedure(wpNumRet5(numRep chipName chipSites iX iY xOfs yOfs nX nY format o90)
   prog(( found chipNum fileName listNames chipNum2 probeFile
        fileFlag line i localList numX numY nMoves iX2 iY2 x y
        xoff yoff firstX firstY listChips origSites)

	origSites = chipSites
        if(isNavSite(iX iY) then
                listChips = oatChipList
        else
                listChips = chipList
        )
        foreach(chip listChips
                if(car(chip)==chipName then
			chipSites = caddr(chip)
		)
        )
        chipSites = wpXySort(chipSites)
	if(isNavSite(iX iY) && !processNav(iX iY) then
		chipSites = origSites
		chipSites = wpXySort(chipSites)
	)
	if(chipSites!=nil then
        firstX = xCoord(car(chipSites))
        firstY = yCoord(car(chipSites))
	if(!isNavSite(iX iY) then
		firstX = firstX + .5*retX
	)
        if(isNavSite(iX iY) then
		if(Xm==2 then
                	firstX = firstX + retX
		else
			firstX = firstX + .5*retX
		)
	) 
	firstY = firstY + .5*retY

        found = nil
;	THIS NO LONGER WORKS BECAUSE THERE MAY NOW BE MULTIPLE _'s...
;       chipNum = substring(chipName strlen(chipName)-1 2)
;	SO ASSUME THE LAST _ IS THE CORRECT ONE -MM
	chipNum = car( last( parseString( chipName "_")))

        iX = fix(iX + abs(llCornerX))
        iY = fix(iY + abs(llCornerY))
        fileName = nil
 
   listNames = probeNames
   foreach(name listNames
;	HERE WE ASSUME THE NEXT-TO-LAST _ IS THE CORRECT ONE -MM
        chipNum2 = cadr( reverse( parseString( name "_")))
        if(strcmp(chipNum chipNum2)==0 then
                sprintf(fileName "%s/%s" releasePath name)
        )
   )
 
        if(fileName==nil then
;		 THIS LINE COULD NEVER WORK, name IS NOT DEFINED HERE:
;                println(list(name "fileName not found"))
		 println( list( chipName "fileName not found"))
		 println( listNames)
        else
        probeFile=infile(fileName)
        if(probeFile==nil then
                println("probeE")
        else
        i=0
        while(i<7
                fileFlag=gets(line probeFile)
           i++
        )
        while(!found
                fileFlag=gets(line probeFile)
                if(!fileFlag then
                        println("Errrr")
                        return(nil)
                )
 
                if(index(line "Star") then
                        return(nil)
                )
                localList = linereadstring(line)
                iX2 = fix(car(localList))
                localList = cdr(localList)
                iY2 = fix(car(localList))
                localList = cdr(localList)
                numX = fix(car(localList))
                localList = cdr(localList)
                numY = fix(car(localList))
                localList = cdr(localList)
                nMoves = car(localList)
 
 
                if(nMoves!=nil then
                if(iX==iX2 && iY==iY2 then
                        found = t
                        nMoves = fix(nMoves)
                )
                )
        )
        if(found==nil then
                println("!found")
                return(nil)
        )
        if(nMoves==nil then
                println("nIntra")
                return(nil)
        )
        sprintf(numString format numX numY)
        x = firstX + xOfs
        y = firstY + yOfs
        couponChip = nil

 
        if(numX != 0 || numY != 0 then
		if(Xm==2 then
			x = x - .5*retX
		)
                wpPlaceXyNum(numRep numString x y o90 numPath )
        )
        while(fileFlag=gets(line probeFile) && nMoves>0
                if(index(line "Star") then
                        return(t)
                )
                localList = linereadstring(line)
                xoff = car(localList)
                xoff = xoff * 1000.0
                localList = cdr(localList)
                yoff = car(localList)
                localList = cdr(localList)
                yoff = yoff * 1000.0
                numX = car(localList)
                localList = cdr(localList)
                numY = car(localList)
                localList = cdr(localList)
                x = x + xoff
                y = y + yoff
                sprintf(numString format numX numY)
                wpPlaceXyNum(numRep numString x y o90 numPath)
                nMoves = nMoves - 1
        )
        close(probeFile)
	))
        return(t)
	)
))

procedure(wpNumRet3(numRep chipName chipSites iX iY xOfs yOfs nX nY format o90)
   prog((couponChip)
	couponChip = nil
        if(isCouponChip(chipName) || isNCouponChip(chipName) then
            couponChip = t
        )
;	if(couponChip || Xm==1 then
        if(couponChip then
	wpNumRet5(numRep chipName chipSites iX iY xOfs yOfs nX nY format o90)
	else
	wpNumRet4(numRep chipName chipSites iX iY xOfs yOfs nX nY format o90)
	)
))
;**************************************************************************
procedure(wpPlaceXyNum(numRep numString posX posY o90 leEdgePath)
prog((x y cellName first second third inst cNum )
;pd("wpPlaceXyNum" "")

; Places the xy numbers within the xy boxes.
; Returns a list of the instances
	first = float(llCornerX)*retX + retOffsetX
	third = float(urCornerX)*retX - retOffsetX

	second = first + (third-first)/3
	third = second + (third-first)/3

   x = posX
   y = posY
for(i 1 strlen(numString)
  cNum = substring(numString i 1)
        if(x<second then
         sprintf(cellName "%s_xy.m%s" reticleRep~>cellName cNum)
        )
        if(x<third && x>second then
        sprintf(cellName "%s_xy.n%s" reticleRep~>cellName cNum)
        )
        if(x>third then
        sprintf(cellName "%s_xy.p%s" reticleRep~>cellName cNum)
        )


  ;open file like am17-3_xy.1 so it can be instanced 
  cellRep = dbOpenCellViewByType(libraryName cellName "layout" 
				 "maskLayout" "r") 

  ;instance the above in the cell am17_3_wpnums-1( or 2 or 3)
  inst = dbCreateInst(numRep cellRep nil x:y padOrientation 1)
  dbClose(cellRep)
  leFlattenInst(inst 1)
  if(cNum != "-" then
    if( o90 then 
      y = y - cWidth     ; ts-14
    else         
      x = x + cWidth 
      )
  else
    if( o90 then 
      y = y - dashWidth  ; ts-14
    else         
      x = x + dashWidth 
      )
    )
  )
))

;******************************************************************************
procedure(wpPlaceXyDie(drawRep)
prog( ( x y designName halfName halfRep)
;pd("wpPlaceXyDie" "")

; Overlays the test blocks over the wpnums drawing for user verification.
if(Xm==2 then
        designName=reticleRep~>cellName
        halfName=strcat(designName "half")
	dbCopyCellView(reticleRep reticleRep~>libName halfName "layout")
        halfRep=dbOpenCellViewByType(reticleRep~>libName halfName "layout" 
				     "maskLayout" "a")
)
if(waferSize == "4inch" then
  for(i llCornerX urCornerX            ;XY die X-loop
  for(j llCornerY urCornerY	       ;XY die Y-loop
    if(isPartialRet(i j) then
      x = float(i) * retX 
      y = float(j) * retY 
	if( !isNavSite(i j) then
	if(Xm==2 then
	x = float(i-.5) * retX
	dbCreateInst(drawRep halfRep nil x:y "R0" 1)
	else
        dbCreateInst(drawRep reticleRep nil x:y "R0" 1)
	)
	else
		if(Xm==1 && Ym==1 then
		dbCreateInst(drawRep oatRep nil x:y "R0" 1)
		)
		if(Xm==2 && Ym==1 then
		if(processNav(i j) then
               	x = float(i) * retX
		dbCreateInst(drawRep oatRep nil x:y "R0" 1)
		)		
		)	
		if(Ym==2 && Xm==1 then
		if(!isNavSite(i j-1) then
                y = float(j+.5) * retY 
		dbCreateInst(drawRep oatRep nil x:y "R0" 1)
		)
		)
	)	
	)
	))
else
  for(i 1 aRetX
  for(j 1 aRetY
    x = (float(i) - .5 - aRetX / 2.) * retX
    y = (float(j) - .5 - aRetY / 2.) * retY
    dbCreateInst(drawRep reticleRep nil x-retOffsetX:y-retOffsetY "R0" 1)
    ))
  )
))
;*****************************************************************************
procedure(wpPlaceDieWP()
prog( ( fullName xYNumRep iX iY startllX)
;pd("wpPlaceXyDie" "")

  sprintf(fullName "%s" numDwg)
  xYNumRep = dbOpenCellViewByType(libraryName fullName "layout" 
				  "maskLayout" "a")

 
; draw a box representing each complete reticle,
; also determine the iX,iY for the first complete reticle:
;;HHR
startllX = llCornerX
if(!evenp(startllX) then
        startllX = startllX - 1
)
 
iY = llCornerY
while(iY<=urCornerY
        iX = startllX
  while(iX<=urCornerX
      wpRelRect(xYNumRep labelLayer (iX-.5*Xm)*retX (iY-.5)*retY retXm retYm)
        iX = iX + Xm
    ) ; for X
        iY = iY + Ym
  ) ; for Y
	dbSave(xYNumRep)
	dbClose(xYNumRep)
)) 
;*****************************************************************
procedure(wpSetNumbers()
prog( ( b rZero rDash x dx scale cHeightReal)

; Front end to the xy numbers procedures
; on-wafer numbers definition and generation
; theres a differrence between the real pgable char size and the 
; cHeight calculated here. Due to the stokes definition in numFont
; the true height 
; cHeightReal = cHeight + w/2. - ( 10*cHeight/float(numFont->height)-w/2)
;               the 10 is from the min y in the stokes def
;		w is the line width cHeight*cRatio
;		this reduces to
;		cHeightReal = cHeight*(1+cRatio-10/float(numFont->height))
;
; the real yOffset should be set to 
;		cYoffset = -cHeightReal/2 - (10*cHeight/float(numFont->height)-w/2)
;		this reduces to 
;		cYOffset = -cHeight*(1.+10./float(numFont->height))/2.

padRep = dbOpenCellViewByType(libraryName padDwg "layout" "maskLayout" "r")
b = padRep~>bBox
cHeightReal = abs(yCoord( upperRight( b)) - yCoord( lowerLeft( b))) - 22.
cHeight = cHeightReal / ( 1 + cRatio - 10. / float(numFont->height) )
rZero = float(cadr( assoc( "0" numFont->strokes))) / float(numFont->height)
rDash = float(cadr( assoc( "-" numFont->strokes))) / float(numFont->height)
x = (rZero * nDigits * 2. + rDash) * cHeight 
dx = abs(xCoord( upperRight( b)) - xCoord( lowerLeft( b))) - 22.
if( x > dx then
  cHeight = dx / (rZero * nDigits * 2. + rDash)
  x = dx
  )
cXOffset = - ( x / 2. + cHeight * cRatio * .71 )  ; .71 is a fudge factor
cYOffset = - cHeight * ( 1. + 10. / float(numFont->height) ) / 2.
cYOffset = float(fix(cYOffset*10.0)) / 10.
cXOffset = float(fix(cXOffset*10.0)) / 10.
cHeight = float(fix(cHeight*10.0)) / 10.


scale =  cHeight / numFont->height
cWidth = cadr( assoc( "0" numFont->strokes)) * scale
dashWidth = cadr( assoc( "-" numFont->strokes)) * scale
cWidth = float(fix(cWidth*10.0)) / 10.
dashWidth = float(fix(dashWidth*10.0)) / 10.
scale = float(fix(scale*100.0)) / 100. 

; write to the log file

fprintf(logPort "\n\nXY numbers format:\n")
fprintf(logPort "Character height (um)\t\t\t%10.2f\n" cHeight)
fprintf(logPort "Line width to height ratio\t\t\t%10.2f\n" cRatio)
fprintf(logPort "X Offset from pad origin to 1st char\t\t\t%10.2f\n" cXOffset)
fprintf(logPort "Y Offset from pad origin to 1st char\t\t\t%10.2f\n" cYOffset)
fprintf(logPort "Number of digits in each number\t\t\t%3d\n\n" 2)               
return(t)
))
procedure(wpSetWaferMap()
  prog((b a r oat1X oat1Y box
	oat2X oat2Y oat3X oat3Y nRetWafXmTemp nRetXwafm nRetYwafm)
;pd("wpSetWaferMap" "")
 
; Defines the placement of the die on the wafer
 
retOffsetXm = 0.
retOffsetYm = 0.
ultraYOffset = 0.
ultraXOffset = 0.
   
; calculate the minimum x and maximum y resulting from wafer flats:
 
a = wafSize * wafSize / 4.
b = lenSeco * lenSeco / 4.
edgeX = sqrt(a - b)
b = lenPrim * lenPrim / 4. - titleBar
edgeY = sqrt(a - b)
if(waferSize == "4inch" then
  edgeY = -1. * edgeY
else
  edgeX = -1. * edgeX
  )
; calculate reticle size, default origin (corner) & numbers of die:
 
box = reticleRep~>bBox
retX = xCoord(upperRight(box)) - xCoord(lowerLeft(box)) - retOlap
retY = yCoord(upperRight(box)) - yCoord(lowerLeft(box)) - retOlap
retXm = retX * Xm
retYm = retY * Ym

; calculate matrix reticle offsets and ultra offsets for Y direction.
; the bottom of the first row of reticles start at the edgeY dimension.
; Need to calculate the amount of reticle overlapping edgeY( this is the
; offset). Distance is edgeY + retXm/2. Dividing this distance by retXm
; gives r, 1 minus the remainder of r gives the fractional amount of a
; matrix reticle that is overhanging edgeY ( retOffsetYm).
 
if(waferSize == "4inch" then
  r = abs( edgeY) / retYm + .5
  retOffsetYm = float(fix(retYm * ( 1. - r + fix( r) )))
  ultraYOffset = retOffsetYm + retYm / 2.
  )
; Set up number of matrices in to Y direction
 
nAdieYm = 1
nRetYwafm = fix( ((wafSize / 2) + abs( edgeY)) / retYm + 1)
;   printf( "1st Quess at nRetYwafm %n\n" nRetYwafm)
if( mod( nRetYwafm nAdieYm) == 0 then
  aRetYm = fix(nRetYwafm / nAdieYm)
else
  aRetYm = fix(nRetYwafm / nAdieYm + 1)
  )
nRetYwafm = aRetYm * nAdieYm
if(waferSize == "4inch" then
  llCornerYm = -1 * fix( (abs( edgeY) + retOffsetYm) / retYm - .49)  
else
  llCornerYm = -1 * fix( ( wafSize / 2. + retOffsetYm) / retYm  + .51 )
  nRetYwafm = nRetYwafm + 1             
  aRetYm = aRetYm + 1        
  )
urCornerYm = nRetYwafm + llCornerYm - 1
 
; Set up number of matrices in to X direction
; Min area to cover is 100000um max is 125000um
; Joe Zangri says MAX should be 106250um ( 4 1/4")
if(waferSize == "4inch" then
  if(retXm <= 9800.0 then
	println("ERROR Reticle Size Too Small")
	return(nil)
  )
  if( retXm > 9800. && retXm < 11000. then
    nRetWafXmTemp = 10 
  else if( retXm > 10999. && retXm < 12500. then
    nRetWafXmTemp = 9
  else if( retXm > 12499. && retXm < 14285. then
    nRetWafXmTemp = 8
  else if( retXm > 14284. && retXm < 16666. then
    nRetWafXmTemp = 7
  else if( retXm > 16665. && retXm < 20000. then
    nRetWafXmTemp = 6
  else if( retXm > 19999. && retXm < 25000. then
    nRetWafXmTemp = 5
  else if( retXm > 24999. && retXm < 33000. then
    nRetWafXmTemp = 4
  else
    nRetWafXmTemp = 4
    )))))))
  if(mod(nRetWafXmTemp 2) == 0 then
    retOffsetXm = -1. * retXm / 2.
    urCornerXm = nRetWafXmTemp / 2
    llCornerXm = -1 * urCornerXm + 1
  else
    retOffsetXm = 0.
    urCornerXm = fix(nRetWafXmTemp / 2)
    llCornerXm = -1 * urCornerXm
    );endif - mod(nRet...
else
  llCornerXm = -1 * fix((abs( edgeX) + retOffsetXm) / retXm + .5)
  urCornerXm = -1 * llCornerXm
  );endif - waferSize
 
nAdieXm = 3
nRetXwafm = urCornerXm - llCornerXm + 1
if( mod( nRetXwafm  nAdieXm) == 0 then
  aRetXm = fix( nRetXwafm / nAdieXm )
else
  aRetXm = fix( nRetXwafm / nAdieXm + 1 )
  )
ultraXOffset = retOffsetXm
 
; Calculate test block parameters based on matrix
 
llCornerX = llCornerXm * Xm
llCornerY = llCornerYm * Ym - (Ym - 1)
;if(!isPartialRet(llCornerX 0) then
;        llCornerX = llCornerX + 1
;)
urCornerX = urCornerXm * Xm + (Xm - 1)
urCornerY = urCornerYm * Ym
aRetX = aRetXm * Xm
aRetY = aRetYm * Ym
nRetXwaf = nRetXwafm * Xm
nRetYwaf = nRetYwafm * Ym
retOffsetX = retX * (1 - Xm) / 2 + retOffsetXm  
retOffsetY = retY * (Ym - 1) / 2 + retOffsetYm 
if(newOat=="false" then
findNavSites()                                  ; from retX, retY, retXm, retYm,
)
oat1X = xCoord( car(navaidSites))
oat1Y = yCoord( car(navaidSites))
oat2X = xCoord( cadr(navaidSites))
oat2Y = yCoord( cadr(navaidSites))
;oat3X = xCoord( caddr(navaidSites))
;oat3Y = yCoord( caddr(navaidSites))
oat3X = 0
oat3Y = 0

 
; generate form items
 
if(!getFormValues2() then
  printf("User ABORT\n")
  return(nil)
  )   
navaidSites = list(list(oat1X oat1Y) list(oat2X oat2Y) list(oat3X oat3Y))
; MEV recalc aRet[XY]m [ll,ur]Corner[X,Y] retOffset[X,Y]
;            ultra[X,Y]Offset nRetwaf[X,Y]m
;     FROM *****  [ll,ur]Corner[X,Y]m retOffset[X,Y]m [X,Y]m  *****
;       Calculate test block parameters based on matrix
llCornerX = llCornerXm * Xm
llCornerY = llCornerYm * Ym - (Ym - 1)
urCornerX = urCornerXm * Xm + (Xm - 1)
urCornerY = urCornerYm * Ym
nRetXwafm = urCornerXm - llCornerXm + 1
nRetYwafm = urCornerYm - llCornerYm + 1
if(mod(nRetXwafm  nAdieXm) == 0 then
  aRetXm = fix( nRetXwafm / nAdieXm )
else
  aRetXm = fix( nRetXwafm / nAdieXm + 1 )
  )
if(mod(nRetYwafm  nAdieYm) == 0 then
  aRetYm = fix( nRetYwafm / nAdieYm )
else
  aRetYm = fix( nRetYwafm / nAdieYm + 1 )
  )
aRetX = aRetXm * Xm
aRetY = aRetYm * Ym
nRetXwaf = nRetXwafm * Xm
nRetYwaf = nRetYwafm * Ym
retOffsetX = retX * (1 - Xm) / 2 + retOffsetXm 
;    hree Marks program retOffsetX = retOffsetX - 5000    
retOffsetY = retY * (Ym - 1) / 2 + retOffsetYm 
ultraXOffset = retOffsetXm
ultraYOffset = retOffsetYm + retYm / 2.
;if(!isPartialRet(llCornerX 0) then
;        llCornerX = llCornerX + 1
;)
if(newOat=="false" then
findNavSites() 
else
	    FixTheNav()
)

findOatFieldOffsets()
return(t)
))
procedure(FixTheNav()
   prog(( newNList site2)
		navaidSites = nil
		navaidSites = cons(list(oat1X oat1Y) navaidSites)
		navaidSites = cons(list(oat2X oat2Y) navaidSites)
		navaidSites = cons(list(oat3X oat3Y) navaidSites)

                navaidSites = reverse(navaidSites)
        if(Xm==2 then
                newNList = nil
                foreach( site navaidSites
                        site2 = list(xCoord(site)*Xm yCoord(site))
                        newNList = cons(site2 newNList)
                        site2 = list(xCoord(site2)+1 yCoord(site2))
                        newNList = cons(site2 newNList)
                )
                navaidSites = reverse(newNList)
        )
))
;**************************************************************************
procedure(isPartialRet(iX iY)
prog((xc yc )
;pd("isPartialRet" "")

; Checks to see if the any part of the reticle is on the wafer
;   within the outer ring
; check to see if the inner corner of this reticle is on the wafer:

xc = float( iX) * retX
yc = float( iY) * retY
if(xc + retOffsetX < 0. then
  xc = xc + .5 * retX 
  )
if(xc + retOffsetX > 0. then
  xc = xc - .5 * retX 
  )
if( yc + retOffsetY < 0. then
  yc = yc + .5 * retY 
  )
if(yc + retOffsetY > 0. then
  yc = yc - .5 * retY 
  )
if(isOnWafer(xc yc) then 
  return(t) )
return( nil)
))
;**************************************************************************
procedure(isAlmostPartialRet(iX iY)
prog((xc yc )
;pd("isPartialRet" "")
 
; Checks to see if the any part of the reticle is on the wafer
;   within the outer ring
; check to see if the inner corner of this reticle is on the wafer:
 
xc = float( iX) * retX
yc = float( iY) * retY
if(xc + retOffsetX < 0. then
  xc = xc + .5 * retX
  )
if(xc + retOffsetX > 0. then
  xc = xc - .5 * retX
  )
if( yc + retOffsetY < 0. then
  yc = yc + .5 * retY
  )
if(yc + retOffsetY > 0. then
  yc = yc - .5 * retY
  )
if(isOnWafer3(xc yc) then
  return(t) )
return( nil)
))

procedure(chipOnWafer(x y xd yd)

  isOnWafer(x y)&&isOnWafer(x+xd y+yd)&&isOnWafer(x+xd y)&&isOnWafer(x y+yd)
)
procedure(chipOnWafer2(x y xd yd)

isOnWafer2(x y)||isOnWafer2(x+xd y+yd)||isOnWafer2(x+xd y)||isOnWafer2(x y+yd)
)
procedure(chipOnWafer3(x y xd yd)

isOnWafer(x y)||isOnWafer(x+xd y+yd)||isOnWafer(x+xd y)||isOnWafer(x y+yd)
)

;*********************************************************************
procedure(isOnWafer(x y)
prog((w r )
;pd("isOnWafer" x:y)

; Checks to see if the coor. are on the wafer within the outer ring
; x y from a coord. system with the center of the origin test block
; as the origin of of the system. ----> We translate the x and y numbers
; to then be relative to the wafer center
; could improve to  check for flats for 3 or 4 inch

w = .5 * wafSize - 2675.0
x = x + retOffsetX
y = y + retOffsetY
r = sqrt(x*x + y*y) 

; test 4 and 3 inch wafers

if(waferSize == "4inch" then
  if( r <= w && 
      x < edgeX - 2675.0 && 
      y > edgeY + 2675.0 then
    return( t)
  else                          
    return( nil)
    )
else         ;3inch
  if( r <= w && 
      x > edgeX + wafEdge && 
      y < edgeY - wafEdge then
    return( t)
  else
    return( nil)
    )
  )
))
;*********************************************************************
procedure(isOnWafer2(x y)
prog((w r )
;pd("isOnWafer" x:y)
 
; Checks to see if the coor. are on the wafer within the outer ring
; x y from a coord. system with the center of the origin test block
; as the origin of of the system. ----> We translate the x and y numbers
; to then be relative to the wafer center
; could improve to  check for flats for 3 or 4 inch
 
w = .5 * wafSize + 1000 
x = x + retOffsetX
y = y + retOffsetY
r = sqrt(x*x + y*y)
 
; test 4 and 3 inch wafers
 
if(waferSize == "4inch" then
  if( r <= w then 
    return( t)
  else
    return( nil)
    )
else         ;3inch
  if( r <= w &&
      x > edgeX + wafEdge &&
      y < edgeY - wafEdge then
    return( t)
  else
    return( nil)
    )
  )
))
;*********************************************************************
procedure(isOnWafer3(x y)
prog((w r dummy)
;pd("isOnWafer" x:y)
 
; Checks to see if the coor. are on the wafer within the outer ring
; x y from a coord. system with the center of the origin test block
; as the origin of of the system. ----> We translate the x and y numbers
; to then be relative to the wafer center
; could improve to  check for flats for 3 or 4 inch
dummy = -retOffsetY - 47666.0
if(y<0.0 then
	if(y>dummy then
		return(t)
	else
		return(nil)
	)
)
w = .5 * wafSize + 1000
x = x + retOffsetX
y = y + retOffsetY
r = sqrt(x*x + y*y)
 
; test 4 and 3 inch wafers
 
if(waferSize == "4inch" then
  if( r <= w then
    return( t)
  else
    return( nil)
    )
else         ;3inch
  if( r <= w &&
      x > edgeX + wafEdge &&
      y < edgeY - wafEdge then
    return( t)
  else
    return( nil)
    )
  )
))

;*******************************************************************************
procedure(isPlugBar(iX iY)
  prog(()
;pd("isPlugBar" "")

; Checks to see if die is a plug bar. I still use this routine to drop out
; specific sites on the wafer.

foreach(site plugSites
  if(xCoord(site) == iX && 
     yCoord(site) == iY then
    return(t)
    )
  )            
return( nil)
))
;***************************************************************
procedure(wpMakeNumCells(type)
prog((char cellName saveFont width nString)
;pd("wpMakeNumCells" "")

; Creates a group of cells each containing one of the following
;  characters "0123456789-"

printf("Building number cells\n")
nString = "0123456789-"
saveFont = pgFont
pgFont = numFont    
pgTextLayer = nil
width = cRatio*cHeight

for(i 1 strlen(nString)
  char = substring(nString i 1)
  sprintf(cellName "%s_xy.m%s" reticleRep~>cellName char)
  cellRep = dbOpenCellViewByType(libraryName cellName "layout" 
				 "maskLayout" "w")
  if(cellRep then 
    wpMakeLabelCell(char cHeight width list(0 0) type "masterMark" cellRep)
    dbSave(cellRep)
    dbClose(cellRep) 
  else
    printf("ERROR - Unable to open cell rep\n")
    )
  )
for(i 1 strlen(nString)
  char = substring(nString i 1)
  sprintf(cellName "%s_xy.n%s" reticleRep~>cellName char)
  cellRep = dbOpenCellViewByType(libraryName cellName "layout" 
				 "maskLayout" "w")
  if(cellRep then
        if(layersType=="hbt" then
	wpMakeLabelCell(char cHeight width list(0 0) type "taProt" cellRep)
	else
    	wpMakeLabelCell(char cHeight width list(0 0) type "nplus" cellRep)
	)
    dbSave(cellRep)
    dbClose(cellRep)
  else
    printf("ERROR - Unable to open cell rep\n")
    )
  )
for(i 1 strlen(nString)
  char = substring(nString i 1)
  sprintf(cellName "%s_xy.p%s" reticleRep~>cellName char)
  cellRep = dbOpenCellViewByType(libraryName cellName "layout" 
				 "maskLayout" "w")
  if(cellRep then
	if(layersType=="hbt" then
wpMakeLabelCell(char cHeight width list(0 0) type "eProt" cellRep)
	else
    wpMakeLabelCell(char cHeight width list(0 0) type "markerProtect" cellRep)
	)
    dbSave(cellRep)
    dbClose(cellRep)
  else
    printf("ERROR - Unable to open cell rep\n")
    )
  )

pgFont = saveFont
pgTextLayer = t
))
;**********************************************************************
procedure(wpMakeLabelCell(label height width posn type layer textCellDB)
prog((textWidth )
;pd("wpMakeLabelCell" "")

; make pg graphics for the specified character
; this version of makeLabelCell was taken from pgtext.il
; but differs from the original version replacing the global
; textCellDB with an additional parameter.

if(textCellDB~>shapes != nil then
  foreach(shape textCellDB~>shapes
    dbDeleteObject(shape)
    )
  )
; Note! the function addPgableString comes from pgtext.il

textWidth = addPgableString(label height width posn type layer)
))
;***************************************************************************
procedure(wpCouponList()
prog( ( chipName list relPt found list2 rep offX offY chipNum 
	couponRep cpCount len list3)
;pd("wpCouponList" "")
 
; Creates a new chip list for the coupons, redefining origins to be relative
;   to the label "align+point"
 
couponList = nil
cpCount = 0.0
cpFlag = 0
foreach(chip chipList
  cpCount = cpCount + 1.0
  chipName = car(chip)
  len = strlen(chipName)
  chipNum = substring(chipName len-1 2)
 
 
  if(chipNum == "99" then
    cpFlag = 1
  else
    cpFlag = 0
  )
 
 
        found=nil
; Search for the align+point label
 
  couponRep = dbOpenCellViewByType(libraryName chipName "layout" 
				   "maskLayout"  "r")
  if(couponRep then
    list = couponRep~>layerPurposePairs~>instances

    foreach(obj list
      foreach(item obj
        if(item~>shape == "label" &&
           item~>theLabel == "align+point" &&
           item~>layer != 255 then
          found=t
          foreach(q caddr(chip)
            relPt = list(xCoord(item~>xy) yCoord(item~>xy))
            couponList = cons(list(q relPt evalstring(chipNum)) couponList)
          )
        )
      )
    )

    if(found==nil then
        list2 = couponRep~>instances
        foreach(obj2 list2
          offX = xCoord(obj2~>xy)
          offY = yCoord(obj2~>xy)
          rep = dbOpenCellViewByType(obj2~>libName obj2~>cellName "layout" 
				   "maskLayout" "r")
          if(rep then
            list = rep~>layerPurposePairs~>instances
;            dbClose(rep)
            foreach(obj list
              foreach(item obj
                if(item~>shape == "label" &&
                   item~>theLabel == "align+point" &&
                   item~>layer != 255 then
                  foreach(q caddr(chip)
                    relPt = list(xCoord(item~>xy)+ offX yCoord(item~>xy)+ offY)
                    couponList = cons(list(q relPt evalstring(chipNum)) 
					couponList)
		    found = t
		  )
                )
              )
            )
          )
	)
    )

    if(found==nil then
      list2 = couponRep~>instances
      foreach(obj2 list2
        offX = xCoord(obj2~>xy)
        offY = yCoord(obj2~>xy)
        rep = dbOpenCellViewByType(obj2~>libName obj2~>cellName "layout" 
				   "maskLayout" "r")
        if(rep then
          list3 = rep~>instances
          foreach(obj3 list3
            offX = xCoord(obj3~>xy)
            offY = yCoord(obj3~>xy)
            rep = dbOpenCellViewByType(obj3~>libName obj3~>cellName "layout" 
				   "maskLayout" "r")
            list = rep~>layerPurposePairs~>instances
;           dbClose(rep)
            foreach(obj list
              foreach(item obj
                if(item~>shape == "label" &&
                   item~>theLabel == "align+point" &&
                   item~>layer != 255 then
                  foreach(q caddr(chip)
                    relPt = list(xCoord(item~>xy)+ offX yCoord(item~>xy)+ offY)
                    couponList2 = cons(list(q relPt evalstring(chipNum)) 
					couponList2)
                    found = t
                  )
                )
              )
            )
          )
        )
      )
    )

    if( found == nil then
      hiGetAttention()
      printf( "Failed to find align+point label in %s\n" chipName)
    )
    dbClose(couponRep)
;    printf( "couponList: %L\n" couponList)
  else
    printf("ERROR - Unable to open coupon rep\n")
    return(nil)
  )
)
))

;**********************************************************
procedure(wpCouponList2()
prog( ( chipName list relPt found list2 rep offX offY chipNum 
	couponRep cpCount len list3)
;pd("wpCouponList" "")
 
; Creates a new chip list for the coupons, redefining origins to be relative
;   to the label "align+point"
; This function creates the new chip list for the coupons in the oat 
couponList2 = nil
cpCount = 0.0
opFlag = 0
foreach(chip oatChipList
  cpCount = cpCount + 1.0
  chipName = car(chip)
  len = strlen(chipName)
  chipNum = substring(chipName len-1 2)
 
  if(chipNum == "99" then
    cpFlag = 1
  else
    cpFlag = 0
  )

 
; Search for the align+point label
 
  couponRep = dbOpenCellViewByType(libraryName chipName "layout" 
				   "maskLayout" "r")
  if(couponRep then
    list = couponRep~>layerPurposePairs~>instances
    foreach(obj list
      foreach(item obj
        if(item~>shape == "label" &&
           item~>theLabel == "align+point" &&
           item~>layer != 255 then
          found = t
          foreach(q caddr(chip)
            relPt = list(xCoord(item~>xy) yCoord(item~>xy))
            couponList2 = cons(list(q relPt evalstring(chipNum)) couponList2)
          )
        )
      )
    )
    if(found==nil then
      list2 = couponRep~>instances
      foreach(obj2 list2
        offX = xCoord(obj2~>xy)
        offY = yCoord(obj2~>xy)
        rep = dbOpenCellViewByType(obj2~>libName obj2~>cellName "layout" 
				   "maskLayout" "r")
        if(rep then
          list = rep~>layerPurposePairs~>instances
;          dbClose(rep)
          foreach(obj list
            foreach(item obj
              if(item~>shape == "label" &&
                 item~>theLabel == "align+point" &&
                 item~>layer != 255 then
                foreach(q caddr(chip)
                  relPt = list(xCoord(item~>xy)+ offX yCoord(item~>xy)+ offY)
                  couponList2 = cons(list(q relPt evalstring(chipNum)) 
					couponList2)
                )
              )
            )
          )
        )
      )
    )

    if(found==nil then
      list2 = couponRep~>instances
      foreach(obj2 list2
        offX = xCoord(obj2~>xy)
        offY = yCoord(obj2~>xy)
        rep = dbOpenCellViewByType(obj2~>libName obj2~>cellName "layout" 
				   "maskLayout" "r")
        if(rep then
          list3 = rep~>instances
          foreach(obj3 list3
            offX = xCoord(obj3~>xy)
            offY = yCoord(obj3~>xy)
            rep = dbOpenCellViewByType(obj3~>libName obj3~>cellName "layout" 
				   "maskLayout" "r")
            list = rep~>layerPurposePairs~>instances
;           dbClose(rep)
            foreach(obj list
              foreach(item obj
                if(item~>shape == "label" &&
                   item~>theLabel == "align+point" &&
                   item~>layer != 255 then
                  foreach(q caddr(chip)
                    relPt = list(xCoord(item~>xy)+ offX yCoord(item~>xy)+ offY)
                    couponList2 = cons(list(q relPt evalstring(chipNum)) 
					couponList2)
                    found = t
                  )
                )
              )
            )
          )
        )
      )
    )

    if( found == nil then
       hiGetAttention()
       printf( "Failed to find align+point label in %s\n" chipName)
    )
    dbClose(couponRep)

  else
    printf("ERROR - Unable to open coupon rep\n")
    return(nil)
    )
  )
))

procedure(GetPassNames(pass nameList)
   prog((msg passNum passNames formLabel Fld1 Form status)

    sprintf( msg "Specify the number of chips for pass #%d" pass)

	formLabel = hiCreateLabel(?name 'frLabel ?labelText msg)

	Fld1 = hiCreateIntField(
             ?name              'buttonPath1
             ?value             1
             ?defValue          1
             ?prompt            "Number of Unique Chips"
           )

        Form = hiCreateForm(
             'getP1
             msg
             list('ok 'cancel)
             list(formLabel Fld1)
        )
	
        status = hiDisplayForm(Form)
        if(status == nil then
                return(nil)
        )

	passNum = Fld1->value

	if(passNum==1 then
        	passNames = Get1NameNumber(nameList 0)
	)
	if(passNum==2 then
        	passNames = Get2NameNumber(nameList 0)
	)
	if(passNum==3 then
        	passNames = Get3NameNumber(nameList 0)
	)
	if(passNum==4 then
        	passNames = Get4NameNumber(nameList 0)
	)
        if(passNum==5 then
                passNames = Get5NameNumber(nameList 0)
        )
        if(passNum==6 then
                passNames = Get6NameNumber(nameList 0)
        )
        if(passNum==7 then
                passNames = Get7NameNumber(nameList 0)
        )
        if(passNum==8 then
                passNames = Get8NameNumber(nameList 0)
        )
        if(passNum==9 then
                passNames = Get9NameNumber(nameList 0)
        )
        if(passNum==10 then
                passNames = Get10NameNumber(nameList)
        )
        if(passNum>10 then
		passNames = First10NameNumber(nameList)
		passNum = passNum - 10
		
		while(passNum>=10
			passNames = append(passNames Next10NameNumber(nameList))
			passNum = passNum - 10
		)
        	if(passNum==1 then
                	passNames = append(passNames Get1NameNumber(nameList 1))
        	)
        	if(passNum==2 then
                	passNames = append(passNames Get2NameNumber(nameList 1))
        	)
        	if(passNum==3 then
                	passNames = append(passNames Get3NameNumber(nameList 1))
        	)
        	if(passNum==4 then
                	passNames = append(passNames Get4NameNumber(nameList 1))
        	)
        	if(passNum==5 then
                	passNames = append(passNames Get5NameNumber(nameList 1))
        	)
        	if(passNum==6 then
                	passNames = append(passNames Get6NameNumber(nameList 1))
        	)
        	if(passNum==7 then
                	passNames = append(passNames Get7NameNumber(nameList 1))
        	)
        	if(passNum==8 then
                	passNames = append(passNames Get8NameNumber(nameList 1))
        	)
        	if(passNum==9 then
                	passNames = append(passNames Get9NameNumber(nameList 1))
        	)
	)	
	return(passNames)
))

procedure(getNewChipList()
  prog((newChipList)
  newChipList = nil

	OatNames()
        wpChipNames()

  foreach(chip oatChipList
  	if(!member(car(chip) chipNames2) then
		newChipList = cons(chip newChipList)
	)
  )
  newChipList = append(chipList newChipList)
  return(newChipList)
))
procedure(getNames(listOfChips)
   prog((nameList)

   nameList = nil
   foreach(chip listOfChips
	nameList = cons(car(chip) nameList)
   )
	nameList = reverse(nameList)
   return(nameList)

))
;********************************************************************
procedure(wpProbeSet(portToUse)
prog(( nPasses nameList chipName
          ffsLabel chipNum plotMap doParts
          newChipList readFile81 readFile99 chip99 chip81
	  cList1 cList2 ISACOUPON oatFlag)
;pd("wpProbeSet" "")

; Front end to the final fronside routines
cList1 = nil
cList2 = nil
chip99=nil
chip81 = nil
newChipList=getNewChipList()
plotMap = t
ffsLabel = ""
doParts = t
nPasses = length(newChipList)
nameList = getNames(newChipList)
ISACOUPON = nil

foreach(chip newChipList
	chipName = car(chip)
        chipNum = substring(chipName strlen(chipName)-1 2)

    	if( strcmp(chipNum "99")==0 then
        	ISACOUPON = t
    	)
    	if( strcmp(chipNum "81")==0 then
        	ISACOUPON = t
        )
)
 
foreach(chip newChipList
    	nFfsX = 1
    	nFfsY = 1
; If this is test coupon 99, then add the other coupon 
; instances to this instance list

	chipName = car(chip)
	chipNum = substring(chipName strlen(chipName)-1 2)
    	if( strcmp(chipNum "99")==0 then 
		chip99 = t
    	)
    	if( strcmp(chipNum "81")==0 then
       		chip81 = t
	)

	nOat = 0
	if(member(chipName oatNames) then
		foreach(dChip oatChipList
			if(chipName==car(dChip)
				nOat = length(caddr(dChip))
			)
		)
	)
    	nIntra = length( caddr( chip)) - 1

        sprintf( newLibName "%s-%s" substring(libraryName 1 2) substring(libraryName 3 strlen(libraryName)))
	if(strcmp(processType "RF")==0 then
		sprintf( kFile "%s_%s_rf.ffs" newLibName chipNum)
		testType = "_rf"
	)
	if(strcmp(processType "DC")==0 then
                sprintf( kFile "%s_%s_dc.ffs" newLibName chipNum)
		testType = "_dc"
        )
	if(strcmp(processType "BOTH")==0 then
                sprintf( kFile "%s_%s_rfdc.ffs" newLibName chipNum)
		testType = "_dcrf"
        )
	write2Par = nil 
	if(member(chipName chipNames2) then
		if(retType=="true" && !ISACOUPON then
		; The .par file is used by percent
		sprintf( parFile "%s/%s_%s.par" releasePath newLibName chipNum)
		parPort = outfile( parFile "w")
		write2Par = t
		)
	) 
	if(strcmp(chipNum "99")==0 then
                readFile99 = kFile
        )
        if(strcmp(chipNum "81")==0 then
                readFile81 = kFile
        )

	probeNames = cons(kFile probeNames)
	probeNames2 = cons(chipName probeNames2)
    	sprintf( sampleFile "%s/%s_%s.sample" releasePath newLibName chipNum)
	sprintf( edgFile "%s/%s_%s.edg" releasePath newLibName chipNum)
	sprintf( edg2File "%s_%s.edg2" newLibName chipNum)


    	sprintf( prbDwg "ffsmap_%s" chipNum)
    	sprintf( plotTitle "%s-%s PROBE PATTERN" libraryName chipNum)
    	sprintf( dsName "%s-%s_ffs" newLibName chipNum)
    	sprintf( ffsLabel "chip_%s" chipNum)

; open probe rep

    sprintf(probeName "%s_%s" reticleRep~>cellName prbDwg)
    probeRep = dbOpenCellViewByType(libraryName probeName "layout" 
				    "maskLayout" "w") 
    if(probeRep then  
      showAeble = nil
	if(member(chipName chipNames2) then
		if(member(chipName oatNames) then
			oatFlag = 2
		else
			oatFlag = 1
		)
	else
		oatFlag = 0
	)

      wpWaferMap(probeRep oatFlag)
      wpProbePass(chip chipNum ffsLabel length(newChipList) doParts portToUse oatFlag) 
	if(write2Par==t then
		close(parPort)
		write2Par = nil
	)	
      dbSave(probeRep)
      if(plotMap then
        if(wpWafPlot(plotTitle dsName probeRep portToUse) then
          fprintf(portToUse "Created wafer plot file:    %s\n" dsName)
        )
      )
      dbClose(probeRep)

; Reset coupon 99's instance list
    
    else
      hiGetAttention()
      printf("ERROR - Unable to open probe rep\n")
      return(nil) 
    ); if probeRep
  )
        if(chip81 then
        	CreateFFS(readFile81 "81")
        )

	if(chip99 then
		CreateFFS(readFile99 "99")
	)
))
procedure(GetWafNumXY()
   prog((newChipList sites site)
 
        newChipList=nil
	foreach(chip oatChipList
                if(!member(car(chip) chipNames2) then  
                        newChipList=cons(chip newChipList)     
                )      
        )
        newChipList=append(chipList newChipList)       
         
        sites = nil    
        foreach(chip newChipList       
                site = caddr(chip)     
                sites = append(sites site)     
        )      
 
        sites = wpXySort(sites)
        return(list(maxX maxY))
))
         

;*****************************************************************************
procedure(wpProbePass(chipData chipNum ffsLabel nChips doParts portToUse oatFlag)
  prog((chipName tempFile numX numY nDie k1X k1Y buf tempxy wafX wafY
	x y coupX coupY loop2 nDie2 samplePort tempPort testedCoupons)

; Probe for generating the probe instructions
; open a temporary file for the Keithley position data:

tempFile = "/tmp/ffsmap.tmp"
tempPort = outfile( tempFile "w")
samplePort = outfile( sampleFile "w")
if(samplePort == nil then
  hiGetAttention()
  printf("ERROR - Unable to open sample file: %s\n" sampleFile)
  return( nil)
  )
edgPort = outfile( edgFile "w")
if(edgPort == nil then
  hiGetAttention()
  printf("ERROR - Unable to open edge file: %s\n" edgFile)
  return( nil)
  )


if(tempPort == nil then
  hiGetAttention()
  printf("ERROR - Unable to open temporary file: %s\n" tempFile)
  return( nil)
  )
; search through sites as if you were the Keithley,
; and where there's a complete reticle,
; draw the die box with wafer position numbers inside,
; write the data for each die to the Keithley output file,
; also compute the starting position:

printf("Generating probe pattern.\n")
tempxy = car( navaidSites)
if(waferSize == "4inch" then
  alignX = car( tempxy)
  alignY = cadr( tempxy) + 1
else
  alignX = car( tempxy) + 1
  alignY = cadr( tempxy)
  )      
if(Xm==2 then
dbCreateLabel(probeRep labelLayer list((alignX-.75)*retX  alignY*retY) 
              "S" "leftBottom" "R0" "stick" retY*0.3)
else
dbCreateLabel(probeRep labelLayer list((alignX+.25)*retX  alignY*retY)
              "S" "leftBottom" "R0" "stick" retY*0.3)
)
	nDie2 = 0
listEdges = nil
oatEdges = nil
;ifretType=="true" then	
        if(!isCouponChip(kFile) && !isNCouponChip(kFile) && edgeDie=="true" then
	if(!isCouponChip(car(chipData)) && !isNCouponChip(car(chipData)) then
	keithLoop3(edgPort chipData)
))
loop2 = keithLoop2(tempPort chipData doParts samplePort oatFlag edgPort)

nDie = car(loop2)
wafX = cadr(loop2)
wafY = caddr(loop2)
nChipsTotal = nFullRets * (nIntra + 1) + nOatRets * nOat + nEdgeChips
k1X = ( alignX - llCornerX)
k1Y = ( alignY - llCornerY)
numX = k1X * cadr( loop2)
numY = k1Y * caddr( loop2)
wafX = wafX * k1X
wafY = wafY * k1Y
coupX = wafX
coupY = wafY
	chipName = car(chipData)
	x = xCoord(car(wpXySort(car(cddr(chipData)))))
	y = yCoord(car(wpXySort(car(cddr(chipData)))))
	if(member(chipName chipNames2) then
	if(retType=="true" then
		wafX = car(GetWafNumXY())
		wafY = cadr(GetWafNumXY()) 
		wafX = wafX * k1X
		wafY = wafY * k1Y
	else
		wafX = car(GetNumXY(chipName k1X+llCornerX k1Y+llCornerY x y))
        	wafY = cadr(GetNumXY(chipName k1X+llCornerX k1Y+llCornerY x y))
	)	
	)
	listEdges2 = listEdges
        listEdges = SortEdges(listEdges)      
	listEdges = append(oatEdges listEdges)

; add the starting position to the bottom of the temp file,
; close the temporary file,
; create the real Keithley file header,
; then append the temp file to it:

fprintf( tempPort "*  Starting Position (index & written numbers)\n")
fprintf( edgPort "*  Starting Position (index & written numbers)\n")
fprintf( samplePort "*  Starting Position (index & written numbers)\n")
if( couponChip then
  fprintf( tempPort "   %d  %d  %d  %d\n" k1X k1Y coupX coupY)
  fprintf( edgPort "   %d  %d  %d  %d\n" k1X k1Y coupX coupY)
  fprintf( samplePort "   %d  %d  %d  %d\n" k1X k1Y coupX coupY)
 else
  fprintf( tempPort "   %d  %d  %d  %d\n" k1X k1Y wafX wafY)
  fprintf( edgPort "   %d  %d  %d  %d\n" k1X k1Y wafX wafY)
  fprintf( samplePort "   %d  %d  %d  %d\n" k1X k1Y wafX wafY)
  )
; MEV could add reticle build info to end of ffs file here

close(tempPort)
close(samplePort)
close(edgPort)
makeKeithleyFile(kFile nDie retX/nFfsX retY/nFfsY tempFile)
makeKeithleyFile(edg2File nDie2 retX/nFfsX retY/nFfsY edgFile)

; annotate the ffsmap plot
; and write data into the log file:

if(member(chipName oatNames) then
	nPartRets = nDie-nFullRets-(3*Xm)
	nFullRets = nFullRets+nOatRets
else
	nPartRets = nDie-nFullRets
	nFullRets = nFullRets+nOatRets
)
if( doParts then
   if(cpFlag == 1 then
      testedCoupons = nChipsTotal
      sprintf(buf "%d Coupons can be probed in %d Full & %d Partial Reticles"
                   testedCoupons nFullRets nPartRets)
   else
      sprintf(buf "%d Probed Chips in %d Full & %d Partial Reticles"
                   nChipsTotal nFullRets nPartRets)
   )
else
   if(cpFlag == 1 then	
      testedCoupons = nChipsTotal
      sprintf(buf "%d Coupons can be probed in %d Full Reticles"
                   testedCoupons nFullRets)
   else
      sprintf(buf "%d Probed Chips in %d Full Reticles"
                   nChipsTotal nFullRets)
   )
)

x = retX * 2
y = wafSize / 2. + retY
dbCreateLabel(probeRep labelLayer list(x y)
              buf "leftBottom" "R0" "stick" retY*0.3)

; add chip label

if(ffsLabel != "" then  
  buf = ffsLabel
  x = (llCornerX - .9) * retX
  y = 0.
  dbCreateLabel(probeRep labelLayer list(x y) 
              ffsLabel "centerCenter" "R90" "stick" retY*0.3)
  )

printf("Keithley File: %s\n" kFile)
printf("Chip Name: %s\n" car(chipData))
printf("%s\n" buf)
if(nIntra > 0 then 
  printf( "* - Intra-Die Moves:  %d\n" nIntra)
else 
  printf( "* - Probe Die per Reticle  X:  %d  Y:  %d\n" nFfsX nFfsY) 
  )
fprintf(portToUse "\nProbe Pattern for chip %s-%s\n" libraryName chipNum)
fprintf(portToUse "Chip Cell Name:        %s\n" car( chipData))
fprintf(portToUse "Keithley File:    %s\n" kFile)
fprintf(portToUse "%s\n" buf)
if(nIntra > 0 then 
  fprintf(portToUse "Intra-Die Moves:  %d\n" nIntra)
else 
  fprintf(portToUse "Probe Die per Reticle  X:  %d  Y:  %d\n" nFfsX nFfsY)
  )
  
	if(!isCouponChip(kFile) && !isNCouponChip(kFile) && edgeDie=="true" then
        if(member(chipName chipNames2) then
        NewEdgeFile("newedge")
        ))
)
)
;*************************************************************************
procedure(wpWaferMap(drawRep oatFlag)
prog(( buf x y xll yll xur yur mapList) 
;pd("wpWaferMap" "")

; Draws a view of the aeblemap (generate the wafer map graphics)

printf("Creating wafer map graphics\n")

; add the wafer outline from the wafer library
wpPlaceOutline(drawRep -retOffsetXm:-retOffsetY)

; draw a box representing each complete reticle,
; also determine the iX,iY for the first complete reticle:
;;HHR
nFullRets = 0
nPartRets = 0
nOatRets = 0


for(iY llCornerY urCornerY
  for(iX llCornerX urCornerX
	if(isNavSite(iX iY) then
		xll = (iX-.5*Xm)*retX+500
		yll = (iY-.5)*retY+500
		xur = retX-1000
		yur = retY-1000
    		if(processNav(iX iY) then
      			drawNavCross2(iX iY drawRep)
			nOatRets = nOatRets + 1
		else
			wpRelRect(drawRep reticleLayer xll yll xur yur)
			wpRelRect(drawRep matrixLayer xll yll xur yur)
		)
	)
   )
)
for(iY llCornerY urCornerY
  for(iX llCornerX urCornerX
        if(!isNavSite(iX iY) then
                xll = (iX-.5*Xm)*retX+500
                yll = (iY-.5)*retY+500
                xur = retX-1000
                yur = retY-1000
		if(isFullReticle(iX iY) then	
          		nFullRets = nFullRets + 1
      		else
        		if(isPartialRet(iX iY) then
            			nPartRets = nPartRets + 1
	    		)
		)
	)
   )
)

; setup map list data

x = (urCornerXm + 1 ) * retXm
mapList = nil
sprintf( buf "Design Name= %s", libraryName)
mapList = append1( mapList buf )
sprintf( buf "retXm= %10.2f", retXm)
mapList = append1( mapList buf )
sprintf( buf "retYm= %10.2f", retYm)
mapList = append1( mapList buf )
sprintf( buf "aRetXm= %3d", aRetXm)
mapList = append1( mapList buf )
sprintf( buf "aRetYm= %3d", aRetYm)
mapList = append1( mapList buf )
sprintf( buf "nAdieXm= %3d", nAdieXm)
mapList = append1( mapList buf )
sprintf( buf "nAdieYm= %3d", nAdieYm)
mapList = append1( mapList buf )
sprintf( buf "llCornerXm= %3d", llCornerXm)
mapList = append1( mapList buf )
if(isNavSite(0 1) then
	sprintf( buf "llCornerYm= %3d", llCornerYm-1)
else
	if(isNavSite(0 0) then
		sprintf( buf "llCornerYm= %3d", llCornerYm)
	else
		sprintf( buf "llCornerYm= %3d", llCornerYm+1)
	)
)
mapList = append1( mapList buf )
sprintf( buf "urCornerXm= %3d", urCornerXm)
mapList = append1( mapList buf )
if(isNavSite(0 1) then
        sprintf( buf "urCornerYm= %3d", urCornerYm-1)
else
        if(isNavSite(0 0) then
                sprintf( buf "urCornerYm= %3d", urCornerYm)
        else
                sprintf( buf "urCornerYm= %3d", urCornerYm+1)
        )
)
mapList = append1( mapList buf )
if(optHam=="true" then
	sprintf( buf "retOffsetXm= %7.2f", optRetOffXm)
else
	sprintf( buf "retOffsetXm= %7.2f", retOffsetXm)
)
mapList = append1( mapList buf )
if(optHam=="true" then
	sprintf( buf "retOffsetYm= %7.2f", optRetOffYm)
else
	sprintf( buf "retOffsetYm= %7.2f", retOffsetYm)
)
mapList = append1( mapList buf )
if(waferSize == "4inch" then
        sprintf( buf "oatFieldOffset1X= %7.2f", oatFieldOffset1X)
  mapList = append1( mapList buf )
 
        sprintf( buf "oatFieldOffset1Y= %7.2f", oatFieldOffset1Y)
  mapList = append1( mapList buf )
 
        sprintf( buf "oatFieldOffset2X= %7.2f", oatFieldOffset2X)
  mapList = append1( mapList buf )
 
        sprintf( buf "oatFieldOffset2Y= %7.2f", oatFieldOffset2Y)
  mapList = append1( mapList buf )
 
        sprintf( buf "oatFieldOffset3X= %7.2f", oatFieldOffset3X)
  mapList = append1( mapList buf )
 
        sprintf( buf "oatFieldOffset3Y= %7.2f", oatFieldOffset3Y)
  mapList = append1( mapList buf )
  )
if( Xm != 1 || Ym != 1 then
  sprintf( buf "Xm= %3d", Xm)
  mapList = append1( mapList buf )
  sprintf( buf "Ym= %3d", Ym)
  mapList = append1( mapList buf )
  sprintf( buf "retX= %10.2f", retX)
  mapList = append1( mapList buf )
  sprintf( buf "retY= %10.2f", retY)
  mapList = append1( mapList buf )
  sprintf( buf "retOffsetX= %7.2f", retOffsetX)
  mapList = append1( mapList buf )
  sprintf( buf "retOffsetY= %7.2f", retOffsetY)
  mapList = append1( mapList buf )
  sprintf( buf "llCornerX= %3d", llCornerX)
  mapList = append1( mapList buf )
  sprintf( buf "llCornerY= %3d", llCornerY)
  mapList = append1( mapList buf )
  sprintf( buf "urCornerX= %3d", urCornerX)
  mapList = append1( mapList buf )
  sprintf( buf "urCornerY= %3d", urCornerY)
  mapList = append1( mapList buf )
  )
sprintf( buf "Date= %s",  getCurrentTime())
mapList = append1( mapList buf )

; print out map list data

y = wafSize / 2.
foreach( buffer mapList
  y = y - 5000. * .5
  dbCreateLabel(drawRep labelLayer list(x y) buffer "leftBottom" "R0" "stick" 2000)
  )
))

procedure(wpViaWaferMap()
  prog((viaDwg viaRep iX iY buf x y startllX startFound
	stopY numLow numLow2 numLow3 numHigh numHigh2 numHigh3 mapList)
 
sprintf(viaDwg "%s_viamap" retDwg) ;wafermap drawing name
viaRep = dbOpenCellViewByType(libraryName viaDwg "layout" "maskLayout" "w")
wpDrawXyDie(viaRep)
wpPlaceOutline(viaRep -retOffsetXm:-retOffsetY)
 
; draw a box representing each complete reticle,
; also determine the iX,iY for the first complete reticle:
;;HHR
startllX = llCornerX
if(!evenp(startllX) then
        startllX = startllX - 1
)
 
nFullRets = 0
iY = llCornerY
startFound = nil
iX = startllX
while(iX<=urCornerX && startFound==nil
iY = llCornerY
  while(iY<=urCornerY && startFound==nil
        if(isPartialRet(iX iY) then
                startllX = iX
                startFound = t
        )
	iY = iY + Ym
  )
  iX = iX + Xm
)

numLow = (llCornerY - .5) * retY + 500
numLow2 = -47655.4 - retOffsetY
numLow3 = abs(numLow2) - abs(numLow)
numLow3 = abs(numLow3)
numHigh = (urCornerY - .5) * retY + 500
numHigh2 = 50644.5 - retOffsetY
numHigh3 = abs(numHigh2) - abs(numHigh)
numHigh3 = abs(numHigh3)
 

if(numLow3>=500.0 then 
	iY = llCornerY - 1
else
	iY = llCornerY
)
if(numHigh3>=500.0 then
        stopY = urCornerY + 1
else
        stopY = urCornerY
)
if(numLow3<500.0 && numHigh3<500.0 then
	if(numLow3>numHigh3 then
		iY = llCornerY - 1
	else
		stopY = urCornerY + 1
	)
)

while(iY<=stopY
        iX = startllX
  while(iX<=urCornerX
        if(!isPartialRet(iX iY) && !isFullReticle(iX iY) then
                wpRelRect(viaRep reticleLayer (iX-.5*Xm)*retX+500 (iY-.5)*retY+500 retXm-1000 retYm-1000)
        )
    if(isNavSite(iX iY) then
        if( processNav(iX iY) then
        bernCount = bernCount + 1
      drawNavCross(iX iY viaRep)
        )
    else
      if(isFullReticle(iX iY) then
          if(showAeble then
            wpRelRect(viaRep reticleLayer (iX-.5*Xm)*retX+500 (iY-.5)*retY+500 retXm-1000 retYm-1000)
            )
          nFullRets = nFullRets + Xm
      else
        if(Xm==1 then
        if(isPartialRet(iX iY) then
              wpRelRect(viaRep reticleLayer (iX-.5*Xm)*retX+500 (iY-.5)*retY+500 retXm-1000 retYm-1000)
            nPartRets = nPartRets + Xm
          ) ; endif - Part
        else
        if(isPartialRet(iX iY) || isPartialRet(iX+1 iY) then
                wpRelRect(viaRep reticleLayer (iX-.5*Xm)*retX+500 (iY-.5)*retY+500 retXm-1000 retYm-1000)
                nPartRets = nPartRets + Xm
          ) ; endif - Part
        ) ; endif Xm==1
        ) ; endif - Full
      ) ; if - Nav
        iX = iX + Xm
    ) ; for X
        iY = iY + Ym
  ) ; for Y
 
x = (urCornerXm + 1 ) * retXm
mapList = nil
sprintf( buf "Design Name= %s", libraryName)
mapList = append1( mapList buf )
sprintf( buf "retXm= %10.2f", retXm)
mapList = append1( mapList buf )
sprintf( buf "retYm= %10.2f", retYm)
mapList = append1( mapList buf )
sprintf( buf "Rows= %3d", ((urCornerYm-llCornerYm) +1) )
mapList = append1( mapList buf )
sprintf( buf "Mebus Cols= %3d", ((urCornerXm-llCornerXm) +1) )
mapList = append1( mapList buf )
sprintf( buf "Aeble Cols= %3d", AebleCols )
mapList = append1( mapList buf )
if(optHam=="true" then
sprintf( buf "retOffsetXm= %7.2f", optRetOffXm)
else
sprintf( buf "retOffsetXm= %7.2f", retOffsetXm)
)
mapList = append1( mapList buf )
if(optHam=="true" then
        sprintf( buf "retOffsetYm= %7.2f", optRetOffYm)
else
        sprintf( buf "retOffsetYm= %7.2f", retOffsetYm)
)
mapList = append1( mapList buf )

        if(waferSize == "4inch" then
                if(optHam=="true" then
			ultraYOffset = optRetOffYm + retYm / 2. - 202.0 
                else
                        ultraYOffset = retOffsetYm + retYm / 2. - 202.0
                )
        )
sprintf( buf "ultraYoffset= %7.2f", ultraYOffset)
mapList = append1( mapList buf )
        sprintf( buf "waferShiftX= %7.2f", waferShiftX)
        mapList = append1( mapList buf )
        sprintf( buf "waferShiftY= %7.2f", waferShiftY)
        mapList = append1( mapList buf )
 
if(waferSize == "4inch" then
        sprintf( buf "oatFieldOffset1X= %7.2f", oatFieldOffset1X - (.5 * retXm))
  mapList = append1( mapList buf )
 
        sprintf( buf "oatFieldOffset1Y= %7.2f", oatFieldOffset1Y - (.5 * retYm))
  mapList = append1( mapList buf )
 
        sprintf( buf "oatFieldOffset2X= %7.2f", oatFieldOffset2X - (.5 * retXm))
  mapList = append1( mapList buf )
 
        sprintf( buf "oatFieldOffset2Y= %7.2f", oatFieldOffset2Y - (.5 * retYm))
  mapList = append1( mapList buf )
 
        sprintf( buf "oatFieldOffset3X= %7.2f", oatFieldOffset3X - (.5 * retXm))
  mapList = append1( mapList buf )
 
        sprintf( buf "oatFieldOffset3Y= %7.2f", oatFieldOffset3Y - (.5 * retYm))
  mapList = append1( mapList buf )
  )
if( Xm != 1 || Ym != 1 then
  sprintf( buf "Xm= %3d", Xm)
  mapList = append1( mapList buf )
  sprintf( buf "Ym= %3d", Ym)
  mapList = append1( mapList buf )
  sprintf( buf "retX= %10.2f", retX)
  mapList = append1( mapList buf )
  sprintf( buf "retY= %10.2f", retY)
  mapList = append1( mapList buf )
if(optHam=="true" then
  sprintf( buf "retOffsetX= %7.2f", optRetOffXm)
else
  sprintf( buf "retOffsetX= %7.2f", retOffsetX)
)
  mapList = append1( mapList buf )
if(optHam=="true" then
  sprintf( buf "retOffsetY= %7.2f", optRetOffYm)
else
  sprintf( buf "retOffsetY= %7.2f", retOffsetY)
)
  mapList = append1( mapList buf )
  sprintf( buf "llCornerX= %3d", llCornerX)
  mapList = append1( mapList buf )
  sprintf( buf "llCornerY= %3d", llCornerY)
  mapList = append1( mapList buf )
  sprintf( buf "urCornerX= %3d", urCornerX)
  mapList = append1( mapList buf )
  sprintf( buf "urCornerY= %3d", urCornerY)
  mapList = append1( mapList buf )
  )
foreach(item photoList
 mapList = append1( mapList item )
)
 
 
y = wafSize / 2.
foreach( buffer mapList
  y = y - 5000. * .5
  dbCreateLabel(viaRep labelLayer list(x y) buffer "leftBottom" "R0" "stick" 2000)
  )
 
        dbSave(viaRep)
        dbClose(viaRep)
))
 

;***************************************************************
procedure(wpAebleWaferMap(drawRep)
prog((iX iY buf x y startllX mapList) 
;pd("wpAebleWaferMap" "")

; Draws a view of the aeblemap (generate the wafer map graphics)
printf("Creating wafer map graphics\n")

; This procedure goes and get specific information fom the OAT layout... not
; the PRIMARY layout. Keep this in mind because the OAT MUST EXIST!!!

wpCreatePhotoData()
if(optHam=="true" then
	wpViaWaferMap()
)
; add the wafer outline from the wafer library
wpPlaceOutline(drawRep -retOffsetXm:-retOffsetY)

; draw a box representing each complete reticle,
; also determine the iX,iY for the first complete reticle:
;;HHR
startllX = llCornerX

; change
;if(!evenp(startllX) then
;	startllX = startllX - 1
;)

nFullRets = 0
iY = llCornerY
while(iY<=urCornerY
	iX = startllX
  while(iX<=urCornerX
    if(isNavSite(iX iY) then
	if( processNav(iX iY) then
		bernCount = bernCount + 1
      		drawNavCross(iX iY drawRep)
	)
    else
	wpRelRect(drawRep reticleLayer (iX-.5*Xm)*retX+500 (iY-.5)*retY+500 retXm-1000 retYm-1000)
	if(isFullReticle(iX iY) then
		nFullRets = nFullRets + Xm
	else
		if(Xm==1 then
			if(isPartialRet(iX iY) then
				nPartRets = nPartRets + Xm
			)
		)
		if(Xm==2 then
			if(isPartialRet(iX iY) || isPartialRet(iX+1 iY) then
				nPartRets = nPartRets + Xm
			)
		)
	)
    )
   iX = iX + Xm
  ) ; for X
  iY = iY + Ym
) ; for Y

        if(waferSize == "4inch" then
                if(optHam=="true" then
			ultraYOffset = optRetOffYm + retYm / 2. - 202.0 
                else
                        ultraYOffset = retOffsetYm + retYm / 2. - 202.0
                )
        )

x = (urCornerXm + 1 ) * retXm
mapList = nil
sprintf( buf "Design Name= %s", libraryName)
mapList = append1( mapList buf )
sprintf( buf "retXm= %10.2f", retXm)
mapList = append1( mapList buf )
sprintf( buf "retYm= %10.2f", retYm)
mapList = append1( mapList buf )
sprintf( buf "Rows= %3d", ((urCornerYm-llCornerYm) +1) )
mapList = append1( mapList buf )
sprintf( buf "Mebus Cols= %3d", ((urCornerXm-llCornerXm) +1) )
mapList = append1( mapList buf )
sprintf( buf "Aeble Cols= %3d", AebleCols )
mapList = append1( mapList buf )
if(optHam=="true" then
sprintf( buf "retOffsetXm= %7.2f", optRetOffXm)
else
sprintf( buf "retOffsetXm= %7.2f", retOffsetXm)
)
mapList = append1( mapList buf )
if(optHam=="true" then
	sprintf( buf "retOffsetYm= %7.2f", optRetOffYm)
else
	sprintf( buf "retOffsetYm= %7.2f", retOffsetYm)
)
mapList = append1( mapList buf )
sprintf( buf "ultraYoffset= %7.2f", ultraYOffset)
mapList = append1( mapList buf )
	sprintf( buf "waferShiftX= %7.2f", waferShiftX)
	mapList = append1( mapList buf )
	sprintf( buf "waferShiftY= %7.2f", waferShiftY)
	mapList = append1( mapList buf )
 
if(waferSize == "4inch" then
  	sprintf( buf "oatFieldOffset1X= %7.2f", oatFieldOffset1X - (.5 * retXm))
  mapList = append1( mapList buf )

	sprintf( buf "oatFieldOffset1Y= %7.2f", oatFieldOffset1Y - (.5 * retYm))
  mapList = append1( mapList buf )

	sprintf( buf "oatFieldOffset2X= %7.2f", oatFieldOffset2X - (.5 * retXm))
  mapList = append1( mapList buf )

	sprintf( buf "oatFieldOffset2Y= %7.2f", oatFieldOffset2Y - (.5 * retYm))
  mapList = append1( mapList buf )

  	sprintf( buf "oatFieldOffset3X= %7.2f", oatFieldOffset3X - (.5 * retXm))
  mapList = append1( mapList buf )
  
	sprintf( buf "oatFieldOffset3Y= %7.2f", oatFieldOffset3Y - (.5 * retYm))
  mapList = append1( mapList buf )
  )
if( Xm != 1 || Ym != 1 then
  sprintf( buf "Xm= %3d", Xm)
  mapList = append1( mapList buf )
  sprintf( buf "Ym= %3d", Ym)
  mapList = append1( mapList buf )
  sprintf( buf "retX= %10.2f", retX)
  mapList = append1( mapList buf )
  sprintf( buf "retY= %10.2f", retY)
  mapList = append1( mapList buf )
if(optHam=="true" then
  sprintf( buf "retOffsetX= %7.2f", optRetOffXm)
else
  sprintf( buf "retOffsetX= %7.2f", retOffsetX)
)
  mapList = append1( mapList buf )
if(optHam=="true" then
  sprintf( buf "retOffsetY= %7.2f", optRetOffYm)
else
  sprintf( buf "retOffsetY= %7.2f", retOffsetY)
)
  mapList = append1( mapList buf )
  sprintf( buf "llCornerX= %3d", llCornerX)
  mapList = append1( mapList buf )
  sprintf( buf "llCornerY= %3d", llCornerY)
  mapList = append1( mapList buf )
  sprintf( buf "urCornerX= %3d", urCornerX)
  mapList = append1( mapList buf )
  sprintf( buf "urCornerY= %3d", urCornerY)
  mapList = append1( mapList buf )
  )
;add the new data created by wpCreatePhotoData
foreach(item photoList
 mapList = append1( mapList item )
)
 
 
; print out map list data
 
y = wafSize / 2.
foreach( buffer mapList
  y = y - 5000. * .5
  dbCreateLabel(drawRep labelLayer list(x y) buffer "leftBottom" "R0" "stick" 2000)
  )
))

;************************************************************************************
;Procedure to get specific details from the oat and print them onto the Aeble Map.
;This is called from wpAebleWaferMap()
procedure(wpCreatePhotoData()
prog( ()
photoList = nil
checkList = list( "ret_req_oat" "ret_req_ham_ab" "ret_req_ham"\
                  "ret_req_nav_aide" "ret_req_mini_oat" "ret_req_align_ll")
 
 
if(! (oatRep = dbOpenCellViewByType(libraryName oatDwg "layout" "maskLayout"))
  then
repToUse = reticleRep
  else
repToUse = oatRep
)

foreach(item repToUse~>instances
  case(item~>cellName
      ("ret_req_oat"
        x = item
        sprintf(photoData "ret_req_mesa_oatX= %10.3f", car(item~>xy))
        photoList = append1(photoList photoData)
        sprintf(photoData "ret_req_mesa_oatY= %10.3f", cadr(item~>xy))
        photoList = append1(photoList photoData)
      )
      ("ret_req/ham_ab"
        sprintf(photoData "ret_req_ham_abX= %10.3f", car(item~>xy))
        photoList = append1(photoList photoData)
      )
      ("ret_req/ham"
        sprintf(photoData "ret_req_ham= %10.3f", car(item~>xy))
        photoList = append1(photoList photoData)
      )
      ("ret_req/nav_aide"
        sprintf(photoData "ret_req_nav_aideX= %10.3f", car(item~>xy))
        photoList = append1(photoList photoData)
        sprintf(photoData "ret_req_nav_aideY= %10.3f", cadr(item~>xy))
        photoList = append1(photoList photoData)
      )
      ("ret_req/mini_oat"
        sprintf(photoData "ret_req_mini_oatX= %10.3f", car(item~>xy))
        photoList = append1(photoList photoData)
        sprintf(photoData "ret_req_mini_oatY= %10.3f", cadr(item~>xy))
        photoList = append1(photoList photoData)
      )
      ("ret_req/align_ll"
        sprintf(photoData "ret_req_align_llX= %10.3f", car(item~>xy))
        photoList = append1(photoList photoData)
        sprintf(photoData "ret_req_align_llY= %10.3f", cadr(item~>xy))
        photoList = append1(photoList photoData)
      )
  )
)
    sprintf( photoData "Date= %s",  getCurrentTime())
    photoList = append1( photoList photoData )
))

;************************************************************************************
procedure( findOatFieldOffsets()
  prog( (newNavList)

	newNavList = nil
	if(Xm==2 then
		newNavList = cons(car( navaidSites) newNavList)
		newNavList = cons(cadr(cdr( navaidSites)) newNavList)
		newNavList = cons(cadr(cdr(cddr( navaidSites))) newNavList)
		newNavList = reverse(newNavList)
	else
		newNavList = navaidSites
	)
	
        ; oatFieldOffset${i}X = retX * xCoord( field) + retOffsetX  Joan how do you
        ; build a variable name which is dependent on a another variable
        oatFieldOffset1X = retX * xCoord( car( newNavList)) + retOffsetXm
        oatFieldOffset1Y = retY * yCoord( car( newNavList)) + retOffsetY
        oatFieldOffset2X = retX * xCoord( cadr( newNavList)) + retOffsetXm
        oatFieldOffset2Y = retY * yCoord( cadr( newNavList)) + retOffsetY
        oatFieldOffset3X = retX * xCoord( caddr( newNavList)) + retOffsetXm
        oatFieldOffset3Y = retY * yCoord( caddr( newNavList)) + retOffsetY
  )
)
;*************************************************************************
procedure(wpDrawXyDie(drwRep)
prog((pX pY wX wY sId id startX2 stopX2) 

; Draws the boxes that define the xynumbers. Defaults to 3 different layers
; this will put a number on layer mesa for the default 3 xyDieLayers

;pd("drawXyDie" "")
println("drawing xy die")

wX = aRetXm * retXm
wY = aRetYm * retYm 
pX = (llCornerX - .5*Xm) * retX
if(Xm==2 then
	if(oddp(llCornerX) then
	pX = pX - retX
	)
)
id = 1
for(iX 1 nAdieXm
  pY = (llCornerY - .5) * retY
  for(iY 1 nAdieYm
    wpRelRect(drwRep xyDieLayer pX pY wX wY)
    sprintf(sId "%d" id)
    dbCreateLabel(drwRep labelLayer list(pX+1000  pY+1000) sId 
                  "leftBottom" "R0" "stick" retX*0.5)
	if( id==2 then
		startX2=pX
	)
	if( id==3 then
		stopX2=pX
	)
    pY = pY + aRetYm * retYm
    id = id + 1
    )
  pX = pX + aRetXm * retXm
  )
	AebleCols = round((stopX2 - startX2) / retXm)
))
;*********************************************************************
procedure(drawNavCross(iX iY drawRep)
  prog((x y)
;pd("drawNavCross" "")

; Draws a cross in the navaid/oat site
; change to oat cross

x = iX * retX
y = iY * retY  

	if(bernCount==3 then
		optRetOffXm = x + retOffsetXm
		optRetOffYm = y + retOffsetY
	)

;if(Xm==2 then
;      x = x + .5 * retX
;)

dbCreateLine(drawRep navaidLayer list(x+2000:y x-2000:y))
dbCreateLine(drawRep navaidLayer list(x:2000+y x:y-2000))

))
;********************************************************************
procedure(drawNavCross2(iX iY drawRep)
  prog((x y)
;pd("drawNavCross" "")
 
; Draws a cross in the navaid/oat site
; change to oat cross
 
x = iX * retX
y = iY * retY
 
dbCreateLine(drawRep navaidLayer list(x+2000:y x-2000:y))
dbCreateLine(drawRep navaidLayer list(x:2000+y x:y-2000))
 
))

;************************************************************************************
procedure(wpWafPlot(title dsName drawingRep portToUse)
prog((plotFileName)
;pd("wpWafPlot" "")
nil
/*
; Call to plotDFile to generate the mezger language plot file 

printf("Generating plot file.\n")

; set plotDFile values

titleDs = title
rot90Ds = nil
borderDs = nil
crossDs = nil
sprintf(plotFileName "%s/%s.waf" releasePath dsName)   
if(plotDFile(plotFileName drawingRep) then 
  fprintf(portToUse "Created plotD file:  %s\n" plotFileName)
  return(t)
else 
  fprintf(portToUse "Not able to create plotD file:  %s\n" plotFileName)
  return(nil)
  )
*/
return( nil)
))
;************************************************************************************
procedure(isFullReticle( iX iY)
  prog( ( xc yc)
;pd("isFullReticle" "")

; Checks to see if the whole reticle is on the wafe r within the outer ring
; check to see if the outer corner is on the wafer       

     xc = float( iX) * retX
     yc = float( iY) * retY
     if( xc + retOffsetX < 0. then
	xc = xc - .5 * retX )
     if( xc + retOffsetX > 0. then
	xc = xc + .5 * retX )
     if( yc + retOffsetY < 0. then
	yc = yc - .5 * retY )
     if( yc + retOffsetY > 0. then
	yc = yc + .5 * retY )
     return( isOnWafer( xc yc))
  )
)
;************************************************************************************
procedure(wpFindChips(listIn theRep)
prog(( chipCells chipNames chipPosn padPosn
	cell2 bBoxes lastCell cellPos 
	cell2Count padCellName maxXYnumX maxXYnumY)
;pd("wpFindChips" "")

; Creates a chip list based on the xynumbox
;	reticle data extraction:
;
;	wpFindChips
;	creates a list of all chips in a reticle
;	with the coordinates of the XY number pad (cell) within the chip cell
;	and the locations of all chip instances in the reticle:
;	( 
;         ( chipName
;           (padPosn padOrient chipOrient)
;           ( (chipPosn)
;             ...more positions of this chip, if any...
;	    )
;           chipBBox
;	  )
;	  ...more chips...
;	)
;   allocate array space for the chip names & coordinates:

        if(length(theRep~>instances)==0 then
		return(nil)
	)                             
cell1Count = length(theRep~>instances)
declare(chipNames[cell1Count])
declare(chipPosn[cell1Count])
declare(padPosn[cell1Count])
declare(bBoxes[cell1Count])

;   for each cell in the reticle, look to see if it is another
;   instance of a chip already considered and if so, save its position
;   else browse it and search for an xynumber pad;
;   if found, add chip to list and save its pad position as well:

lastCell = 0
foreach(cell1 theRep~>instances
  if(cell1~>type == "trueInst" then
    cellPos = 0
    if(lastCell != 0
      while(cellPos <= lastCell && cell1~>cellName != chipNames[cellPos]
        cellPos++
        )
      ) 
; test for match

    if(cellPos < lastCell then                                  ; match
      chipPosn[cellPos] = cons( cell1~>xy chipPosn[cellPos]) ; yes match
    else                                                     ; no match    
      sprintf(padCellName "%s" padDwg)
      chipCells = cell1~>master~>instances
      cell2Count = length(chipCells)
      cell2 = car(chipCells)
      cellPos = 0
      while(cellPos < cell2Count && cell2~>cellName != padCellName
        chipCells = cdr(chipCells)
        cell2 = car(chipCells)
        cellPos++
        )   
; test for a match

      if(cellPos < cell2Count then

; match -setup chipname when there is a match only-

        chipNames[lastCell] = cell1~>cellName
        padPosn[lastCell] = list(cell2~>xy cell2~>orient cell1~>orient)
        chipPosn[lastCell] = cons(cell1~>xy nil)
        bBoxes[lastCell] = cell1~>master~>bBox
        lastCell++
        )
      ) ; endif- cell1 match   
    ) ; endif-trueInst
  ) ; end foreach

; setup the chip list

maxXYnumX = 1
maxXYnumY = 1
; addition on March 3,2000
for(i 0 lastCell-1
        chipPosn[i] = wpXySort(chipPosn[i])
)
; end addition
for(i 0 lastCell-1
  listIn = cons(list(chipNames[i] padPosn[i] chipPosn[i] bBoxes[i])
                       listIn)
  wpXySort(chipPosn[i])
  if(maxX > maxXYnumX then 
    maxXYnumX = maxX
    )
  if(maxY > maxXYnumY then 
    maxXYnumY = maxY
    )
)
if(maxXYnumX * nRetXwaf > 100 || maxXYnumY * nRetYwaf > 100 then 
  nDigits = 3
  )
;printf("maxX= %d  maxY= %d  nRetX= %d  nRetY= %d\n" maxXYnumX maxXYnumY nRetXwaf nRetYwaf )
return(listIn)
))
;***************************************************************************
procedure(wpShowChips()
prog( (msg p b newChipList)
;pd("wpShowChips" "")

; Shows the user the above list in a simple fasion
newChipList=nil
foreach(chip oatChipList
        if(!member(car(chip) chipNames2) then
                newChipList=cons(chip newChipList)
        )
)
newChipList=append(chipList newChipList)
sprintf(msg "Found %d chip(s) containing number pad %s" 
            length(newChipList) padDwg)
hiDisplayAppDBox(?name 'zz 
                 ?dboxBanner "Click any button to continue." 
                 ?dboxText msg) 
printf("List of chips follows:\n")
foreach(chip chipList
  printf( "chip name: %s\n" car(chip))
  p = cadr( chip)
  b = car( cdddr( chip))
  printf( "pad  location:  %f,%f   orient: %s  chip orient: %s\n"
          xCoord(car(p)) yCoord(car(p)) cadr(p) caddr(p))
  printf( "bBox:  %f  %f  %f  %f\n" xCoord(lowerLeft(b))
          yCoord(lowerLeft(b)) xCoord(upperRight(b))
          yCoord(upperRight(b)))
  foreach(q caddr(chip)
    printf( "chip location:  %f  %f\n" xCoord(q) yCoord(q))
    )
  printf("******\n")
  )
))
;***************************************************************************
procedure(wpRelRect(rep layer pX pY wX wY)
;pd("wpRelRect" "")

; draw a relative rectangle - pX pY is the low left corner

dbCreateRect(rep layer list(pX:pY pX+wX:pY+wY))
)
;****************************************************************************
;HHR1
procedure(wpRelRect1(rep layer pX pY wX wY)
;pd("wpRelRect" "")

; draw a relative rectangle - pX pY is the low left corner

dbCreateRect(rep layer list(pX:pY wX:wY))
)
;************************************************************************************
procedure(isNavSite(iX iY)
  prog( ()
;pd("isNavSite" "")

; Checks to see if die is a navaid/oat.

    foreach( site navaidSites
      if( xCoord( site) == iX && yCoord( site) == iY then
	return( t)
      )
    )
    return( nil)
  )
)
;***********************************************************************
procedure(processNav(iX iY)
   prog((validList x y x0 y0 site site0)
 
        if(Xm==1 then
                if(isNavSite(iX iY) then
                        return(t)
                else
                        return(nil)
                )
        )
 
        validList = wpXySort(navaidSites)
        site = car(validList)
        x0 = xCoord(site)
        y0 = yCoord(site)
        validList = nil
        validList = cons(site validList)
 
        site0 = list(x0+1 y0)
        site = list(0 0)
        validList = cons(site validList)
        foreach(site wpXySort(navaidSites)
                x = xCoord(site)
                y = yCoord(site)
                if(x!=x0+1 || y!=y0 then
                if(!member(site validList) then
                        if(isNavSite(x+1 y) then
                                validList = cons(site validList)
                        )
                )
                )
        )
        site = list(iX iY)
        if(member(site validList) then
                return(t)
        else
                return(nil)
        )
))

;************************************************************************************
procedure(findNavSites()
  prog( ( navSite1 navSite2 navSite3)
;pd("findNavSites" "")

      if(waferSize == "4inch" then
	navaidSites = findNavSiteTwo()
       else      
        navSite1 = findNavSite(-1 1) 
        navSite2 = list( car(navSite1) -cadr(navSite1))
        navSite3 = list( -car(navSite1) -cadr(navSite1))   
        navaidSites = list( navSite1 navSite2 navSite3)    ; NORMAL 3 INCH
      )
  )
)
procedure( findNavSiteTwo()
  prog( ( x y iX iY navList)
; Finds the oat sites on the wafer for 4 inch
 
;pd("findNavSiteFour" "")
        iX = llCornerX
        iY = llCornerY
        iY = iY + Ym
    x = ( iX - .5) * retX
    y = ( iY - .5) * retY
;    printf( "Before IF iX = %n   iY = %n\n" iX iY)

; First find 1st box where left most point is on wafer 
; First point must be less than zero
        while( !isOnWafer( x y)
                iX = iX + 1
                x = ( iX - .5) * retX
		if(iX > urCornerX || iX >= 0 then
			iY = iY + Ym
			iX = llCornerX
			x = ( iX - .5) * retX
			y = ( iY - .5) * retY
		)
        )
; The following code checks for greater than zero again
; Commented out since not needed
/*        while(iX>=0 
                iY = iY + Ym
                y = ( iY - .5) * retY
                x = ( iX - .5) * retX
	     	while( isOnWafer( x y)
                        iX = iX - 1
                        x = ( iX - .5) * retX
                )
                iX = iX + 1
	)
*/
; The next part of code checks for Xm==2
        if(Xm==2 then
                while(!evenp(iX)
                        iX = iX + 1
                while(iX>=0
                        iY = iY + Ym
                        y = ( iY - .5) * retY
                        x = ( iX - .5) * retX
			while( isOnWafer( x y)
                                iX = iX - 1
                                x = ( iX - .5) * retX
                        )
                        iX = iX + 1
                )
                )
        )
 
        navList = list( list( iX  iY ))
 
        if(Xm==2 then
                navList = append( navList list( list( iX+1 iY)))
        )
 
        if(Ym==2 then
                navList = append( navList list( list( iX iY+1)))
        )

	; find rightmost box 
        x = ( iX + .5) * retX
        while( isOnWafer( x y)
                iX = iX + 1
                x = ( iX + .5) * retX
        )
        iX = iX - 1
 
        if(Xm==2 then
                iX = iX - 1
                if(!evenp(iX) then
                        iX = iX - 1
                )
                navList = append( navList list( list( iX iY)))
                navList = append( navList list( list( iX+1 iY)))
        )
 
        if(Xm!=2 then
                navList = append( navList list( list( iX iY)))
        )
        if(Ym==2 then
                navList = append( navList list( list( iX iY+1)))
        )
 
 
        navList = append( navList list( list( 0 0)))
 
        if(Xm==2 then
                navList = append( navList list( list( 1 0)))
        )
 
        return(navList)
))

;*************************************************************************
procedure( findNavSiteFour( dx dy)     
  prog( ( x y iX iY navList) 
; Finds the oat sites on the wafer for 4 inch

;pd("findNavSiteFour" "")
    x = .707 * wafSize * .5
    y = .707 * wafSize * .5
    iX = Xm * fix( x / retXm - .5 ) * dx 
    iY = Ym * fix( y / retYm - .5 ) * dy 
    x = ( iX + .5 * dx) * retX
    y = ( iY + .5 * dy) * retY
;    printf( "Before IF iX = %n   iY = %n\n" iX iY)

    if( ! isOnWafer( x y) then
      iY = iY - dy * Ym
      iX = iX + dx * Xm
      x = ( iX + .5 * dx) * retX
      y = ( iY + .5 * dy) * retY
;      printf( "After 1st IF iX = %n   iY = %n\n" iX iY)
      while( ! isOnWafer( x y)
        iX = iX - dx * Xm
        x = ( iX + .5 * dx) * retX
;        printf( "IN 1st while iX = %n   iY = %n\n" iX iY)
      )
    )
;	Find ll occurance of the navaid
    dy = - dy
    while( isOnWafer(x y)
        iY = iY + dy * Ym
	y = ( iY + .5 * dy) * retY
;	printf( "iX = %n   iY = %n\n" iX iY)
    )
    iY = iY - dy * Ym
    y = ( iY + .5 * dy) * retY

	if(iX >= -1 then
		iY = iY + dy * Ym
		y = ( iY + .5 * dy) * retY
		while( isOnWafer(x y)
			iX = iX + dx * Xm
			x = ( iX + .5 * dx) * retX
		)
		iX = iX - dx * Xm
		x = ( iX + .5 * dx) * retX	

	)

    navList = list( list( iX  iY ))
	if(Xm==2 then
		navList = append( navList list( list( iX+1 iY)))
	)
	if(Ym==2 then
                navList = append( navList list( list( iX iY+1)))
        )


    dx = - dx
	if(Xm==2 then
		iX = iX + 1
	)

;	Find lr occurance of the navaid
    while( isOnWafer(x y)
        iX = iX + dx * Xm
        x = ( iX + .5 * dx) * retX

    )
	iX = iX - dx * Xm
	if(Xm==1 then
    		navList = append( navList list( list( iX iY)))
	)
        if(Xm==2 then
                navList = append( navList list( list( iX-1 iY)))
                navList = append( navList list( list( iX iY)))
        )

        if(Ym==2 then
		navList = append( navList list( list( iX iY)))
                navList = append( navList list( list( iX iY+1)))
        )

	iX = iX + dx * Xm
    x = ( iX + .5 * dx) * retX
    dy = - dy
;	Find ur occurance of the navaid
    while( isOnWafer(x y)
        iY = iY + dy * Ym
	y = ( iY + .5 * dy) * retY
;	printf( "iX = %n   iY = %n\n" iX iY)
    )
    iY = iY - dy * Ym
    navList = append( navList list( list( iX iY)))
        if(Xm==2 then
                navList = append( navList list( list( iX iY)))
        )
        if(Ym==2 then
                navList = append( navList list( list( iX iY+1)))
        )

    return( navList)
  )
)
;************************************************************************************
procedure( findNavSite( dx dy)                          ;         |1 | / if the farthest xy
  prog( ( x y iX iY )                                   ;       __|__|/  point of the navaid
;                                                              | 2|3/|   in number 1 is off the
;       try to place the globals in incomplete                 |__|/_|   wafer try 2, then 3
;       reticle sites in the wafer corners:                       /
;                                                                /
;					the aspect ratio should point in the correct dir.
;					ex. if x/y > 1 then and not enough room in that
;
;						reticle then move up 1 in y and x.  
; Finds the navaid sites on the wafer

;pd("findNavSite" "")
    x = .707 * wafSize * .5
    y = .707 * wafSize * .5
    iX = fix( x / retXm) * dx 
    iY = fix( y / retYm) * dy + dy
    x = ( iX - .5 * dx) * retXm + retOffsetXm - retOffsetX + dx * navX
    y = ( iY - .5 * dy) * retYm + retOffsetYm - retOffsetY + dy * navY
    if( ! isOnWafer( x y) then
      iY = iY - dy
      iX = iX + dx
      x = ( iX - .5 * dx) * retXm + retOffsetXm - retOffsetX + dx * navX
      y = ( iY - .5 * dy) * retYm + retOffsetYm - retOffsetY + dy * navY
      if( ! isOnWafer( x y) then
        iX = iX - dx
      )
    )               
    iX = iX * Xm
    iY = iY * Ym
    return( list( iX iY))
  )
)
;************************************************************************************
procedure( beginLogFile()
  prog( ( b p)
;pd("beginLogFile" "")

; Logs the setting into the log file in the release dir

    fprintf( logPort "-----------------------------------------------\n")
    fprintf( logPort "wpNums Run %s\n\n" getCurrentTime())
    fprintf( logPort "Design Name:\t\t\t\t\t\t%s\n" libraryName)
    fprintf( logPort "Reticle Drawing Name:\t\t\t\t\t%s\n" retDwg)
    fprintf( logPort "Matrix Reticle Step/Repeat X (um)\t\t\t%10.2f\n" retXm)
    fprintf( logPort "Matrix Reticle Step/Repeat Y (um)\t\t\t%10.2f\n" retYm)
    fprintf( logPort "Matrix Reticles per XY Aeble Die, X\t\t\t%3d\n" aRetXm)
    fprintf( logPort "Matrix Reticles per XY Aeble Die, Y\t\t\t%3d\n" aRetYm)
    fprintf( logPort "Matrix XY Aeble Die per Wafer, X\t\t\t%3d\n" nAdieXm)
    fprintf( logPort "Matrix XY Aeble Die per Wafer, Y\t\t\t%3d\n" nAdieYm)
    fprintf( logPort "Matrix Lower Left Corner offset, X\t\t\t%3d\n" llCornerXm)
    fprintf( logPort "Matrix Lower Left Corner offset, Y\t\t\t%3d\n" llCornerYm)
    fprintf( logPort "Matrix Upper Right Corner offset, X\t\t\t%3d\n" urCornerXm)
    fprintf( logPort "Matrix Upper Right Corner offset, Y\t\t\t%3d\n" urCornerYm)
    fprintf( logPort "Matrix Reticle offset from center, X\t\t\t%10.2f\n" retOffsetXm)
    fprintf( logPort "Matrix Reticle offset from center, Y\t\t\t%10.2f\n" retOffsetYm)
    if(waferSize == "4inch" then
     fprintf( logPort "Oat Field 1 Offset from center of wafer, X\t\t%10.2f\n" oatFieldOffset1X)
     fprintf( logPort "Oat Field 1 Offset from center of wafer, Y\t\t%10.2f\n" oatFieldOffset1Y)
     fprintf( logPort "Oat Field 2 Offset from center of wafer, X\t\t%10.2f\n" oatFieldOffset2X)
     fprintf( logPort "Oat Field 2 Offset from center of wafer, Y\t\t%10.2f\n" oatFieldOffset2Y)
     fprintf( logPort "Oat Field 3 Offset from center of wafer, X\t\t%10.2f\n" oatFieldOffset3X)
     fprintf( logPort "Oat Field 3 Offset from center of wafer, Y\t\t%10.2f\n" oatFieldOffset3Y)
    )
    if( Xm != 1 || Ym != 1 then
     fprintf( logPort "X dimension of matrix, X\t\t\t\t%3d\n" Xm)
     fprintf( logPort "Y dimension of matrix, Y\t\t\t\t%3d\n" Ym)
     fprintf( logPort "Test Block Step/Repeat X (um)\t\t\t\t%10.2f\n" retX)
     fprintf( logPort "Test Block Step/Repeat Y (um)\t\t\t\t%10.2f\n" retY)
     fprintf( logPort "Test Blocks per XY Aeble Die, X\t\t\t\t%3d\n" aRetX)
     fprintf( logPort "Test Blocks per XY Aeble Die, Y\t\t\t\t%3d\n" aRetY)
     fprintf( logPort "Test Block Lower Left Corner offset, X\t\t\t%3d\n" llCornerX)
     fprintf( logPort "Test Block Lower Left Corner offset, Y\t\t\t%3d\n" llCornerY)
     fprintf( logPort "Test Block Upper Right Corner offset, X\t\t\t%3d\n" urCornerX)
     fprintf( logPort "Test Block Upper Right Corner offset, Y\t\t\t%3d\n" urCornerY)
     fprintf( logPort "Test Block offset from center (navaid/oat dropout), X\t%10.2f\n" retOffsetX)
     fprintf( logPort "Test Block offset from center (navaid/oat dropout), Y\t%10.2f\n" retOffsetY)
    )

    fprintf( logPort "\nDrop-in Locations:\n")
    foreach( site plugSites
      fprintf( logPort "(%d %d)  " xCoord( site) yCoord( site))
    )
    fprintf( logPort "\nNavaid Locations:\n")
    foreach( site navaidSites
      fprintf( logPort "(%d %d)  " xCoord( site) yCoord( site))
    )
    fprintf( logPort "\n")

    fprintf( logPort "\nReticle Contains %d chips with Number Pad %s:\n" 
             length( chipList) padDwg)
    foreach( chip chipList
      fprintf( logPort "\nChip Cell Name:  %s\n" car( chip))
      p = cadr( chip)
      b = car( cdddr( chip))
      fprintf( logPort "Chip Orientation in Reticle:  %s\n" caddr( p))
      fprintf( logPort "Pad  Location:  %10.2f,%10.2f  Orientation: %s\n"
               xCoord(car(p)) yCoord(car(p)) cadr(p))
      fprintf( logPort "Chip Dimensions (with grid):  %10.2f    X %10.2f\n"
               xCoord( upperRight( b)) - xCoord( lowerLeft( b)) 
               yCoord( upperRight( b)) - yCoord( lowerLeft( b))) 
      fprintf( logPort "Chip Locations in Reticle:\n") 
      foreach( q caddr( chip)
        fprintf( logPort "   %10.2f  %10.2f\n" xCoord(q) yCoord(q))
      )
      fprintf( logPort "\n")
    )
  )
)
procedure( diffX( sites)
  prog( ( deltaX item1 list1 x1 x2)
	deltaX = 0 
	list1=sites
	item1=car(list1)
	x1=car(item1)
	list1=cdr(list1)
	item1=car(list1)
	x2 = car(item1)
	deltaX = x2 - x1
	return(abs(deltaX))
))
procedure( diffY( sites)
  prog( ( deltaY item1 list1 y1 y2) 
        deltaY = 0 
        list1=sites
        item1=car(list1)
        y1=cadr(item1)
        list1=cdr(list1)
	item1=car(list1)
	y2 = cadr(item1)
        deltaY = y2 - y1
        return(abs(deltaY))
))
procedure( diffX2( sites)
  prog( ( deltaX item1 list1 x1 x2)
        deltaX = 0
        list1=sites
        item1=car(list1)
        x1=car(item1)
	list1=cdr(list1)

	while(list1 != nil
        item1=car(list1)
        x2 = car(item1)
        deltaX = x2 - x1
	if(abs(deltaX)>0 then
        	return(abs(deltaX))
	)
	list1=cdr(list1)
	)
	return(0)
))
procedure( diffY2( sites)
  prog( ( deltaY item1 list1 y1 y2)
        deltaY = 0
        list1=sites
        item1=car(list1)
        y1=cadr(item1)

	list1=cdr(list1)
	while(list1 != nil
        item1=car(list1)
        y2 = cadr(item1)
        deltaY = y2 - y1
	if(abs(deltaY)>0 then
                return(abs(deltaY))
        )
	list1=cdr(list1)
        )
	return(0)
))

;************************************************************
; The following procedure will return a list of chipSites
; with the number of moves as the first element 
procedure(wpGetChipSites(aChipList chipName)
  prog((listOne listItem sites nMoves)
        listOne = aChipList;
        listItem = car(listOne)
        while( car(listItem) != chipName
                listOne=cdr(listOne)
                listItem=car(listOne)
        )
        sites = wpXySort( caddr( listItem))
        nMoves = length( caddr( listItem)) - 1
        sites = cons(nMoves sites)
        return(sites)
))

;***************************************************************
procedure( keithLoop2( port chipData doParts port2 oatFlag port3)
  prog( ( flip fact nDie iX sites nX nY
           chipName deltaX deltaY nX2 nY2 nX3 nY3
                dBox posSites negSites nX4 dsites)
;pd("keithLoop2" "")
 
; keithLoop2 handles chips that are in an irregular pattern
; in a reticle that also contains one or more other chip types.
 
    nEdgeChips = 0
;    nPartRets = 0
    sites = wpXySort( caddr( chipData))
    dBox = cadddr( chipData)
    nX = maxX
    nY = maxY
    nX2 = nX
    nY2 = nY
    nX3 = nX
    nY3 = nY
 
        chipName = car( chipData)
         if(member(chipName oatNames) then
                dsites = wpGetChipSites(oatChipList chipName)
                nX2 = maxX
                nY2 = maxY
                nX4 = length(negOatList(cdr(dsites)))
        )
 
        sites = wpXySort( caddr( chipData))
        deltaX = diffX( dBox)
        deltaY = diffY( dBox)
    fprintf( port "*  Die Loc. / Aeble Numbers\n")
    flip = nil
    fact = 1
    nDie = 0
 
    for( iY llCornerY urCornerY
      if( flip then
        iX = urCornerX
        else iX = llCornerX
       )
      while( iX >= llCornerX && iX <= urCornerX
;The following code was commented out so that all sites were probed. H2R3
        nX = nX3
        nY = nY3
        chipName = car( chipData)
        if( isNavSite( iX iY) then
        if(processNav( iX iY) then
         if(member(chipName oatNames) then
                sites = wpGetChipSites(oatChipList chipName)
                nMoves = car(sites)
                sites = cdr(sites)
         else
                sites = nil
                nMoves = 0
         )
         else
		sites = nil
               	nMoves = 0
        )
        )

        if( !isNavSite( iX iY) then
                sites = wpXySort( caddr( chipData))
                nMoves = length( caddr( chipData)) - 1
        )
        couponChip = nil
        if(isCouponChip(car(chipData)) || isNCouponChip(car(chipData)) then
            couponChip = t
        )
 
        ;println(deltaX);

        posSites = nil
        negSites = nil

        if( sites != nil then
	    if(isNavSite( iX iY) && processNav(iX iY)  then
                if(Xm==1 && Ym==1 then
		if(isFullReticle( iX iY) then
doFullRet3(iX iY nX nY sites port couponChip deltaX deltaY nX2 nY2 port2 nX4 chipName)
		nDie = nDie + 1
		else
if(doPartRet3(chipData iX iY nX nY sites port couponChip deltaX deltaY nX2 nY2 port2 nX4 port3 chipName) then
		nDie = nDie + 1
)
		)
		) ; Xm==1

		if(Xm==2 && processNav( iX iY)  then
                posSites = posOatList(sites)
                negSites = negOatList(sites)
		if(posSites!=nil then
			nDie = nDie + 1
		)
		if(negSites!=nil then
                        nDie = nDie + 1
                )
		if(isFullReticle( iX iY) then
		nMoves = length(negSites)-1
doFullRet3(iX iY nX nY negSites port couponChip deltaX deltaY nX2 nY2 port2 nX4 chipName)
		else
		nMoves = length(negSites)
doPartRet3(chipData iX iY nX nY negSites port couponChip deltaX deltaY nX2 nY2 port2 nX4 port3 chipName) 

		) ; isFullReticle
		
		if(isFullReticle( iX+1 iY) then
		nMoves = length(posSites)-1
doFullRet3(iX+1 iY nX nY posSites port couponChip deltaX deltaY nX2 nY2 port2 nX4 chipName)
		else
		nMoves = length(posSites)
doPartRet3(chipData iX+1 iY nX nY posSites port couponChip deltaX deltaY nX2 nY2 port2 nX4 port3 chipName) 

		)
		
		)
	)
	if(!isNavSite(iX iY) && isFullReticle(iX iY) then
		if(oatFlag!=0 then
doFullRet3(iX iY nX nY sites port couponChip deltaX deltaY nX2 nY2 port2 nX4 chipName)
		nDie = nDie + 1
		)
	)
	if(!isNavSite(iX iY) && !isFullReticle(iX iY) then
if(doPartRet3(chipData iX iY nX nY sites port couponChip deltaX deltaY nX2 nY2 port2 nX4 port3 chipName) then
		nDie = nDie + 1
		)
        )
	)
        iX = iX + fact
      )
      if( nDie > 0 then flip = ! flip fact = -1 * fact )
    )
    return( list( nDie nX3 nY3))
  )
)
procedure(doOatRet(port listSite sites nX nY x y deltaX deltaY)
   prog(( dummyX dummyY numX numY sites2 numY2 nMoves iX iY
	numY3 x2 y2 startX startY lineList line1 deltaX2 deltaY2
	finY lineString site)

	sites = wpXySort(sites)
	startX = x
	startY = y		

; addition March 3,2000
startX = xCoord(car(caddr(car(chipList))))
startY = yCoord(car(caddr(car(chipList))))
; end of addition

    foreach(site2 listSite
	iX = xCoord(site2) - llCornerX
	iY = yCoord(site2) - llCornerY
	listEdges = cons(list(iX iY) listEdges)

	numX = iX * nX
	numY = iY * nY
	numY2 = numY + nY - 1
	numY3 = numY
	site = car(sites)
	lineList = nil

	deltaX2 = xCoord(site)-startX
	deltaY2 = yCoord(site)-startY
	deltaX2 = fix(deltaX2)
	deltaY2 = fix(deltaY2)
	finY = startY + (nY-1)*deltaY

	
	if(deltaX2!=0 || deltaY2 != 0 then
		line1 = sprintf(nil "%d %d %d %d" iX iY numX numY)
		sites2 = cdr(sites)
		numY++
		deltaY2 = deltaY2 - deltaY
		while(deltaY2>0
lineString = sprintf(nil "%d %d %f %f\n" numX numY 0.0 deltaY/1000.0)
		lineList = cons(lineString lineList)
		deltaY2 = deltaY2 - deltaY
		numY++
		)
 		x = xCoord(site)
		y = yCoord(site)
	else
	        line1 = nil
                sites2 = sites
                x = startX
                y = startY
	)
	x2 = x	
	y2 = y 
    foreach( site sites2
        dummyX = xCoord(site) - x
        dummyY = yCoord(site) - y
	x = xCoord(site)
	y = yCoord(site)

        if(dummyX > 0 then
               numX++
        )
        if(dummyY > 0 then
                numY++
		dummyY = dummyY - deltaY
        )
 
        if( dummyX > 0 then
	if(y2!=finY && numY<numY2 then
                while(numY<numY2
			numY++
			if(x-x2 > deltaX then
lineString = sprintf(nil " %f %f %d %d\n" (x-x2-deltaX)/1000.0 deltaY/1000.0 numX-1 numY)
               		x2 = x 
			else
lineString = sprintf(nil " %f %f %d %d\n" 0.0 deltaY/1000.0 numX-1 numY)
			)	
			lineList = cons(lineString lineList)
			dummyY = dummyY - deltaY	
		)
	)
	numY = numY3
	)

	if(dummyY > 0 then
		while(dummyY > 0
			if(x==x2 then
lineString = sprintf(nil " %f %f %d %d\n" 0.0 deltaY/1000.0 numX numY)
			else
lineString = sprintf(nil " %f %f %d %d\n" (x-x2)/1000.0 deltaY/1000.0 numX numY)
			x2=x	
			)
			lineList = cons(lineString lineList)
			dummyY = dummyY - deltaY
			numY++
		)
	)
	x2 = x
	y2 = y
	)
        while(numY<numY2
		numY++
lineString = sprintf(nil " %f %f %d %d\n" 0.0 deltaY/1000.0 numX numY)
                lineList = cons(lineString lineList)
        )

; end foreach loop
	nMoves = length(lineList)
	if(line1==nil then
		fprintf(port "%d %d 0 0 %d\n" iX iY nMoves)
	else
		fprintf(port "%s %d\n" line1 nMoves)
	)
	lineList = reverse(lineList)
	foreach(lineString lineList
		fprintf(port "%s" lineString)
	)

	)
;end foreach loop
))
procedure( keithLoop3( port chipData)
  prog(( site sites couponChip negSites posSites nX nY negList
	chipName posList siteX siteY negList posList x y dBox deltaX deltaY )

	if(oatChipList==nil then
		return()
	)
	sites = nil
	foreach(chip oatChipList
		site = caddr(chip)
		chipName = car(chip)
		couponChip = isCouponChip(chipName)
                if(couponChip==nil then
                        couponChip = isNCouponChip(chipName)
                        if(couponChip==nil then
                        dBox = cadddr(chip)
                        sites = append(sites site)
                        )
                )
	)

	if(Xm==2 then
	deltaX = diffX(dBox)
	deltaY = diffY(dBox)
        negSites = negOatList(sites)
	posSites = posOatList(sites)

    	nX = car(GetNxy())
    	nY = cadr(GetNxy())


        negList = nil
        posList = nil
        foreach(site navaidSites
                siteX = xCoord(site)
                siteY = yCoord(site)
                if(!member(list(siteX-1 siteY) navaidSites) then
                        negList = cons(site negList)
                else
                        posList = cons(site posList)
                )
        )

	negSites = wpXySort(negSites)
	posSites = wpXySort(posSites)
	x = xCoord(car(oatRep~>bBox)) 
        y = yCoord(car(oatRep~>bBox))
	doOatRet(port negList negSites nX nY x y deltaX deltaY)
	x = xCoord(car(posSites))
        y = yCoord(car(oatRep~>bBox))
	doOatRet(port posList posSites nX nY x y deltaX deltaY)
	)

	if(Xm==1 then
	deltaX = diffX(dBox)
        deltaY = diffY(dBox)
	sites = wpXySort(sites) 
        nX = car(GetNxy())
        nY = cadr(GetNxy())
 
	x = xCoord(car(oatRep~>bBox))
        y = yCoord(car(oatRep~>bBox))

	doOatRet(port navaidSites sites nX nY x y deltaX deltaY)
        )

  )
)
procedure( doFullRet(iX iY nX nY sites port couponChip deltaX deltaY nX2 nY2 
	port2 nX4 chipName)
prog((  numX numY numY2 x y x0 y0 xDie yDie
        nMoves there sites2 listSites initialXY listChips)
        if(sites == nil then
                return(nil)
        )
        nMoves = length(sites)-1
    	xDie = iX - llCornerX
    	yDie = iY - llCornerY
        ;deltaX=deltaX*Xm
        sites=wpXySort(sites)

        sites2 = nil
        listSites = nil
        if(isNavSite(iX iY) then
                listChips = oatChipList
                listSites = nil
                foreach(chip listChips
                        sites2 = caddr(chip)
                        listSites = append(listSites sites2)
                )
	; rev 5_12_98
                if(Xm==2 then
		if(processNav(iX iY) then
                        listSites = negOatList(listSites)
                else
			listSites = posOatList(listSites)
		)
                )
        else
        listChips = chipList
        foreach(chip listChips
                sites2 = caddr(chip)
                listSites = append(listSites sites2)
        )
	)

	listSites = wpXySort(listSites)
;	x0 = xCoord( car(listSites))
;	y0 = yCoord( car(listSites)) 

	initialXY = GetInitial(chipName iX iY)
 
        x0 = car(initialXY)
        y0 = cadr(initialXY)	        
        x = xCoord( car( sites))
        y = yCoord( car(sites))
        numX = car(GetNumXY(chipName iX iY x y))
        numY = cadr(GetNumXY(chipName iX iY x y))
        numY2 = numY
; revision 5_11_98
        there = nil
        there = isThere(chipName iX iY sites)
        if(!there then
                fprintf( port "%d %d 0 0 %d\n" xDie yDie nMoves+1)
                fprintf( port2 "0 0\n" )
        else
                fprintf( port "%d %d %d %d %d\n" xDie yDie numX numY2 nMoves)
                fprintf( port2 "%d %d \n" numX numY2)
		sites = cdr(sites)
        )


        if(!isNavSite(iX iY) then
                drawDieBox2(iX iY 1 1 numX numY2)
        )
        if(isNavSite(iX iY)&& Xm==2 then
                if(processNav(iX iY) then
		; lahey
		numX = car(GetNumXY(chipName iX iY x y))
		numX = numX + maxX/2
		drawDieBox2(iX+1 iY 1 1 numX numY2)
                )
        )
 
 
    foreach( site sites
      x = xCoord(site)
      y = yCoord(site)
	numX = car(GetNumXY(chipName iX iY x y))
        numY = cadr(GetNumXY(chipName iX iY x y))
        numY2 = numY
        fprintf( port " %f %f %d %d\n" (x-x0)*1.e-3 (y-y0)*1.e-3 numX numY2)
        fprintf( port2 "%d %d\n" numX numY2)
      x0 = x
      y0 = y
    )
  )
)

procedure( doFullRet2(iX iY nX nY sites port couponChip deltaX deltaY nX2 nY2 port2 nX4 chipName)
prog(( numX numY numY2 x y x0 y0 xDie yDie
       there nMoves oatSites listChips sites2 dOffsetX dOffsetY)
;pd("doFullRet" "")

        oatSites = nil
        listChips = oatChipList
        foreach(chip listChips
                sites2 = caddr(chip)
                oatSites = append(oatSites sites2)
        )
        oatSites = wpXySort(oatSites)

	if(sites == nil then
		return(nil)
	)
	nMoves = length(sites)-1
    xDie = iX - llCornerX
    yDie = iY - llCornerY
	;deltaX=deltaX*Xm
	sites=wpXySort(sites)


	if(isNavSite(iX iY) then
		if(processNav(iX iY) then
        	x0 = caar(oatRep~>bBox)
		y0 = cadar(oatRep~>bBox)
		else
		x0 = xCoord(car(wpXySort(posOatList(oatSites))))
		y0 = cadar(oatRep~>bBox)
		x = xCoord( car( sites))
        	y = yCoord( car(sites))
		)
	else
		x0 = caar(reticleRep~>bBox)  
		y0 = cadar(reticleRep~>bBox)
	)
	x = xCoord( car( sites))
	y = yCoord( car(sites))

	numX = car(GetNumXY(chipName iX iY x y))
	numY = cadr(GetNumXY(chipName iX iY x y))
	numY2 = numY
	there = nil
        there = isThere(chipName iX iY sites)
	if(!there then
		fprintf( port "%d %d 0 0 %d\n" xDie yDie nMoves+1)
        	fprintf( port2 "0 0\n" )
	else
      		fprintf( port "%d %d %d %d %d\n" xDie yDie numX numY2 nMoves)
		fprintf( port2 "%d %d \n" numX numY2)
	)
	if(!isNavSite(iX iY) then 
    		drawDieBox2(iX iY 1 1 numX numY2)
	)
	if(isNavSite(iX iY)&& Xm==2 then 
		if(processNav(iX iY) then
		numX = numX + 1 + maxX
		drawDieBox2(iX+1 iY 1 1 numX numY2)
		)	
	)

	dOffsetX = car(GetOff(listChips))
	dOffsetY = cadr(GetOff(listChips))

if(!there then
	x = xCoord( car( sites))
	y = yCoord( car( sites))
       	fprintf( port " %f %f %d %d\n" (x-x0-dOffsetX)*1.e-3 (y-y0-dOffsetY)*1.e-3 numX numY2)
       	fprintf( port2 "%d %d\n" numX numY2)
)

    x1 = numX
    y1 = numY
    x = xCoord( car( sites))
    y = yCoord( car( sites))
	x0 = x
	y0 = y

    foreach( site cdr( sites)
      x = xCoord(site)
      y = yCoord(site)
      numX = car(GetNumXY(chipName iX iY x y))
      numY = cadr(GetNumXY(chipName iX iY x y))
      numY2 = numY
         fprintf( port " %f %f %d %d\n" (x-x0)*1.e-3 (y-y0)*1.e-3 numX numY2)
	fprintf( port2 "%d %d\n" numX numY2)
      x0 = x
      y0 = y
    )
  )
)
procedure( doFullRet4(iX iY nX nY sites port couponChip deltaX deltaY nX2 nY2
        port2 nX4 chipName)
prog(( numX numY numY2 x y x0 y0 xDie yDie
       nMoves)
        if(sites == nil then
                return(nil)
        )
        nMoves = length(sites)-1
        xDie = iX - llCornerX
        yDie = iY - llCornerY
        ;deltaX=deltaX*Xm
        sites=wpXySort(sites)
 
        x0 = xCoord( car( sites))
        y0 = yCoord( car(sites))
 
        x = xCoord( car( sites))
        y = yCoord( car(sites))
 
        numX = car(GetNumXY(chipName iX iY x y))
        numY = cadr(GetNumXY(chipName iX iY x y))
        numY2 = numY
        fprintf( port "%d %d %d %d %d\n" xDie yDie numX numY2 nMoves)
        fprintf( port2 "%d %d \n" numX numY2)
 
        if(!isNavSite(iX iY) then
                drawDieBox2(iX iY 1 1 numX numY2)
        )
        if(isNavSite(iX iY)&& Xm==2 then
                if(processNav(iX iY) then
                numX = numX + 1 + maxX
                drawDieBox2(iX+1 iY 1 1 numX numY2)
                )
        )
 
 
    foreach( site cdr( sites)
      x = xCoord(site)
      y = yCoord(site)
        numX = car(GetNumXY(chipName iX iY x y))
        numY = cadr(GetNumXY(chipName iX iY x y))
        numY2 = numY
        fprintf( port " %f %f %d %d\n" (x-x0)*1.e-3 (y-y0)*1.e-3 numX numY2)
        fprintf( port2 "%d %d\n" numX numY2)
      x0 = x
      y0 = y
    )
  )
)

procedure( doFullRet3(iX iY nX nY sites port couponChip deltaX deltaY nX2 nY2 
	port2 nX4 chipName)
prog(()

	if(sites==nil then
		return()
	)
	if(!couponChip then
	if(retType=="true" then
	doFullRet2(iX iY nX nY sites port couponChip deltaX deltaY nX2 nY2 port2 nX4 chipName)
 	else
	doFullRet( iX iY nX nY sites port couponChip deltaX deltaY nX2 nY2 port2 nX4 chipName)
	)
	)

	if(couponChip then
	doFullRet4(iX iY nX nY sites port couponChip deltaX deltaY nX2 nY2 port2 nX4 chipName)
	)
))

procedure( doPartRet(chipData iX iY nX nY sites port couponChip deltaX deltaY
        nX2 nY2 port2 nX4 port3 chipName)
prog((  numX numY numX2 numY2 x y x0 y0 xDie yDie
        there ox oy box listIn listOut xSize ySize site sites2 xc yc
        nIntra2 there2 nMoves oatSites dOffsetX dOffsetY listChips)
 

        oatSites = nil
        listChips = oatChipList
        foreach(chip listChips
                sites2 = caddr(chip)
                oatSites = append(oatSites sites2)
        )
        oatSites = wpXySort(oatSites)
 
 
        doPartialRet( iX iY nX nY chipData sites couponChip)
 
        if(sites == nil then
                return(nil)
        )
 
    xDie = iX - llCornerX
    yDie = iY - llCornerY
        ;deltaX=deltaX*Xm
        sites=wpXySort(sites)
        nMoves = length(sites)-1
        if(isNavSite(iX iY) then
                if(processNav(iX iY) then
                x0 = caar(oatRep~>bBox)
                y0 = cadar(oatRep~>bBox)
                else
                x0 = xCoord(car(wpXySort(posOatList(oatSites))))
                y0 = cadar(oatRep~>bBox)
                )
	else
        x0 = caar(reticleRep~>bBox)
        y0 = cadar(reticleRep~>bBox)
	)
        x = xCoord( car( sites))
        y = yCoord( car(sites))
 
        numX = car(GetNumXY(chipName iX iY x y))
        numY = cadr(GetNumXY(chipName iX iY x y))
        numX2 = numX
        numY2 = numY
        xSize = diffX2(cadr(cddr(chipData)))
        ySize = diffY2(cadr(cddr(chipData)))
        listIn = nil
        listOut = nil
        ox = float(iX) * retX
        oy = float(iY) * retY
    foreach( site sites
        box = chipBBox(chipData site)
        xc = ox + xCoord(site)
        yc = oy + yCoord(site)
        if(chipOnWafer(xc yc xSize ySize) then
                listIn = cons(site listIn)
        else
		if(parPort!=nil then
		if(chipOnWafer3(xc yc xSize ySize) then
			fprintf(parPort "%f %f\n" xCoord(site) yCoord(site))
		)
		)
                if(chipOnWafer2(xc yc xSize ySize) then
                        listOut = cons(site listOut)
                )
        )
    )
        nEdgeChips = nEdgeChips + length(listIn)
        nMoves = length(listIn)-1
        nIntra2 = length(listOut)-1
	there = nil
	there = isThere(chipName iX iY sites)
 
        site = car(sites)
        if(listIn!=nil then
        if(!there then
                fprintf( port "%d %d 0 0 %d\n" xDie yDie nMoves+1)
                fprintf( port2 "0 0\n" )
        else
                if(member(site listIn) then
                fprintf( port "%d %d %d %d %d\n" xDie yDie numX2 numY2 nMoves)
                fprintf( port2 "%d %d \n" numX2 numY2)
                else
                fprintf( port "%d %d 0 0 %d\n" xDie yDie nMoves+1)
                fprintf( port2 "0 0\n" )
                )
        )
        )
 
dOffsetX = car(GetOff(listChips))
dOffsetY = cadr(GetOff(listChips)) 
if(listIn!=nil then
if(!there then
        x = xCoord( car( sites))
        y = yCoord( car( sites))
        fprintf( port " %f %f %d %d\n" (x-x0-dOffsetX)*1.e-3 (y-y0-dOffsetY)*1.e-3 numX2 numY2)
        fprintf( port2 "%d %d\n" numX2 numY2)
)
    x1 = numX
    y1 = numY
    x = xCoord( car( sites))
    y = yCoord( car( sites))
        x0 = x
        y0 = y
 
    foreach( site cdr( sites)
        if(member(site listIn) then
      x = xCoord(site)
      y = yCoord(site)
	numX = car(GetNumXY(chipName iX iY x y))
       	numY = cadr(GetNumXY(chipName iX iY x y))
 
         fprintf( port " %f %f %d %d\n" (x-x0)*1.e-3 (y-y0)*1.e-3 numX numY)
        fprintf( port2 "%d %d\n" numX numY)
      x0 = x
      y0 = y
    ))
)
    x1 = numX
    y1 = numY
    x = xCoord( car( sites))
    y = yCoord( car( sites))
        x0 = x
        y0 = y
 
 
        if(listOut!=nil then
        listEdges = cons(list(xDie yDie) listEdges)
        else
        if(isPartialRet(iX iY) then
                fprintf(port3 "%d %d 0 0 0\n" xDie yDie)
        )
	if(listIn==nil then
		return(nil)
	else
		return(t)
	)
        )
 
        there2 = nil
    foreach( site sites
        if(there2==nil then
                if(member(site listOut) then
 
                fprintf( port3 "%d %d %d %d %d\n" xDie yDie numX2 numY2 nIntra2)
                else
                fprintf( port3 "%d %d 0 0 %d\n" xDie yDie nIntra2+1)
                )
                there2 = t
                nDie2 = nDie2 + 1
                x = xCoord(site)
                y = yCoord(site)
        else
        if(member(site listOut) then
                x = xCoord(site)
                y = yCoord(site)
         numX = car(GetNumXY(chipName iX iY x y))
         numY = cadr(GetNumXY(chipName iX iY x y))
         fprintf( port3 " %f %f %d %d\n" (x-x0)*1.e-3 (y-y0)*1.e-3 numX numY)
                x0 = x
                y0 = y
        )
    ))
        if(listIn==nil then
                return(nil)
        else
                return(t)
        )
  )
)
procedure( doPartRet2(chipData iX iY nX nY sites port couponChip deltaX deltaY
        nX2 nY2 port2 nX4 port3 chipName)
prog((  numX numY numX2 numY2 x y x0 y0 xDie yDie
        there ox oy box listIn listOut xSize ySize site xc yc
        nIntra2 there2 nMoves pdsites initialXY xInitial yInitial)
 
 
        doPartialRet( iX iY nX nY chipData sites couponChip)

	initialXY = GetInitial(chipName iX iY)
	
	xInitial = car(initialXY)
	yInitial = cadr(initialXY)
 
        if(sites == nil then
                return(nil)
        )
 
    xDie = iX - llCornerX
    yDie = iY - llCornerY
        ;deltaX=deltaX*Xm
        sites=wpXySort(sites)
        nMoves = length(sites)-1
        x = xCoord( car(sites))
        y = yCoord( car(sites))
	x0 = x
	y0 = y 
                numX = car(GetNumXY(chipName iX iY x y))
                numY = cadr(GetNumXY(chipName iX iY x y))
        numX2 = numX
        numY2 = numY
        xSize = diffX2(cadr(cddr(chipData)))
        ySize = diffY2(cadr(cddr(chipData)))
        listIn = nil
        listOut = nil
        ox = float(iX) * retX
        oy = float(iY) * retY
    foreach( site sites
        box = chipBBox(chipData site)
        xc = ox + xCoord(site)
        yc = oy + yCoord(site)
        if(chipOnWafer(xc yc xSize ySize) then
                listIn = cons(site listIn)
        else
                if(chipOnWafer2(xc yc xSize ySize) then
                        listOut = cons(site listOut)
                )
        )
    )
        nEdgeChips = nEdgeChips + length(listIn)
        nMoves = length(listIn)-1
        nIntra2 = length(listOut)-1
	xc = ox + xCoord(car(sites))
	yc = oy + yCoord(car(sites))

	if(chipOnWafer(xc yc xSize ySize) then
		if(!couponChip then
			if(isThere(chipName iX iY sites) then
				there = t
			else
				there = nil
			)
		else
			there = t
		)
	else
		there = nil
	)
 
        site = car(sites)
        if(listIn!=nil then
        if(!there then
                fprintf( port "%d %d 0 0 %d\n" xDie yDie nMoves+1)
                fprintf( port2 "0 0\n" )
        else
                if(member(site listIn) then
                fprintf( port "%d %d %d %d %d\n" xDie yDie numX2 numY2 nMoves)
                fprintf( port2 "%d %d \n" numX2 numY2)
                else
                fprintf( port "%d %d 0 0 %d\n" xDie yDie nMoves+1)
                fprintf( port2 "0 0\n" )
                )
        )
        )
 
 
if(listIn!=nil then
	
	if(there then
		x0 = xCoord(car(sites))
		y0 = yCoord(car(sites)) 
		pdsites = cdr(sites)
	else
		if(!couponChip then
			x0 = xInitial
			y0 = yInitial
			pdsites = sites
		else
			x0 = xCoord(car(sites))
			y0 = yCoord(car(sites))
			pdsites = cdr(sites)
		)
	)
    foreach( site pdsites
        if(member(site listIn) then
      x = xCoord(site)
      y = yCoord(site)
                numX = car(GetNumXY(chipName iX iY x y))
                numY = cadr(GetNumXY(chipName iX iY x y))
 
 	fprintf( port " %f %f %d %d\n" (x-x0)*1.e-3 (y-y0)*1.e-3 numX numY)
        fprintf( port2 "%d %d\n" numX numY)
      x0 = x
      y0 = y
    ))
)
    x1 = numX
    y1 = numY
    x = xCoord( car( sites))
    y = yCoord( car( sites))
        x0 = x
        y0 = y
 
 
        if(listOut!=nil then
        listEdges = cons(list(xDie yDie) listEdges)
        else
        if(isPartialRet(iX iY) then
                fprintf(port3 "%d %d 0 0 0\n" xDie yDie)
        )
	if(listIn!=nil then
		return(t)
	else
		return(nil)
	)
        )
 
        there2 = nil
    foreach( site sites
        if(there2==nil then
                if(member(site listOut) then
 
                fprintf( port3 "%d %d %d %d %d\n" xDie yDie numX2 numY2 nIntra2)
                else
                fprintf( port3 "%d %d 0 0 %d\n" xDie yDie nIntra2+1)
                )
                there2 = t
                nDie2 = nDie2 + 1
                x = xCoord(site)
                y = yCoord(site)
        else
        if(member(site listOut) then
                x = xCoord(site)
                y = yCoord(site)
                numX = car(GetNumXY(chipName iX iY x y))
                numY = cadr(GetNumXY(chipName iX iY x y))
         fprintf( port3 " %f %f %d %d\n" (x-x0)*1.e-3 (y-y0)*1.e-3 numX numY)
                x0 = x
                y0 = y
        )
    ))
	if(listIn==nil then
	return(nil) 
	else
	return(t)
	)
  )
)
procedure( doPartRet3(chipData iX iY nX nY sites port couponChip deltaX deltaY
        nX2 nY2 port2 nX4 port3 chipName)
prog((valueRet)

        if(sites==nil then
                return()
        )

	if(member(car(chipData) chipNames2) then
	if(retType=="true" && !couponChip then
valueRet = doPartRet(chipData iX iY nX nY sites port couponChip deltaX deltaY nX2 nY2 port2 nX4 port3 chipName)
	else
valueRet = doPartRet2(chipData iX iY nX nY sites port couponChip deltaX deltaY nX2 nY2 port2 nX4 port3 chipName)
	)
	if(valueRet != nil then
		return(t)
	else
		return(nil)
	)
	else
		return(nil)
	)
))

procedure( doPartialRet( iX iY nX nY chipData sites couponChip)
  prog( ( rl numX numY x1 y1 x y x0 y0 xDie yDie
          xc yc box ox oy loc realChipNum listIn ox2)
;pd("doPartialRet" "")
 
; Probe instructions if test block is completely on the wafer
; we know it's not a full reticle, check to see if the inner corner
; of this reticle is on the wafer:

	listIn = nil 
    if( ! isPartialRet( iX iY) then return( nil) )
 
; there's a bit of the reticle on-wafer, so consider each
; chip individually & build a list of on-wafer chips.
 
    numX = (iX - llCornerX) * nX
    numY = (iY - llCornerY) * nY
    xDie = iX - llCornerX
    yDie = iY - llCornerY
    ox = iX * retX
    oy = iY * retY
 
    nchps = 0
    rl = nil
    x1 = numX
    y1 = numY
    x = xCoord( car( sites))
    y = yCoord( car( sites))
    x0 = x
    y0 = y
 
    if(couponChip then
       foreach( coupon couponList
          loc = car(coupon)
          if( xCoord(loc) == x && yCoord(loc) == y then
             x0 = x0 + xCoord(cadr(coupon))
             y0 = y0 + yCoord(cadr(coupon))
          )
       )
    )
 
    doOriginSite = nil
    foreach(site sites
      if( xCoord(site) > x then numX++ )
      if( yCoord(site) > y then numY++ )
      if( yCoord(site) < y then numY = y1)
      x = xCoord(site)
      y = yCoord(site)
 
      if(couponChip then
         foreach( coupon couponList
            loc = car(coupon)
            if( xCoord(loc) == x && yCoord(loc) == y then
               realChipNum = caddr(coupon)
               x = x + xCoord(cadr(coupon))
               y = y + yCoord(cadr(coupon))
            )
         )
      )
      box = chipBBox(chipData site)   
      xc = ox + xCoord( site)
      yc = oy + yCoord( site)
      if( xc + retOffsetX < 0. then
        xc = ox + xCoord( lowerLeft( box))
      )
      if( xc + retOffsetX > 0. then
        xc = ox + xCoord( upperRight( box))
      )
      if( yc + retOffsetY < 0. then
        yc = oy + yCoord( lowerLeft( box))
      )
      if( yc + retOffsetY > 0. then
        yc = oy + yCoord( upperRight( box))
      )
      if( isOnWafer( xc yc) then
	ox2 = ox
	if(Xm==2 then
	ox2 = ox2 - retX/2.0
	)
        drawDieBox3(ox2 oy box)
	listIn = t
      )
      x = xCoord(site)
      y = yCoord(site)
    )
;       now that we know how many complete chips there are in this reticle,
;       either return if none, or write to the Keithley map file.
;       if the origin chip is incomplete, give it on-chip XY numbers = (0,0)
;       as a flag to the Keithley not to do it.
 
 
    return(listIn)
  )
)

;************************************************************************************
procedure( chipBBox( chipData site)
  prog( ( box orient x1 y1 x2 y2 ll ur)
;pd("chipBBox" "")

; Draws a box for the chip on the plot

    orient = caddr( cadr( chipData))
    box = car( cdddr( chipData))
    x1 = xCoord( lowerLeft( box))
    y1 = yCoord( lowerLeft( box))
    x2 = xCoord( upperRight( box))
    y2 = yCoord( upperRight( box))
    case( orient
      ( "R0"	ll = list( xCoord( site) + x1 yCoord( site) + y1)
                ur = list( xCoord( site) + x2 yCoord( site) + y2)
      )
      ( "R90"	ll = list( xCoord( site) - y2 yCoord( site) + x1)
                ur = list( xCoord( site) - y1 yCoord( site) + x2)
      )
      ( "R180"	ll = list( xCoord( site) - x2 yCoord( site) - y2)
                ur = list( xCoord( site) - x1 yCoord( site) - y1)
      )
      ( "R270"	ll = list( xCoord( site) + y1 yCoord( site) - x2)
                ur = list( xCoord( site) + y2 yCoord( site) - x1)
      )
      ( t       hiGetAttention()
                printf("INVALID CHIP ORIENTATION IN RETICLE!\n")
                return( nil)
      )
    )
    return( list( ll ur))
  )
)
;************************************************************************************
procedure(drawDieBox2(iX iY iXi iYi numX numY)
  prog( ( s x y xDie yDie)
;pd("drawDieBox2" "")

; Draws a a die box for full rets

    s = 700.
    x = (iX - .5*Xm) * retX + (iXi - 1) * retX / nFfsX + s
    y = (iY - .5) * retY + (iYi - 1) * retY / nFfsY + s
    wpRelRect(probeRep kDieLayer x y retX/nFfsX-s-s retY/nFfsY-s-s) 
    if(couponChip then
      xDie = iX - llCornerX
      yDie = iY - llCornerY
      sprintf(buf "%d-%d" xDie yDie)
     else
      sprintf(buf "%d-%d" numX numY)
    )
    dbCreateLabel(probeRep labelLayer list(x y) 
              buf "leftBottom" "R0" "stick" retX*.3/(nFfsX+nFfsY))
  )
)
;**************************************************************************
procedure(drawDieBox3(ofsX ofsY box)
  prog( ( s x y dx dy)
;pd("drawDieBox3" "")

; Draws a a die box for partial rets

    s = 100.
    x = xCoord( lowerLeft( box)) + s
    y = yCoord( lowerLeft( box)) + s
    dx = xCoord( upperRight( box)) - x - s - s
    dy = yCoord( upperRight( box)) - y - s - s
    wpRelRect(probeRep kDieLayer ofsX+x ofsY+y dx dy) 
  )
)
;*****************************************************************************
procedure(makeKeithleyFile(kFile nDie xStep yStep tempFile)
prog( ( port buf fullName status)
;pd("makeKeithleyFile" nil)

; Creates the probe file based on previous routines and new header

sprintf( fullName "%s/%s" releasePath kFile)
port = outfile(fullName "w") 
if( port == nil then
  hiGetAttention()
  printf("ERROR...UNABLE TO OPEN OUTPUT FILE: %s\n" fullName)
  return( nil)
else
  fprintf(port "*  Xstep  Ystep\n")
  fprintf(port "   %f     %f\n" xStep * 1. yStep * 1.)
  fprintf(port "*  Units\n")
  fprintf(port "   1\n")
  fprintf(port "*  # of Die\n")
  fprintf(port "   %d\n" nDie)
  close(port)
  )
; use system commandt to build keithley file

sprintf( buf "cat %s >> %s;sleep 2;rm %s" tempFile fullName tempFile)
status = system(buf)
printf("Keithley File created: %s\n" fullName) 
printf("Removed temp file: %s\n" tempFile)
))

procedure(CheckOutOfLine(listOfChips)
  prog((listSites xSite xSite2 xDiff xDiff2 site)
        listSites = nil
        foreach(chip listOfChips 
                listSites = append(listSites caddr(chip))
        )
	site = car(listSites)
	xSite2 = car(site)
	listSites = cdr(listSites)
	foreach(site listSites
		xSite = car(site)
		xDiff = xSite - xSite2
		xDiff2 = float(fix(xDiff))
		if(xDiff!=xDiff2 then
			println(list("Error at:" site))
			return(nil)
		)
		xSite2 = xSite
	)
	return(t)
))

procedure(CheckXySort()
  prog((item listSites chipName flagOk)

	chipName = car(car(chipList))
	if(!isCouponChip(chipName) && !isNCouponChip(chipName) then
		flagOk = CheckOutOfLine(chipList)
		if(flagOk==nil then
			if(!eWin("primary") then
				return(nil)
			)
		)
		flagOk = CheckOutOfLine(oatChipList)
                if(flagOk==nil then
                        if(!eWin("oat") then
				return(nil)
                        )
                )
	)
	listSites = nil
	foreach(chip chipList
		listSites = append(listSites caddr(chip))
	) 
	while(listSites!=nil
		item = car(listSites)
		listSites = cdr(listSites)
		if(member(item listSites) then
			println(list("Error:Multiple chips In Primary at " item))
			return(nil)
		)
	)
	listSites = nil
        foreach(chip oatChipList
                listSites = append(listSites caddr(chip)) 
        )
        while(listSites!=nil
                item = car(listSites)
                listSites = cdr(listSites)
                if(member(item listSites) then
                        println(list("Error:Multiple chips In Oat at " item))
                        return(nil)
                )
        )

	return(t)
))
;***********************************************************************
procedure( wpXySort( listIn)
  prog( ( listX listY listOut newMaxY)
;pd("wpXySort" "")

; Sorts a chip_list first by x and then by y.

    listX = nil
    foreach( item1 listIn    
      if( member( xCoord( item1) listX) == nil then
        listX = cons( xCoord( item1) listX)
      )
    )
    listX = sort( listX 'greaterp)
    maxX = length( listX)
    maxY = 1

    listOut = nil
    foreach( item1 listX
      listY = nil
      foreach( item2 listIn
        if( xCoord( item2) == item1 then
          listY = cons( yCoord( item2) listY)
        )
      )
      listY = sort( listY 'greaterp)
      newMaxY = length( listY)
      if(newMaxY > maxY then maxY = newMaxY )
      foreach( item2 listY
        listOut = cons( list( item1 item2) listOut)
      )
    )
    return( listOut)
  )
)
;***********************************************************************
procedure(wpAddBBoxes(drawRep retX retY nRetX nRetY)
prog( ( x1 x2 y1 y2 layerNum)
;pd("wpAddBBoxes" "")

; Places the bounding boxes for the wpnums drawing

if(waferSize == "4inch" then
  x1 = (llCornerXm - .5) * retXm + retOffsetXm
  x2 = (urCornerXm + .5) * retXm - 1.0 + retOffsetXm
  y1 = (llCornerYm - .5) * retYm + retOffsetYm
  y2 = (urCornerYm + .5) * retYm - 1.0 + retOffsetYm
;printf( "x1 = %f\ny1 = %f\nx2 = %f\ny2 = %f\n" x1 y1 x2 y2)
  for( layerNumber 1 3
    wpRelRect(drawRep techGetLayerName(
			techGetTechFile( reticleRep)   layerNumber) x1 y1 1 1) 
    wpRelRect(drawRep techGetLayerName(
			techGetTechFile( reticleRep)   layerNumber) x2 y2 1 1) 
    layerNumber++
    )
else
  layerNum = 1    
  x2 = retX / 2.
  x1 = -x2
  y2 = retY / 2.
  y1 = -y2      
  x2 = x2 - 1.
  y2 = y2 - 1.
  for(i 1 nRetX
  for(j 1 nRetY   
    wpRelRect(drawRep techGetLayerName( 
			techGetTechFile( reticleRep) layerNum) x1 y1 1 1) 
    wpRelRect(drawRep techGetLayerName(
			techGetTechFile( reticleRep) layerNum) x2 y2 1 1) 
    layerNum++
    ))
  )
))
;************************************************************************************
procedure(wpAddBBoxes1(drawRep retX retY nRetX nRetY)
prog( ( x1 x2 y1 y2 layerNum)
;pd("wpAddBBoxes" "")
;HHR1
; Places the bounding boxes for the wpnums drawing
;
if(waferSize == "4inch" then
;  x1 = (llCornerXm - .5) * retXm + retOffsetXm
;  x2 = (urCornerXm + .5) * retXm - 1.0 + retOffsetXm
;  y1 = (llCornerYm - .5) * retYm + retOffsetYm
;  y2 = (urCornerYm + .5) * retYm - 1.0 + retOffsetYm
  y11 = (llCornerYm * retYm) - ( .5 * retYm) 
  y22 = (urCornerYm * retYm) + ( .5 * retYm) - 1.0
  x11 = (llCornerXm * retXm) - ( .5 * retXm) 
  x22 = (urCornerXm * retXm) + ( .5 * retXm) - 1.0
printf( "x1 = %f\ny1 = %f\nx2 = %f\ny2 = %f\n" x11 y11 x22 y22)
  for( layerNumber 1 3
    wpRelRect1(drawRep techGetLayerName(
			techGetTechFile( reticleRep) layerNumber) x11 y11 x11 + 1 y11 + 1)
    wpRelRect1(drawRep techGetLayerName(
			techGetTechFile( reticleRep) layerNumber) x22 y22 x22 + 1 y22 + 1)
    layerNumber++
    )
else
  layerNum = 1
  x2 = retX / 2.
  x1 = -x2
  y2 = retY / 2.
  y1 = -y2  
  x2 = x2 - 1.
  y2 = y2 - 1.
  for(i 1 nRetX
  for(j 1 nRetY
    wpRelRect(drawRep techGetLayerName(
			techGetTechFile( reticleRep) layerNum) x1 y1 1 1)
    wpRelRect(drawRep techGetLayerName(
			techGetTechFile( reticleRep) layerNum) x2 y2 1 1)
    layerNum++
    ))
  )
))
;**********************************************************************************
procedure(wpPlaceOutline(drawRep XYPos) 
prog((inst)

if(waferSize == "4inch" then
  waferMapDB4Inch = dbOpenCellViewByType(waferLibrary waferOutline4Inch 
					 "layout" "maskLayout" "r") 
  inst = dbCreateInst(drawRep waferMapDB4Inch nil XYPos "R0" 1)
  dbClose(waferMapDB4Inch)
else
  waferMapDB3Inch = dbOpenCellViewByType(waferLibrary waferOutline3Inch 
					 "layout" "maskLayout" "r") 
  inst = dbCreateInst(drawRep waferMapDB3Inch nil XYPos "R0" 1)
  dbClose(waferMapDB3Inch) 
  )
leFlattenInst(inst 1)

))
;**********************************************************************
procedure(wpCreateProbPattens(portToUse)
  printf("Creating FFS Probe Pattens.\n")
  wpCouponList()
  wpCouponList2()
  wpProbeSet(portToUse)
)
;*******************************************************************************
procedure(wpCreateWaferMap()
  let( ( mapRep)

; create the wafer map for the Aeble - with user ok

  printf("Creating Aeble Wafer Map.\n")
  sprintf(fullName "%s" wafDwg)
  mapRep = dbOpenCellViewByType(libraryName fullName "layout" "maskLayout" "w")
  if(mapRep then  

; generate aeble map layout
	

    wpDrawXyDie(mapRep) 
    showAeble = t
;PSS I used to call wpWaferMap() here but since Rich Novo wanted specific data
;    I created a new procedure

    wpAebleWaferMap(mapRep)  
    dbSave(mapRep)            

; generate plot text file
;HHR
    sprintf( newLibName "%s-%s" substring(libraryName 1 2) substring(libraryName 3 strlen(libraryName)))
    sprintf(dsName "%s_xy" newLibName)


    dbClose(mapRep)
  else
    hiGetAttention()
    printf("ERROR - Unable to open wafer map layout\n")
    )
  )
)
;**************************************************************************
procedure(wpGetPadRep(numPadDwg)
prog( ( dummyList status form pc)
if(numPadDwg==1 then
	status = Enter1Pad()
)
if(numPadDwg==2 then
        status = Enter2Pad()
)
if(numPadDwg==3 then
        status = Enter3Pad()
)
if(numPadDwg==4 then
        status = Enter4Pad()
)
if(numPadDwg==5 then
        status = Enter5Pad()
)
if(status==nil then
	return(nil)
)
dummyList = nil
foreach(dummyDwg padDwgList
padRep = dbOpenCellViewByType(libraryName dummyDwg "layout" "maskLayout" "r") 
if(!padRep then

; set up for user query when pad drawing name is wrong

  pc = hiCreateStringField(?name 'dummyDwg
    ?prompt "Pad Drawing File Name:"
    ?value dummyDwg
    )
  form = hiCreateForm('form1 
        "Cannot open specified Pad Drawing File Name. Please enter correct name."
                list('ok 'cancel)
                list(pc)
                )
  while(!padRep && continueFlag
    hiGetAttention()
    if(hiDisplayForm(form) then
      dummyDwg = form->dummyDwg->value
      )
    padRep = dbOpenCellViewByType(libraryName dummyDwg "layout" 
				  "maskLayout" "r") 
    ) 
	dummyList = cons(dummyDwg dummyList)
else
	dummyList = cons(dummyDwg dummyList)
))
	padDwgList = reverse(dummyList)
  return(t)
))
;********************************************************************************
procedure(wpGetOatWindow()
prog( ( )
 
; make sure we are in the correct window.
oatWindowId=window(oatWindow);
oatRep = geGetWindowCellView( oatWindowId)
  return( oatRep)
))
;***********************************************************************************
procedure(wpGetReticleWindow()
let( ( windowID widgetType reticleRep )
  windowID = hiGetCurrentWindow()
  widgetType = hiGetWidgetType(windowID)
  if(widgetType == "graphics" then
    reticleRep = geGetWindowCellView(windowID)
    if(!null(reticleRep) then
      if(reticleRep~>viewName == "layout" then
        retDwg = reticleRep~>cellName 
        printf("INFO: Reticle Lib  Name: %s\n" reticleRep~>libraryName)
        printf("INFO: Reticle Cell Name: %s\n" reticleRep~>cellName)
        return(t) 
      else
        printf("Abort - Should be layout view - Actual view: %s\n" 
	        reticleRep~>viewName)
      )
    else
      printf("ERROR: Recticle window not found\n")
    )
  else
  printf("ERROR: Should be graphics window type - Actual window type: %s\n" 
	 widgetType)
  )
  )
)
;***********************************************************************************
procedure(wpInitWaferParameters()
if(waferSize == "4inch" then
  printf("Processing 4 inch wafer.\n")
  wafSize = 101346.		  ;wafer size in um
  wafEdge = 2000.
  lenPrim = 34316.              ;primary flat length (nominal)
  lenSeco = 11180.              ;secondary flat length (nominal)
  aebleSize = 25000.		  ;maximum aeble die size
  oatDwg = strcat(substring(retDwg 1 strlen(retDwg)-1) "o")
else
  printf("Processing 3 inch wafer.\n")
  wafSize = 76010.		;wafer size in um
  wafEdge = 2000.	        ;incomplete die are on edge of wafer
  lenPrim = 22225.            ;primary flat length (nominal)
  lenSeco = 11180.            ;secondary flat length (nominal)
  aebleSize = 17000.		;maximum aeble die size
  )
)
;************************************************************************************
procedure(getFormValues1()
prog((form ln tc pd nd ws xm ym status)

ln = hiCreateStringField(?name 'libraryName
  ?prompt "Library Name:"
  ?value libraryName
  ?callback "cbLibraryName(ln->value)"
  ?editable nil
  )
tc = hiCreateStringField(?name 'retDwg
  ?prompt "Reticle Drawing Name:"
  ?value retDwg
  ?editable nil
  )
pd = hiCreateStringField(?name 'padDwg
  ?prompt "XY Number Pad Drawing File Name:"
  ?value padDwg
  )
nd = hiCreateStringField(?name 'numDwg
  ?prompt "Layout Containing XY Numbers:"
  ?value numDwg
  )
wd = hiCreateStringField(?name 'wafDwg
  ?prompt "Wafer Diagram with Aeble Layers:"
  ?value wafDwg
  )
ws = hiCreateCyclicField(
  ?name 'waferSize
  ?choices list("4inch" "3inch")
  ?value waferSize
  ?prompt "Wafer Size:"
  )
xm = hiCreateIntField(
  ?name 'Xm
  ?prompt "X Dimension for Matrix:"
  ?value Xm
  )
ym = hiCreateIntField(
  ?name 'Ym
  ?prompt "Y Dimension for Matrix:"
  ?value Ym
  )
form = hiCreateForm('form1 
                    "WPNUMS Values"
                    list('ok 'cancel)
                    list(ln tc pd nd wd ws xm ym )
                    )
status = hiDisplayForm(form)
if(status then
  libraryName = form->libraryName->value
  retDwg = form->retDwg->value
  padDwg = form->padDwg->value
  numDwg = form->numDwg->value
  wafDwg = form->wafDwg->value
  waferSize = form->waferSize->value
  Xm = form->Xm->value
  Ym = form->Ym->value
else
  continueFlag = nil
  )
return(continueFlag)
))
;************************************************
procedure(getFormValues2()
prog((form f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 
      f15 f16 f17 f18 f19 f20 f21 f22 f23 f24 status)
 f1 = hiCreateFloatField(
  ?name 'retXm
  ?prompt "Matrix Step/Repeat X (um)"
  ?value retXm
  ?editable nil
  )
f2 = hiCreateFloatField(
  ?name 'retYm
  ?prompt "Matrix Step/Repeat Y (um)"
  ?value retYm
  ?editable nil
  )
f3 = hiCreateIntField(
  ?name 'aRetXm
  ?prompt "Matrixes per XY Aeble Die, X"
  ?value aRetXm
  )
f4 = hiCreateIntField(
  ?name 'aRetYm
  ?prompt "Matrixes per XY Aeble Die, Y"
  ?value aRetYm
  )
f5 = hiCreateIntField(
  ?name 'llCornerXm 
  ?prompt "Matrix reticle offset from wafer center, X"
  ?value llCornerXm 
  )
f6 = hiCreateIntField(
  ?name 'llCornerYm
  ?prompt "Matrix reticle offset from wafer center, Y"
  ?value llCornerYm
  )
f7 = hiCreateIntField(
  ?name 'urCornerXm 
  ?prompt "Matrix Upper Right Corner offset, X"
  ?value urCornerXm 
  )
f8 = hiCreateIntField(
  ?name 'urCornerYm
  ?prompt "Matrix Upper Right Corner offset, Y"
  ?value urCornerYm
  )
f9 = hiCreateFloatField(
  ?name 'retOffsetXm 
  ?prompt "Matrix reticle offset from wafer center, X"
  ?value retOffsetXm 
  )
f10 = hiCreateFloatField(
  ?name 'retOffsetYm
  ?prompt "Matrix reticle offset from wafer center, Y"
  ?value retOffsetYm
  )
f11 = hiCreateIntField(
  ?name 'oat1X 
  ?prompt "First Oat/Nav offset from center test block, X"
  ?value oat1X 
  )
f12 = hiCreateIntField(
  ?name 'oat1Y
  ?prompt "First Oat/Nav offset from center test block, Y"
  ?value oat1Y
  )
f13 = hiCreateIntField(
  ?name 'oat2X 
  ?prompt "Second Oat/Nav offset from center test block, X"
  ?value oat2X 
  )
f14 = hiCreateIntField(
  ?name 'oat2Y 
  ?prompt "Second Oat/Nav offset from center test block, Y"
  ?value oat2Y 
  )
f15 = hiCreateIntField(
  ?name 'oat3X 
  ?prompt "Third Oat/Nav offset from center test block, X"
  ?value oat3X 
  )
f16 = hiCreateIntField(
  ?name 'oat3Y
  ?prompt "Third Oat/Nav offset from center test block, Y"
  ?value oat3Y
  )
; 4inch

f17 = hiCreateIntField(
  ?name 'llCornerX 
  ?prompt "Test Block Lower Left Corner offset, X"
  ?value llCornerX 
;  ?editable nil
  )
f18 = hiCreateIntField(
  ?name 'llCornerY
  ?prompt "Test Block Lower Left Corner offset, Y"
  ?value llCornerY
;  ?editable nil
  )
f19 = hiCreateIntField(
  ?name 'urCornerX 
  ?prompt "Test Block Upper Right Corner offset, X"
  ?value urCornerX 
  ?editable nil
  )
f20 = hiCreateIntField(
  ?name 'urCornerY
  ?prompt "Test Block Upper Right Corner offset, Y"
  ?value urCornerY
  ?editable nil
  )
f21 = hiCreateFloatField(
  ?name 'retOffsetX 
  ?prompt "Test Block offset from wafer center, X" 
  ?value retOffsetX
;  ?editable nil
  )
f22 = hiCreateFloatField(
  ?name 'retOffsetY
  ?prompt "Test Block offset from wafer center, Y" 
  ?value retOffsetY
;  ?editable nil
  )
f23 = hiCreateIntField(
  ?name 'nAdieXm
  ?prompt "XY Aeble Die per Wafer, X" 
  ?value nAdieXm
  ?editable nil
  )
f24 = hiCreateIntField(
  ?name 'nAdieYm
  ?prompt "XY Aeble Die per Wafer, Y" 
  ?value nAdieYm 
  ?editable nil
  )
; have user verify these:

if(waferSize == "4inch" then
  form = hiCreateForm('form2 
           "Please verify the following values for the 4 inch wafer process:"
            list('ok 'cancel)
            list(f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 
                 f15 f16 f17 f18 f19 f20 f21 f22 f23 f24))
  status = hiDisplayForm(form)
  if(status then
    retXm = form->retXm->value
    retYm = form->retYm->value
    aRetXm = form->aRetXm->value
    aRetYm = form->aRetYm->value
    llCornerXm  = form->llCornerXm->value
    llCornerYm = form->llCornerYm->value
    urCornerXm = form->urCornerXm->value
    urCornerYm = form->urCornerYm->value
    retOffsetXm = form->retOffsetXm->value
    retOffsetYm = form->retOffsetYm->value
    oat1X = form->oat1X->value
    oat1Y = form->oat1Y->value
    oat2X = form->oat2X->value
    oat2Y = form->oat2Y->value
    oat3X = form->oat3X->value
    oat3Y = form->oat3Y->value
navaidSites = list(list(oat1X oat1Y) list(oat2X oat2Y) list(oat3X oat3Y))
;    oat3X = 0
;    oat3Y = 0
    llCornerX = form->llCornerX->value
    llCornerY = form->llCornerY->value
    urCornerX = form->urCornerX->value
    urCornerY = form->urCornerY->value
    retOffsetX = form->retOffsetX->value
    retOffsetY = form->retOffsetY->value
    nAdieXm = form->nAdieXm->value
    nAdieYm = form->nAdieYm->value
    )
else ; 3inch
  form = hiCreateForm('form2 
           "Please verify the following values for the 3 inch wafer process:"
            list('ok 'cancel)
            list(f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 f15 f16 f23 f24))
  status = hiDisplayForm(form)
  if(status then
    retXm = form->retXm->value
    retYm = form->retYm->value
    aRetXm = form->aRetXm->value
    aRetYm = form->aRetYm->value
    llCornerXm  = form->llCornerXm->value
    llCornerYm = form->llCornerYm->value
    urCornerXm = form->urCornerXm->value
    urCornerYm = form->urCornerYm->value
    retOffsetXm = form->retOffsetXm->value
    retOffsetYm = form->retOffsetYm->value
    oat1X = form->oat1X->value
    oat1Y = form->oat1Y->value
    oat2X = form->oat2X->value
    oat2Y = form->oat2Y->value
    oat3X = form->oat3X->value
    oat3Y = form->oat3Y->value
;    oat3X = 0
;    oat3Y = 0
    nAdieXm = form->nAdieXm->value
    nAdieYm = form->nAdieYm->value
    )
  )
return(status)
))
procedure(getFormValues3()
prog((form ln tc nd ws xm ym status)
ln = hiCreateStringField(?name 'libraryName
  ?prompt "Library Name:"
  ?value libraryName
  ?callback "cbLibraryName(ln->value)"
  ?editable nil
  )
tc = hiCreateStringField(?name 'retDwg
  ?prompt "Reticle Drawing Name:"
  ?value retDwg
  ?editable nil
  )
nd = hiCreateStringField(?name 'numDwg
  ?prompt "Layout Containing XY Numbers:"
  ?value numDwg
  )
wd = hiCreateStringField(?name 'wafDwg
  ?prompt "Wafer Diagram with Aeble Layers:"
  ?value wafDwg
  )
ws = hiCreateCyclicField(
  ?name 'waferSize
  ?choices list("4inch" "3inch")
  ?value waferSize
  ?prompt "Wafer Size:"
  )
xm = hiCreateIntField(
  ?name 'Xm
  ?prompt "X Dimension for Matrix:"
  ?value Xm
  )
ym = hiCreateIntField(
  ?name 'Ym
  ?prompt "Y Dimension for Matrix:"
  ?value Ym
  )
form = hiCreateForm('form1
                    "WPNUMS Values"
                    list('ok 'cancel)
                    list(ln tc nd wd ws xm ym )
                    )
status = hiDisplayForm(form)
if(status then
  libraryName = form->libraryName->value
  retDwg = form->retDwg->value
  numDwg = form->numDwg->value
  wafDwg = form->wafDwg->value
  waferSize = form->waferSize->value
  Xm = form->Xm->value
  Ym = form->Ym->value
else
  continueFlag = nil
  )
return(continueFlag)
))

;************************************************
procedure(ok(form "r")
continueFlag = t
)
;************************************************
procedure(cancel(form "r")
continueFlag = nil
)
;************************************************
procedure(cbLibraryName(name)

printf("cbLibName %s\n" name)

if(name == "" || 
   index(name '\-) == nil then
  hiDisplayAppDBox(
    ?name 'zz
    ?dboxBanner "ERROR Message."
    ?dboxText "Library Name MUST be specified in the form LN-0001."
    )
  libraryName = "***"
  ) 
)
;**************************************************************
procedure( wpnInit()
  prog( ()
  println("INFO: initializing ...")

; initialize wpn global variables
				;DRAWING NAMES:
; The following three vriables wer added July 1,1998
; upon order by Bernie Ostroski
waferShiftX = 0.
waferShiftY = 0.
bernCount = 0
; The following two variables represent the retOffset
; when reticle is optimized
optRetOffXm = 0.
optRetOffYm = 0.
couponChip =nil
wpnumsType = "write"
kFile = "ffs_ptn"       	;probe pattern output file name
probeFile = "probe"		; probe file name
logFile = "log"			;log file name
releasePath = ""                ;full path for drawings & files
retDwg = ""			;reticle drawing name
oatDwg = ""
logPort = nil                   ;stream port for procedure log
probePort = nil
titleBar = 0.			;area allocated to tilte ( 4inch)
continueFlag = t
showAeble = nil
oatTrue = nil
waferSize = "4inch"
listEdges = nil
oatEdges = nil
Xm = 1                          ;x matrix dimension
Ym = 1                          ;y matrix dimension
oatWindow = 3
waferLibrary = "outlines"
waferOutline4Inch = "wafer_outline_4inch"
waferOutline3Inch = "wafer_outline"
probeNames = nil
probeNames2 = nil
retOlap = 4.			;overlap of reticles in um
alignX = 0                      ;prober alignment is to the origin chip
alignY = 1                      ;in this reticle (one above lowerleft oat/nav)
plugX = 3700.			;drop-in size in um, X
plugY = 3600.			;drop-in size in um, Y
navX = 2000.			;size of navigation aid drop-in
navY = 2000.
navMargin = 500.                ;for fit of navaids with drop-ins
plugSites = list((1000:1000))	;sites (wrt wafer center) for drop-ins
           			;(plug-bars, PCMs, whatever)
navaidSites = nil               ;list of navaid sites, determined on fly
edgeX = 0                       ;distance to secondary flat
edgeY = 0                       ;distance to primary flat
retX = 0			;reticle step & repeat, X
retY = 0			;reticle step & repeat, Y
aRetXm = 0			;no. matrix reticles per aeble die, X
aRetYm = 0			;no. matrix reticles per aeble die, Y
aRetX = 0			;no. test blocks per aeble die, X
aRetY = 0			;no. test blocks per aeble die, Y
nAdieXm = 0			;no. aeble die across wafer, X
nAdieYm = 0			;no. aeble die across wafer, Y
llCornerXm = 0			;wafer index of lower left corner matrix, X
llCornerYm = 0			;wafer index of lower left corner matrix, Y
urCornerXm = 0			;wafer index of upper right corner matrix, X
urCornerYm = 0			;wafer index of upper right corner matrix, Y
llCornerX = 0			;wafer index of lower left corner test block, X
llCornerY = 0			;wafer index of lower left corner test block, Y
urCornerX = 0			;wafer index of upper right corner test block, X
urCornerY = 0			;wafer index of upper right corner test block, Y
retOffsetXm = 0.		;distance from original wafer center to matrix center, X
retOffsetYm = 0.		;distance from original wafer center to matrix center, Y
retOffsetX = 0.			;distance from original wafer center to ret center, X
retOffsetY = 0.			;distance from original wafer center to ret center, Y
nEdgeChips = 0                  ;chips probed from incomplete reticles
nFullRets = 0                   ;full reticles on the wafer
nPartRets = 0                   ;partial probed reticles
nChipsTotal = 0                 ;total probed chips on the wafer

;layers for wafer map drawings:

reticleLayer = "capBot"
matrixLayer = "ta"
plugBarLayer = "ta"
xyDieLayer = "nitEtch"
kDieLayer = "thick"
navaidLayer = "bridge"
nDieLayer = "mesa"
labelLayer = "text" 
numCellsLayer = "sd"
				;FFS PROBE PARAMETERS:
nFfsX = 0			;number probe die per reticle, X
nFfsY = 0			;number probe die per reticle, Y
nIntra = 0                      ;no. of intra-die Keithley movements
nOat = 0
couponList = nil                ;list of coupons
chipList = nil
oatChipList = nil
				;AEBLE NUMBERS DRAWING PARAMETERS:
cHeight = 0			;Character height (um)
cRatio = 0.1			;Line width to height ratio
cWidth = 0			;Gross width of characters
dashWidth = 0                   ;Width of the - character
cXOffset = 0			;X Offset from pad origin to 1st char
cYOffset = 0			;Y Offset from pad origin to 1st char
nDigits = 2			;Number of digits in each number
numPath = "empty"			;Path for number cells
numFont = '( nil		;Number Font Definition
  height 40                     ; Line segment definition of numbers
  width 60
  strokes (
  (" " 36)
  ("-" 20 ((10 26) (20 26)))
  ("0" 38 ((19 40) (10 40) (10 10) (34 10) (34 40) (25 40)))
  ("1" 20 ((12 42) (12 8)))
  ("2" 36 ((10 40) (32 40) (32 26) (10 26) (10 10) (32 10)))
  ("3" 36 ((10 40) (32 40) (32 10) (10 10)) ((10 26) (32 26)))
  ("4" 36 ((10 40) (10 26) (32 26) (32 40)) ((32 26) (32 8)))
  ("5" 36 ((32 40) (10 40) (10 26) (32 26) (32 10) (10 10)))
  ("6" 36 ((32 40) (10 40) (10 10) (32 10) (32 26) (18 26)))
  ("7" 32 ((10 40) (30 40) (30 8)))
  ("8" 38 ((27 40) (10 40) (10 26) (34 26) (34 40)) ((10 26) (10 10))
          ((18 10) (34 10) (34 26)))
  ("9" 36 ((25 24) (10 24) (10 40) (32 40) (32 8)))
  )
)))
;************************************************************************************
procedure( fullToBlock( fullName)
  prog( ( name rev rep block)
 
    if( fullName == nil then return( ""))
    name =  fullName
    rev =   rindex(name '\/)
    name =  substring(name 1 (strlen(name) - strlen(rev)))
    rep =   rindex(name '\/)
    name =  substring(name 1 (strlen(name) - strlen(rep)))
    block = rindex(name '\/)
    if( block == nil then
      block = name
    else
      block = substring( block 2)
    )
    return( block)
  )
)
;************************************************************************************
procedure(M(mes1 mes2)
 
; fbreen message output function
 
printf("* - %s %s\n" mes1 mes2)
)
;************************************************************************************
procedure(pd(mes1 mes2)
 
; fbreen print diagnostic message output function
 
printf("PD- %s >" mes1)
;println(mes2)
)


