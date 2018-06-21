procedure( splitData()
  let( (lib1Name cell1Name splitBrowser1 form1 orientBut cell cv)

    cv = geGetWindowCellView()

    if( dbobjectp(cv) then
      cell = cv~>cellName
    else
      cell = ""
    )
    
    lib1Name = hiCreateStringField(
      ?name 'lib1Name
      ?prompt "Library1 Name"
      ?value "DivaFracLib"
      ?callback "ddsUpdateSyncWithForm( )"
    )
    cell1Name = hiCreateStringField(
      ?name 'cell1Name
      ?prompt "Cell1 Name"
      ?value cell
      ?callback "ddsUpdateSyncWithForm( )"
    )
    maskName = hiCreateStringField(
      ?name 'maskName
      ?prompt "Mask Name"
      ?value ""
      ?callback "ddsUpdateSyncWithForm( )"
    )
    splitBrowser1 = hiCreateButtonBoxField(
      ?name 'splitBrowser1
      ?prompt " "
      ?choices '(" Browse ")
      ?callback list("splitBrowser('lib1Name 'cell1Name)")
    )
    orientBut = hiCreateRadioField( 
      ?name 'orient 
      ?prompt "Reticle Orientation"
      ?choices list("North-South" "East-West" "Quads")
    )
			
    form1=hiCreateAppForm(
      ?name 'splitForm 
      ?formTitle "Split DivaFrac Data Form"
      ?callback "runSplit()"
      ?fields list(lib1Name cell1Name maskName splitBrowser1 orientBut)
    )
    hiDisplayForm( 'splitForm )
  )
)

procedure( yankWindowSplit(ocv yankWin cell destlib)
  let( (cv newcell i)
  
    leYankFigs(ocv yankWin 32)
    cv  = dbOpenCellViewByType(destlib cell "layout" "maskLayout" "w" )

    lePasteFigs(cv 0:0 "R0")
    foreach( i cv~>instances
      if( i~>mosaic then
        dbFlattenInst(i~>mosaic 31 t nil nil)
      else
        dbFlattenInst(i 31 t nil nil)
      )
    )
    dbSave(cv)
    dbClose(cv)
  )
)

procedure( splitBrowser(lib cell)
  ddsSyncWithForm( splitForm 'browse lib cell)
)

procedure( runSplit()
  let( (lib cell mask ret_orient minX maxX minY maxY ocv destlib yankNorth yankSouth)

    lib = splitForm->lib1Name->value
    cell = splitForm->cell1Name->value
    ret_orient = splitForm->orient->value
    mask = splitForm->maskName->value


    ocv  = dbOpenCellViewByType(lib cell "layout" "maskLayout" "r" )

    minX = xCoord(car(ocv~>bBox))
    maxX = xCoord(cadr(ocv~>bBox))
    minY = yCoord(car(ocv~>bBox))
    maxY = yCoord(cadr(ocv~>bBox))
    
    destlib = lib
    
    case( ret_orient
      ( "North-South"
        yankNorth = list(minX+1.5:-0.5 minX+1.5:maxY-1.5 maxX-1.5:maxY-1.5 maxX-1.5:-0.5)
;	printf("%L\n" yankNorth)
	sprintf( newcell "%s_north" cell)
	yankWindowSplit(ocv yankNorth newcell destlib)
	streamOutData(ocv newcell mask)
	get_north_south_win(lib newcell mask)
        yankSouth = list(minX+1.5:minY+1.5 minX+1.5:0.5 maxX-1.5:0.5 maxX-1.5:minY+1.5)
;	printf("%L\n" yankSouth)
	sprintf( newcell "%s_south" cell)
	yankWindowSplit(ocv yankSouth newcell destlib)
	streamOutData(ocv newcell mask)
	get_north_south_win(lib newcell mask)
      )
      ( "East-West"
        yankEast = list(-0.5:minY+1.5 maxX-1.5:minY+1.5 maxX-1.5:maxY-1.5 -0.5:maxY-1.5)
        sprintf( newcell "%s_east" cell)
	yankWindowSplit(ocv yankEast newcell destlib)
	streamOutData(ocv newcell mask)
        yankWest = list(minX+1.5:minY+1.5 0.5:minY+1.5 0.5:maxY-1.5 minX+1.5:maxY-1.5)
	sprintf( newcell "%s_west" cell)
	yankWindowSplit(ocv yankWest newcell destlib)
	streamOutData(ocv newcell mask)
      )
      ( "Quads"
        yankNE = list(-0.5:-0.5 maxX-1.5:-0.5 maxX-1.5:maxY-1.5 -0.5:maxY-1.5)
        sprintf( newcell "%s_ne" cell)
	yankWindowSplit(ocv yankNE newcell destlib)
	streamOutData(ocv newcell mask)
        yankSE = list(-0.5:minY+1.5 maxX-1.5:minY+1.5 maxX-1.5:0.5 -0.5:0.5)
	sprintf( newcell "%s_se" cell)
	yankWindowSplit(ocv yankSE newcell destlib)
	streamOutData(ocv newcell mask)
        yankSW = list(minX+1.5:minY+1.5 0.5:minY+1.5 0.5:0.5 minX+1.5:0.5)
	sprintf( newcell "%s_sw" cell)
	yankWindowSplit(ocv yankSW newcell destlib)
	streamOutData(ocv newcell mask)
        yankNW = list(minX+1.5:-0.5 0.5:-0.5 0.5:maxY-1.5 minX+1.5:maxY-1.5)
        sprintf( newcell "%s_nw" cell)
	yankWindowSplit(ocv yankNW newcell destlib)
	streamOutData(ocv newcell mask)
      )
    )
    dbClose(ocv)
  )
)

procedure( streamOutData(cv outcell mask) 
  let( (filePath cwdGdsPath outfile logfile)
  
    sprintf(filePath "%s/deslibs/%s/release" getShellEnvVar("HOME") mask)

    if( isWritable(filePath) then
      sprintf( outfile "%s/%s.gds" filePath outcell)
      sprintf( logfile "%s/%s.log" filePath outcell)
    else
      sprintf(cwdGdsPath "%s/gds" getWorkingDir())
      if( isDir(cwdGdsPath) then
	sprintf( outfile "%s/%s.gds" cwdGdsPath outcell)
	sprintf( logfile "%s/%s.log" cwdGdsPath outcell)
      else
        createDir(cwdGdsPath)
	sprintf( outfile "%s/%s.gds" cwdGdsPath outcell)
	sprintf( logfile "%s/%s.log" cwdGdsPath outcell)
      )
    )
        



    streamOutKeys = list( nil
    'libName "DivaFracLib"
    'primaryCell outcell 
    'viewName "layout"
    'caseSensitivity "preserve"
    'outFile outfile
    'errFile logfile
    )

    pipoDisplay( transStreamOutForm )
  )
)

procedure( get_north_south_win(lib cell mask)
  let( (port WINDIR winfile)
  
  phopl = '( nil
	     eBeam      "Leica"
	     process    "P80A"
  )
  sprintf(WINDIR "%s/deslibs/%s/release" getShellEnvVar("HOME") mask)

  if( isWritable(WINDIR) then
    sprintf( winfile "%s/%s_win.txt" WINDIR cell)
  else
    sprintf(cwdGdsPath "%s/gds" getWorkingDir())
    if( isDir(cwdGdsPath) then
      sprintf( winfile "%s/%s_win.txt" cwdGdsPath cell)
    else
      createDir(cwdGdsPath)
      sprintf( winfile "%s/%s_win.txt" cwdGdsPath cell)
    )
  )
  port = outfile(winfile)
  get_ebeam_window(lib cell port)
  close(port)

  )
)
