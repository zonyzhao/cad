;
;	Usage: fillMetal("pd0087" "pd87_0p_chip_00" 50.0)
;
procedure( fill( lib cell fill_keepout_oversize)
  let( (cv layList flat sd nitEtch1 capBot glass grid scratch grid_plus6
        capBot_plus6 fill_notarea sputNit capBot_fill fill_area keepout
	fill slot fillName scratchName slotName slot_tiled flatName )
    ; Open original cell
    cv  = dbOpenCellViewByType(lib cell "layout" "maskLayout" "r" )
    ; Use a flatten and merged version of original cell
    sprintf(flatName "%s_flat", cell)
    flat  = dbCopyCellView(cv lib flatName "layout" "" nil t)
    flat = dbOpenCellViewByType(lib flatName "layout" "maskLayout" "a" )
    ; Define layers that are needed to operate on layers not defined in layList are removed
    layList = list("GRID" "glass" "sd" "sdText" "mesa" "leGatePad" "nitEtch1" "capBot" "nitEtch" "ta" "thinTa" "Metal2" "thick")
    flattenConvertMerge(flat layList)
    ; Create shape lists for layer geometry ops
    sd = car(setof(lp flat~>lpps lp~>layerName=="sd"))~>shapes
    sdText = car(setof(lp flat~>lpps lp~>layerName=="sdText"))~>shapes
    mesa = car(setof(lp flat~>lpps lp~>layerName=="mesa"))~>shapes
    leGatePad = car(setof(lp flat~>lpps lp~>layerName=="leGatePad"))~>shapes
    nitEtch1 = car(setof(lp flat~>lpps lp~>layerName=="nitEtch1"))~>shapes
    capBot = car(setof(lp flat~>lpps lp~>layerName=="capBot"))~>shapes
    nitEtch = car(setof(lp flat~>lpps lp~>layerName=="nitEtch"))~>shapes
    ta = car(setof(lp flat~>lpps lp~>layerName=="ta"))~>shapes
    thinTa = car(setof(lp flat~>lpps lp~>layerName=="thinTa"))~>shapes
    Metal2 = car(setof(lp flat~>lpps lp~>layerName=="Metal2"))~>shapes
    thick = car(setof(lp flat~>lpps lp~>layerName=="thick"))~>shapes
    glass = car(setof(lp flat->lpps lp~>layerName=="glass"))~>shapes
    grid = car(setof(lp flat->lpps lp~>layerName=="GRID"))~>shapes
    fillLayerList = list("sd")

    foreach( layer fillLayerList
      ; Create scratch cell to operate in don't save
      sprintf(scratchName "%s_%s_scratch", cell,layer)
      scratch = dbOpenCellViewByType(lib scratchName "layout" "maskLayout" "w" )
      ; Or all the metal layers together
      fill_notarea1 = dbLayerOr(scratch "keepout" sd sdText 2000)
      fill_notarea2 = dbLayerOr(scratch "keepout" mesa fill_notarea1 2000)
      fill_notarea3 = dbLayerOr(scratch "keepout" leGatePad fill_notarea2 2000)
      fill_notarea4 = dbLayerOr(scratch "keepout" capBot fill_notarea3 2000)
      fill_notarea5 = dbLayerOr(scratch "keepout" ta fill_notarea4 2000)
      fill_notarea6 = dbLayerOr(scratch "keepout" thick fill_notarea5 2000)
      fill_notarea7 = dbLayerOr(scratch "keepout" grid fill_notarea6 2000)
      fill_notarea8 = dbLayerOr(scratch "keepout" nitEtch fill_notarea7 2000)
      fill_notarea9 = dbLayerOr(scratch "keepout" thinTa fill_notarea8 2000)
      ; Size up all the metals by 100    
      fill_notarea = dbLayerSize(scratch "keepout" fill_notarea9 fill_keepout_oversize)
      ; Generate the fill pattern
      draw_CrossHatchPattern(cv scratch layer )
      ; sputNit is the bBox of cv
      sputNit = car(setof(lp scratch~>lpps lp~>layerName=="sputNit"))~>shapes
      bBox_minus6 =  dbLayerSize(scratch "trl" sputNit -6)
      capBot_fill = car(setof(lp scratch~>lpps lp~>layerName==layer))~>shapes
      fill_area = dbLayerAndNot(scratch "trl" bBox_minus6 fill_notarea 2000)
      deleteShapeOnLayer(scratch "sputNit")
      dbLayerOutside(scratch "sputNit" capBot_fill fill_area )
      dbLayerStraddle(scratch "sputNit" capBot_fill fill_area )
      sputNit = car(setof(lp scratch~>lpps lp~>layerName=="sputNit"))~>shapes
      sprintf(fillName "%s_%s_fill", cell,layer)
      fill = dbOpenCellViewByType(lib fillName "layout" "maskLayout" "w")
      dbLayerAndNot(fill layer capBot_fill sputNit 2000)
      dbSave(fill)
      dbClose(fill)
      dbPurge(scratch)

    )
    dbClose(flat)
    ddDeleteObj(ddGetObj(lib flatName "layout"))
    dbClose(cv)
    t
  )
)


procedure( deleteShapeOnLayer(cv layer)
  let( (shapeList)
    shapeList=layer
    unless( listp(layer) 
      shapeList=car(setof(lp cv~>lpps lp~>layerName==layer))~>shapes
    )
    foreach(shape shapeList
      dbDeleteObject(shape)
    )
  )
)

procedure( flattenConvertMerge(cv layList)
  let( (layer)
    foreach( i cv~>instances
      if( i~>mosaic then
        dbFlattenInst(i~>mosaic 31 t nil nil)
      else
        dbFlattenInst(i 31 t nil nil)
      )
    )
    foreach( layer cv~>lpps
      if( member(layer->layerName,layList) then
	foreach(shape layer~>shapes
	  ;printf("%L\n" shape->objType)
          if(shape->objType == "polygon" || shape->objType == "path" || shape->objType == "line" then
	    leConvertShapeToPolygon(shape)
	  else 
	    if( shape->objType == "label" 
	      dbDeleteObject(shape)
	    )
	  )
	)
      else
	foreach(shape layer~>shapes
	  dbDeleteObject(shape)
	)
      )
    )
    foreach( layer cv~>lpps
      if( member(layer->layerName,layList) then
	;printf("%L\n" layer~>layerName)
	leMergeShapes(
	  car(setof(lp cv~>lpps lp~>layerName==layer~>layerName))~>shapes
	)
      )
    )
  )
)

procedure( draw_CrossHatchPattern(cv fill layer )
  let( (srX srY x y llX llY urX urY intX intY)
  srX=20.0
  srY=20.0
  llX=caar(cv->bBox)
  llY=cadar(cv->bBox)
  urX=caadr(cv->bBox)
  urY=cadadr(cv->bBox)
  intX = floor((urX-llX)/srX)-1
  intY = floor((urY-llY)/srY)-1
  dbCreateRect(fill "sputNit" list(llX:llY urX:urY)) 
;   step through the grid:
    for( i 0 intY
      y = llY + i*srY
      for( j 0 intX
        x = llX + j*srX
        draw_CrossHatchCell(fill layer x y)
      )
    )
    
  )
)

procedure( draw_CrossHatchCell(cv layer x0 y0)
  let( (x1 y1 x2 y2)
    x1=x0
    y1=y0
    x2=x0+15.0
    y2=y0+15.0
    dbCreateRect(cv layer list(x1:y1 x2:y2)) 
  )
)



