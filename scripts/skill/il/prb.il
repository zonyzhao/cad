/*
 
File Name     :         prb.il
Revision      :         beta6
Part of       :         design release utilities
Client        :         Raytheon RFC
Author        :         Mark Mezger [Saxonville EDA]
Application   :         IC tools
SW Release    :         4.4.3 or later
Language      :         il
Prefix        :         prb
 

	D e s c r i p t i o n

	generates prober-driver files and ffs-map cellviews

        relies on results data from xyn.il, this data resides in:
	<reticle_library>/release/xynumbers.dpl

	user specifies number of probe passes and selects chips (by name) to
	be probed in each pass

        M o d i f i c a t i o n    H i s t o r y

	When		Who		What
	10/20/03	mezger		alpha 1
	10/22/03			alpha 2
	10/28/03			beta
	01/09/04			beta 2
					main proc error handling
	01/30/04			ffs map reflects tested chips in 2nd-ary sites
	02/02/04			added comment to map file footer
	02/04/04			change relating to reticle copies
	02/09/04			changes relating to coupon probing
	02/25/04			minor tweeks to prober file format,
					changes to reference site defn and use
	03/03/04			updated coupon stepping to be wrt the
					alignment labels in the cells below the
					coupon-cells
	06/03/04			bug fix to coupon stepping, wasn't invoking
					alignment label coordinate search and
					wasn't mapping coordinates to top level
	06/03/04			mod to look for alignment label at either
					of two hierarchical levels
	06/07/04        kw              fix to prbGetCouponAlignPt
	08/29/04	mm		mod to prbGetLLChipNums to consider only
					chips specific to probe run, not sure why this
					wasn't a problem earlier
	08/30/04			log file now written in release/ dir
	11/23/04	mm		added leading space to intra-ret steps
	02/01/05	mm		mod to prbGetLLChipNums to find min column
					die first, then min row, this affects the
					reported starting die chip-number
	02/02/05	mm		reverse inter-reticle stepping to move
					across the wafer (x) first, then up (y)
	02/08/05	mm		mods to handle stored xy numbers on all chip
					instances and new onWafer instance property
	07/17/06	mm		added 2 new output files per probe pass:
					  xxx.picklist lists all complete die
					  xxx.inklist list all incomplete die,
					and...
					added auto-generation of discrete, single-
					chip probe passes from a single button click
	07/20/06	mm		changed new pick/inklists to show number,
					not coordinates
	07/25/06	mm		modified probe output file to seek probed-chip(s)
					in secondary when it/they do not exist in the primary
	07/25/06B	mm		modified refY movement above the secondary ref site,
					fixed bad prbErr call in prbChipProbeFile
        02/06/09	mfp		procedure prbChipProbeMap
					  Added code to capture capPad (ASML) Layer in wafer_4
					  Added code to move capPad Layer by  prbpl->wafOfsX : prbpl->wafOfsY


	I s s u e s

	single-probe-pass chip-list file: 
	x-y numbers for non-tested chips are all -1, -1... OK?


	C o d e   O u t l i n e

	initialization of global symbol 'prbpl
	main program
	ui forms code
	proc to load data from xyn.il
	top-level pass generation code
	ffs chip-probe drawing generation
	prober output file generation
	chip list file generation for single-chip probe pass
	log file and messaging

*/


;-----------------------------------------------------------------------
;   	global data structure

unless( and( boundp( 'prbpl) listp( prbpl))
  prbpl = '( nil

;-----	generally constant parameters:
	logfn			"prb.log"	; log file name

;	parameters obtained from xynumbers.dpl:

	waferLib		nil		; library for wafer outlines
	waferCell		nil		; cell name for wafer outline
	libName			nil		; reticle library name
	retName			nil		; reticle cell name
	retW			nil		; reticle width um
	retH			nil		; reticle height um
	mapName			nil		; wafer map cell name
	wafName			nil		; wafer drawing cell name
	flatName		nil		; flattened wafer cell name
	dropinName		nil		; name of drop-in reticle
	ret00X			nil		; xy coords of site (0 0)
	ret00Y			nil
	waf00X			nil		; start posn of wafer outline
	waf00Y			nil
	wafOfsX			nil		; xy offset for max chip count
	wafOfsY			nil
	nCols			nil		; number of sites horizontally
	nRows			nil		; number of sites vertically
	dropinSites		nil		; i/j pairs of drop-in sites
	retChipList		nil		; reticle chip data
	dropinChipList		nil		; drop-in chip data
	mergedChipList		nil		; combined primary/secondary chips

;	strictly local parameters:

	nPasses			0		; number of multi-chip passes
	pass1			nil		; one of these for each pass

	)
)

;	prbLogGlobals
;	writes global data dpl to log file

procedure( prbLogGlobals()
  let( ( p)

    prbLog( "prb global parameters:")
    p = cdr( prbpl)
    while( p
;     don't echo list-type attributes:
      unless( cadr( p) && listp( cadr( p))
	prbLog( "   %-20s     %L" get_string( car( p)) cadr( p))
      )
      p = cddr( p)
    )
    prbLog( "end of global parameters:")
  )
)


;-----------------------------------------------------------------------
;	main program

procedure( prbout()

;   create the library prompt form when nec:
    unless( prbpl->form1 prbCreateForm1())

;   prompt for the reticle library:
    when( hiDisplayForm( prbpl->form1) && prbpl->form1->lb->value

;     get the library name from the form:
      prbpl->libName = car( prbpl->form1->lb->value)

;     form the release directory path:
      prbpl->relDir = strcat( ddGetObjReadPath( ddGetObj( prbpl->libName)) 
			      "/release/")
      prbLog( "release directory:  %s" prbpl->relDir)

;     open the log file:
      prbLogOpen()

;     read the properties file saved by xyn.il:
      cond(
        ( prbLoadXynDpl()

; 	  write the properties to the log file:
	  prbLogGlobals()

;	  create the main ui form when nec:
	  unless( prbpl->form2 prbCreateForm2())

;	  determine the default reference reticle:
	  prbChooseReferenceSite()

;	  set the non-editable values in the form:
	  foreach( p '( libName retName dropinName nChips nCoupons refX refY)
	    get( prbpl->form2 p)->value = get( prbpl p)
	  )

;	  display it:
	  hiDisplayForm( prbpl->form2)	

;	  close the wafer cellviews:
	  when( prbpl->mapCV dbClose( prbpl->mapCV))
	  when( prbpl->wafCV dbClose( prbpl->wafCV))
	  when( prbpl->flatCV dbClose( prbpl->flatCV))
	)
	( t
	  prbErr( "Failed to open drawings from xynums.  Cannot proceed.")
	  prbMsg( "It appears you need to run xynums (again).")
	  prbout()
	)
      )

;     close the log:
      prbLogClose()
      t
    )
)


;-----------------------------------------------------------------------
;	ui forms

procedure( prbCreateForm1()

  prbpl->form1 = hiCreateForm( 'PRBFORM1 "PRBOUT" ""
    list(
	list( hiCreateListBoxField( ?name 'lb ?prompt
		"Select the reticle library" ?value nil
		?choices sort( ddGetLibList()~>name 'alphalessp))
		10:10 400:250 200)
	))
)

procedure( prbCreateForm2()
  let( ( w1 w2)

  w1 = 150
  w2 = 200
  prbpl->form2 = hiCreateForm( 'PRBFORM2 "PRBOUT" ""
    list(
	list( hiCreateLabel( ?name 'l1 ?labelText "Library")
		10:15 w1:25 0)
	list( hiCreateStringField( ?name 'libName ?value "" 
		?prompt "" ?editable nil)
		w1+10:10 w2:25 0)
	list( hiCreateLabel( ?name 'l2 ?labelText "Primary Reticle")
		10:40 w1:25 0)
	list( hiCreateStringField( ?name 'retName ?value ""
		?prompt "" ?editable nil)
		w1+10:35 w2:25 0)
	list( hiCreateLabel( ?name 'l3 ?labelText "Drop-In Reticle")
		10:65 w1:25 0)
	list( hiCreateStringField( ?name 'dropinName ?value ""
		?prompt "" ?editable nil)
		w1+10:60 w2:25 0)
	list( hiCreateLabel( ?name 'l4 ?labelText "No. of Different Chips")
		10:90 w1:25 0)
	list( hiCreateIntField( ?name 'nChips ?value 0
		?prompt "" ?editable nil)
		w1+10:85 w2:25 0)
	list( hiCreateLabel( ?name 'l5 ?labelText "No. of Coupons")
		10:120 w1:25 0)
	list( hiCreateIntField( ?name 'nCoupons ?value 0
		?prompt "" ?editable nil)
		w1+10:115 w2:25 0)
	list( hiCreateLabel( ?name 'l6 ?labelText "Reference Site")
		10:145 w1:25 0)
	list( hiCreateIntField( ?name 'refX ?prompt "X" ?value 0)
		w1+10+10:140 w2/2-10:25 15)
	list( hiCreateIntField( ?name 'refY ?prompt "Y" ?value 0)
		10+w1+w2/2+10:140 w2/2-10:25 15)
	list( hiCreateButton( ?name 'discreteCB ?buttonText "Create Discrete Maps"
		?callback "prbDiscreteMapsCB()")
		w1+10:170 w2:25 0)
	list( hiCreateIntField( ?name 'nPasses ?value 0
		?prompt "No. Multi-chip Passes" ?callback "prbNPCB()")
		10:195 w1+w2:25 w1)
	))

    hiSetFormMinMaxSize( prbpl->form2 '( 420  250) '( 420 525))
    prbNPCB()
  )
)

procedure( prbNPCB()
  let( ( form np w1 w2 y fl)

    form = prbpl->form2
    w1 = 150
    w2 = 200
    np = max( 0 form->nPasses->value)
    form->nPasses->value = np
    when( np < prbpl->nPasses
      for( i np + 1 prbpl->nPasses
	foreach( p '( la ba na va)
	  hiDeleteField( form concat( p i))
	)
      )
    )

    prbpl->nPasses = np
    y = 225
    for( i 1 prbpl->nPasses
      unless( get( form concat( 'la i))
	fl = cons(
	  list( hiCreateLabel( ?name concat( 'la i) ?labelText
		sprintf( nil "Pass %d" i))
		10:y+5 50:25 0) fl)
	fl = cons(
	  list( hiCreateButton( ?name concat( 'ba i) ?buttonText "Define"
		?callback sprintf( nil "prbSCCB( %d)" i))
		70:y+5 80:25 0) fl)
	fl = cons(
	  list( hiCreateStringField( ?name concat( 'na i) ?prompt "" ?value ""
		?editable nil)
		w1+10:y w2:25 0) fl)
	fl = cons(
	  list( hiCreateButton( ?name concat( 'va i) ?buttonText "View"
		?callback sprintf( nil "prbViewCB( %d)" i))
		w1+w2+10:y+5 50:25 0) fl)
      )
      y = y + 25
    )
    when( fl hiAddFields( form fl))
  )
)

procedure( prbSCCB( passNum)
  prog( ( form pass sel nfld chipNum ffsName chipdpl)

;   create the selection form when nec:
    unless( prbpl->form3
      prbpl->form3 = hiCreateForm( 'PRBFORM3 "" ""
	list( list( hiCreateListBoxField( ?name 'lb ?prompt "" 
			?choices prbpl->chipNames
			?value nil ?multipleSelect t) 10:10 250:250 0)))
    )
    form = prbpl->form3

;   get the reference site numbers from the ui form:
    prbpl->refX = prbpl->form2->refX->value
    prbpl->refY = prbpl->form2->refY->value

;   confirm that the reference site is a drop-in location:
    unless( member( list( prbpl->refX prbpl->refY) prbpl->dropinSites)
      prbErr( "Specified reference site is not a drop-in location!")
      return( nil)
    )

;   make the probe-pass file name editable while the pass is being defined:
    nfld = get( prbpl->form2 concat( 'na passNum))
    putprop( nfld t 'editable)

;   get the current chip selection for this pass:
    pass = or( get( prbpl concat( 'pass passNum)) list( nil))

;   set the list of chips to select, omit chips from other passes:
    form->lb->value = nil
    form->lb->choices = prbGetPassChipsList( passNum)

;   preset the field:
    hiSetFormName( prbpl->form3 sprintf( nil "Pass %d" passNum))
    foreach( chip pass->chips 
      when( member( chip form->lb->choices) sel = cons( chip sel))
    )
    form->lb->value = sel

    when( hiDisplayForm( form)
      pass->chips = form->lb->value
      pass->number = passNum

;     update the name field:
      caseq( length( pass->chips)
	( 0
	  ffsName = ""	  
	)
	( 1
;	  when the pass involves only one chip,
;	  get the 2-digit number from the chip name, use that in the ffs name:
	  chipNum = car( last( parseString( car( pass->chips) "_")))
	  ffsName = sprintf( nil "%s_ffsmap_%s" prbpl->retName chipNum)
	)
	( t
;	  when multiple chips are handled in the pass, 
;	  use _xN instead of chip number where N is the pass number:
	  ffsName = sprintf( nil "%s_ffsmap_x%d" prbpl->retName passNum)
	)
      )

;     if the user has typed-in a name, use it instead:
      cond(
	( parseString( nfld->value)
	  pass->name = nfld->value
	)
	( t
	  nfld->value = ffsName
	  pass->name = ffsName
	)
      )
;     determine the chip-type:  chip or coupon
;     this uses the 1st selected chip and assumes the rest are same type!
      chipdpl = car( exists( c prbpl->mergedChipList c->name == car( pass->chips)))
      pass->chipType = chipdpl->chipType

;     save the pass data on the global dpl:
      putprop( prbpl pass concat( 'pass passNum))

;     generate the outputs for this pass:
      when( parseString( ffsName) prbGeneratePass( pass))
    )

;   set the name field back to being non-editable:
    putprop( nfld nil 'editable)
  )
)

procedure( prbViewCB( passNum)
  let( ( pdpl win)

    pdpl = get( prbpl concat( 'pass passNum))
    when( pdpl && ddGetObj( prbpl->libName pdpl->name "layout")
      win = hiOpenWindow( ?bBox list( 500:200 1200:1000))
      geOpen( ?window win ?lib prbpl->libName ?cell pdpl->name
	      ?view "layout" ?viewType "maskLayout")
    )
    when( isFile( pdpl->mapName)
      view( pdpl->mapName list( 25:600 425:1000))
    )
    when( isFile( pdpl->inkName)
      view( pdpl->inkName list( 25:50 425:450))
    )
  )
)

procedure( prbGetPassChipsList( passnum)
  let( ( tested pdpl)

;   build the list of chips already tested in other passes:
    for( i 1 prbpl->nPasses
      unless( i == passnum
	when( (pdpl = get( prbpl concat( 'pass i)))
	  foreach( chip pdpl->chips tested = cons( chip tested))
	)
      )
    )

    reverse( setof( chip prbpl->chipNames null( member( chip tested))))
  )
)

procedure( prbDiscreteMapsCB()
  let( ( pass chipNum passNum)

;   generate a discrete probe pass for each actual chip:
    prbMsg( "Generating discrete probe passes for each chip...")

;   get the reference site numbers from the ui form:
    prbpl->refX = prbpl->form2->refX->value
    prbpl->refY = prbpl->form2->refY->value

    foreach( chip prbpl->mergedChipList
      when( chip->chipType == "chip"

	pass = list( nil)
	pass->chips = list( chip->name)
	chipNum = car( last( parseString( chip->name "_")))
	passNum = car( errsetstring( chipNum))
	cond(
	  ( passNum
	    pass->number = passNum
	    pass->name = sprintf( nil "%s_ffsmap_%s" prbpl->retName chipNum)
	    pass->chipType = chip->chipType

;	    save the pass data on the global dpl:
	    putprop( prbpl pass concat( 'pass passNum))

;	    generate the outputs for this pass:
	    prbMsg( "Generating discrete probe pass %s..." pass->name)
	    prbGeneratePass( pass)
	    prbMsg( "%s done." pass->name)
	  )
	  ( t
	    prbErr( "Failed to parse number of chip %s" chip->name)
	    prbMsg( "No discrete map was automatically created for chip %s" chip->name)
	  )
	)
      )
    )
    prbMsg( "Done generating discrete probe passes for each chip.")
  )
)


;-----------------------------------------------------------------------

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

procedure( prbCountChips()
  let( ( chips coupons)

    chips = 0
    coupons = 0
    prbpl->chipNames = foreach( mapcar chip prbpl->mergedChipList
      case( chip->chipType
	( "chip"	chips = chips + 1)
	( "coupon"	coupons = coupons + 1)
      )
      chip->name
    )
    prbpl->nCoupons = coupons
    prbpl->nChips = chips
  )
)

procedure( prbChooseReferenceSite()
  let( ( llDropinSite temp)

;   sort the drop-in sites to find the lower-left one:
    temp = copy( prbpl->dropinSites) 
    llDropinSite = car( sort( temp 'xynYxSort))

    unless( llDropinSite
      prbErr( "No drop-in sites were specified in xynums!")
    )

;   set the reference site to this drop-in:
    prbpl->refX = car( llDropinSite)
    prbpl->refY = cadr( llDropinSite)
    prbMsg( "selecting reference site %d %d" prbpl->refX prbpl->refY)
  )
)


;-----------------------------------------------------------------------
;	generate pass

procedure( prbGeneratePass( pdpl)
  let( ( mapDir mapName)

;   ensure the release/maps directory exists:
    mapDir = strcat( prbpl->relDir "maps/")
    unless( or( isDir( mapDir) createDir( mapDir))
      prbErr( "Failed to create directory %s" mapDir)
    )

;   form the map file path/name (pdpl->name is the ffs-map cellview name)
    mapName = parseString( pdpl->name "_")
    mapName = buildString( list( car( mapName) caddr( mapName) cadddr( mapName)) "_")
    pdpl->inkName = strcat( mapDir mapName ".ink")
    pdpl->mapName = strcat( mapDir mapName ".ffs")
    pdpl->pickList = strcat( mapDir mapName ".picklist")
    pdpl->inkList = strcat( mapDir mapName ".inklist")

    when( pdpl->chips

;	for production reticles, the reference site is immed. above the specified site:
	when( pdpl->chipType == "chip" prbpl->refY = prbpl->refY + 1)

;	generate the ffsmap drawing:
	prbChipProbeMap( pdpl)

;	generate the prober output file:
	prbChipProbeFile( pdpl)

;	for single-chip passes, write the chip list file:
	when( length( pdpl->chips) == 1
	  prbChipListFile( pdpl)
	)

;	reset the reference site to its original value (the secondary):
	when( pdpl->chipType == "chip" prbpl->refY = prbpl->refY - 1)

;	re-save the ffsmap dwg to avoid bogus "save?" pop-up:
	dbSave( prbpl->mapCV)
    )
  )
)


;-----------------------------------------------------------------------
;	ffs chip-probe drawing generation

;	prbChipProbeMap
;	creates ffs map cellview for a probe pass

procedure( prbChipProbeMap( pdpl)
  let( ( chipnum cellName cv ihr ihd ihcl nums box m chips nc ll x y s partial ASMLcapPad shape)

    cellName = pdpl->name
    chipnum = car( last( parseString( cellName "_")))

;   open the new cellview:
    cv = dbOpenCellViewByType( prbpl->libName cellName "layout" "maskLayout" "w")

;   get the instHeader for reticles in the wafer dwg:
    ihr = car( exists( i prbpl->wafCV~>instHeaders 
		i~>cellName == strcat( prbpl->retName "_xyn")))

;   get the instHeader for dropins in the wafer dwg:
    ihd = car( exists( i prbpl->wafCV~>instHeaders 
		i~>cellName == strcat( prbpl->dropinName "_xyn")))

;   get the instHeaders for edge chips:
    ihcl = setof( i prbpl->wafCV~>instHeaders 
		 member( i~>cellName pdpl->chips))

    cond(
      ( null( cv)
	prbErr( "failed to create %s/%s/layout" prbpl->libName cellName)
	nil
      )
      ( null( ihr)
	prbErr( "failed to find reticle instances in %s/%s/layout"
		prbpl->libName prbpl->wafName)
	nil
      )
/*	THIS SEEMS TO MERELY INTERFERE WITH COUPON PROBE PASSES...
      ( null( ihcl)
	prbErr( "failed to find chip instances in %s/%s/layout"
		 prbpl->libName prbpl->wafName)
	nil
      )
*/
      ( t
	prbMsg( "creating ffs map cellview %s..." cellName)

;	place, derive, and position the wafer outline:
	xynPlaceOutline( cv)
	xynSetWaferPosition( cv)
	dbMoveFig( xynpl->wafer cv list( prbpl->wafOfsX : prbpl->wafOfsY "R0"))
	dbMoveFig( xynpl->ring  cv list( prbpl->wafOfsX : prbpl->wafOfsY "R0"))

;   Capture ASML capPad Layers
	ASMLcapPad = car( exists( lpp cv~>layerPurposePairs lpp~>layerName == "capPad"))~>shapes
			      
	when(ASMLcapPad
	  foreach( shape ASMLcapPad
	    dbMoveFig( shape cv list( prbpl->wafOfsX : prbpl->wafOfsY "R0"))
	  )
	)
	
;	label the side with the chip number:
	dbCreateLabel( cv "text" 
			list( 0 - prbpl->exclusionRing 
			      prbpl->waf00Y + prbpl->waferum / 2)
			sprintf( nil "chip_%s" chipnum)
			"lowerCenter" "R90" "stick" prbpl->ffsmapChipLabelSize)

;	place rects for full reticles and complete edge chips
;	based on the full wafer map drawing...
;	first draw the full reticles:
	nc = 0
	foreach( inst ihr~>instances

	  box = xynSizeBox( inst~>bBox -500)
	  dbCreateRect( cv prbpl->ffsmapLayer1 box)

;	  get the chip instances within this reticle:
	  chips = setof( i dbGetOverlaps( prbpl->flatCV 
					  xynSizeBox( inst~>bBox -1 - prbpl->retOlap))
			 and( member( i~>cellName pdpl->chips)
			      i~>onWafer == 2))
	  when( chips
;	    find the LL-most chip's x-y number and label it:
	    nums = sort( foreach( mapcar c chips list( c~>iX c~>jY)) 'xynYxSort)
	    dbCreateLabel( cv "text" car( box)
			   sprintf( nil "%d-%d" caar( nums) cadar( nums))
			   "lowerLeft" "R0" "stick" prbpl->ffsmapNumSize)

;	    count the total number of probed chips:
	    nc = nc + length( nums)
	  )
	)

;	place rects and crosses at the drop-in sites:
	foreach( inst ihd~>instances
	  box = xynSizeBox( inst~>bBox -500)
	  dbCreateRect( cv prbpl->dropinLayer box)
	  m = (caar( box) + caadr( box)) / 2
	  dbCreateLine( cv prbpl->crossLayer 
		list( list( m cadar( box) + prbpl->rectUndersize)
		      list( m cadadr( box) - prbpl->rectUndersize)))
	  m = (cadar( box) + cadadr( box)) / 2
	  dbCreateLine( cv prbpl->crossLayer 
		list( list( caar( box) + prbpl->rectUndersize m)
		      list( caadr( box) - prbpl->rectUndersize m)))

;	  get the chip instances within this dropin site:
	  chips = setof( i dbGetOverlaps( prbpl->flatCV
				xynSizeBox( inst~>bBox -1 - prbpl->retOlap))
			 member( i~>cellName pdpl->chips))
	  when( chips
;	    find the LL-most chip's x-y number and label it:
	    nums = sort( foreach( mapcar c chips list( c~>iX c~>jY)) 'xynYxSort)
	    dbCreateLabel( cv "text" car( box)
			   sprintf( nil "%d-%d" caar( nums) cadar( nums))
			   "lowerLeft" "R0" "stick" prbpl->ffsmapNumSize)

;	    count the total number of probed chips:
	    nc = nc + length( nums)
	  )
	)

;	place rects for edge chips:
	foreach( ihc ihcl
	  foreach( inst ihc~>instances
	    when( xynIsFullRect( inst~>bBox)
	      dbCreateRect( cv prbpl->ffsmapLayer1
			    xynSizeBox( inst~>bBox -500))
	      nc = nc + 1
	    )
	  )
	)

;	label it:
;	determine the number of partial reticles (this program doesn't care!):
	partial = 0
	for( iX 0 prbpl->nCols
	  for( jY 0 prbpl->nRows
	    when( xynIsPartialSite( iX jY) partial = partial + 1)
	  )
	)

;	top label:
	sprintf( ll "%d %ss can be probed in %d full and %d partial reticles"
		 nc pdpl->chipType length( ihr~>instances) partial)
	dbCreateLabel( cv "text" list( 0 prbpl->waferum * 1.0) ll "lowerLeft"
			"R0" "stick" prbpl->ffsmapChipLabelSize)

;	side labels:
	x = prbpl->waferum * 1.0
	y = prbpl->waferum * 0.9
	s = prbpl->ffsmapChipLabelSize * 1.2
        dbCreateLabel( cv "text" x:y 
	    sprintf( nil "Design Name= %s" prbpl->libName)
	    "lowerLeft" "R0" "stick" prbpl->ffsmapChipLabelSize)
        y = y - s
            dbCreateLabel( cv "text" x:y 
	    sprintf( nil "retXm= %f" prbpl->retW)
	   "lowerLeft" "R0" "stick" prbpl->ffsmapChipLabelSize)
        y = y - s
        dbCreateLabel( cv "text" x:y 
	    sprintf( nil "retYm= %f" prbpl->retH)
	    "lowerLeft" "R0" "stick" prbpl->ffsmapChipLabelSize)
        y = y - s
        dbCreateLabel( cv "text" x:y 
	    sprintf( nil "waferShiftX= %f" prbpl->wafOfsX)
	    "lowerLeft" "R0" "stick" prbpl->ffsmapChipLabelSize)
        y = y - s
            dbCreateLabel( cv "text" x:y 
	    sprintf( nil "waferShiftY= %f" prbpl->wafOfsY)
	    "lowerLeft" "R0" "stick" prbpl->ffsmapChipLabelSize)
        y = y - s
        dbCreateLabel( cv "text" x:y 
	    sprintf( nil "Date= %s" getCurrentTime())
	    "lowerLeft" "R0" "stick" prbpl->ffsmapChipLabelSize)

	dbSave( cv)
	prbpl->mapCV = cv
;	don't close it, need the ring and wafer shapes for on-wafer tests

	pdpl->nChipsProbed = nc

	prbMsg( "created %s/%s/layout" prbpl->libName cellName)
      )
    )
  )
)


;-----------------------------------------------------------------------
;	prober output file generation

;	prbChipProbeFile
;	creates the prober output file for a probe pass

procedure( prbChipProbeFile( pdpl)
  let( ( fp nret refnum flip iXs)

;   determine the number of complete reticles containing these chips:
    nret = prbGetChipReticleCount( pdpl->chips)

;   open the file:
    fp = outfile( pdpl->mapName)
    cond(
      ( null( fp)
	prbErr( "failed to write file %s" pdpl->mapName)
	nil
      )
      ( t
;	write the header:
	prbMsg( "writing %s..." pdpl->mapName)
	fprintf( fp "*  Xstep          Ystep\n")
	fprintf( fp "   %f  %f\n" prbpl->retW prbpl->retH)
	fprintf( fp "*  Units\n")
	fprintf( fp "   1\n")
	fprintf( fp "*  # of Die\n")
	fprintf( fp "   %d\n" nret)
	fprintf( fp "*  Die Loc. / Aeble Numbers\n")

;	write the prober steps for each reticle site:
;	cycle through reticle sites in serpentine fashion:
	for( jY 0 prbpl->nRows
	  for( iX 0 prbpl->nCols
	    iXs = if( flip prbpl->nCols - iX iX)
	    prbChipProbeStep( fp iXs jY pdpl)
	  )
	  flip = null( flip)
	)

;	write the footer:
;	get the lower-left-most copy of this chip(s) from the reference primary site:
	refnum = prbGetLLChipNums( prbpl->refX prbpl->refY pdpl->chips)

;	if that fails, look for it in the secondary site right below it:
	unless( refnum
	  refnum = prbGetLLChipNums( prbpl->refX prbpl->refY - 1 pdpl->chips)
	)
;	and if that fails too, it's an error:
	unless( refnum
	  prbErr( sprintf( nil 
	     "Failed to find chip(s) %L in primary or secondary sites!" pdpl->chips))
	)

	fprintf( fp "* Starting Position (index and chip number)\n")
	fprintf( fp "  %d %d %d %d\n" prbpl->refX prbpl->refY 
		 or( car( refnum) 0) or( cadr( refnum) 0))

;	close:
	close( fp)
	prbMsg( "wrote %s" pdpl->mapName)
      )
    )
  )
)

procedure( prbGetChipReticleCount( chipNames)
  let( ( nr)

    nr = 0
    for( iX 0 prbpl->nCols
      for( jY 0 prbpl->nRows
	cond(
;	    count all full reticles:
	  ( xynIsFullSite( iX jY)
	    nr = nr + 1
	  )
;	    count partial reticles that have complete chips of given name:
	  ( xynIsPartialSite( iX jY) && prbGetRetSiteFullInstances( iX jY chipNames)
	    nr = nr + 1
	  )
	)
      )
    )
    nr
  )
)

procedure( prbGetRetSiteInstances( iX jY chipNames)

;   return the chip instances within this reticle site:
    setof( i dbGetOverlaps( prbpl->flatCV 
			    xynSizeBox( xynSiteBox( iX jY)
					-1 - prbpl->retOlap))
	   member( i~>cellName chipNames))
)

procedure( prbGetRetSiteFullInstances( iX jY chipNames)

;   return the setof of chip instances that are complete:
    setof( i prbGetRetSiteInstances( iX jY chipNames) xynIsFullObject( i))
)

procedure( prbGetLLChipNums( retX retY chipL)
  let( ( box chips nums)

;   get the chip instances within this reticle site:
    box = xynSizeBox( xynSiteBox( retX retY) -1 - prbpl->retOlap)
    chips = setof( i dbGetOverlaps( prbpl->flatCV box) 
		   and( i~>onWafer == 2
			member( i~>cellName chipL)))

;   get their wafer number pairs and sort them, 1st is lower-left:
    nums = foreach( mapcar c chips list( c~>iX c~>jY))
    car( sort( nums 'xynYxSort))
  )
)

procedure( prbChipProbeStep( fp iX jY pdpl)
  let( ( chips refdie refxy chipType nSteps lxy lx ly px py dx dy refName)

	when( xynIsFullSite( iX jY) || xynIsPartialSite( iX jY)

;	  get the chip instances in this reticle site:
	  chips = prbGetRetSiteInstances( iX jY pdpl->chips)

;	  drop-in sites may lack chips:
	  when( chips

;	    sort them first by y then x:
	    chips = sort( chips 'xynInstYxSort)

;	    determine if the reference chip 
;	    (lower-left chip at this site) is complete,
;	    if so get its (x,y) numbers, else set them to (0,0)
	    refdie = car( chips)
	    refxy  = if( xynIsFullObject( refdie) 
			 list( refdie~>iX refdie~>jY) '( 0 0))

;	    get the reference location of the ref chip:
	    chipType = car( exists( c prbpl->mergedChipList 
				    c->name == refdie~>cellName))->chipType
	    case( chipType
;		coupons use a label "align+point" in an instance within the coupon:
	      ( "coupon"
		lxy = prbGetCouponAlignPt( refdie~>cellName)
		lx = car( lxy)
		ly = cadr( lxy)
	      )
;		production chips just use the chip origins:
	      ( "chip"
	        lx = car( refdie~>xy)
	        ly = cadr( refdie~>xy)
	      )
	    )

;	    now drop the reference chip from the list:
	    refName = car( chips)~>cellName
	    chips = cdr( chips)

;	    get the set of complete chips at this site:
	    chips = setof( i chips xynIsFullObject( i))

;	    only write a block for sites that have at least one full chip:
;	    (handle the case where the only complete chip is the reference die)
	    when( chips || refxy != '( 0 0)

;	      determine the number of intra-reticle steps,
;	      this is the number of tested chips (excluding the reference chip):
	      nSteps = length( chips)

;	      reticle header line:
	      case( chipType
		( "coupon"
		  fprintf( fp "%d %d %d %d %d %s\n" 
			   iX jY car( refxy) cadr( refxy) nSteps
		    car( last( parseString( refName "_"))))
		)
		( t
		  fprintf( fp "%d %d %d %d %d\n" 
			   iX jY car( refxy) cadr( refxy) nSteps)
		)
	      )

;	      write the intra-reticle steps:
	      foreach( chip chips
		case( chipType
		  ( "coupon"
		    lxy = prbGetCouponAlignPt( chip~>cellName)
		    px = car( lxy)
		    py = cadr( lxy)
		  )
		  ( t
		    px = car( chip~>xy)
		    py = cadr( chip~>xy)
		  )
		)
	        dx = (px - lx) * 1e-3
	        dy = (py - ly) * 1e-3
	        lx = px
	        ly = py
		case( chipType
		  ( "coupon"
	            fprintf( fp " %f %f %d %d %s\n" dx dy chip~>iX chip~>jY
				car( last( parseString( chip~>cellName "_"))))
		  )
		  ( t
	            fprintf( fp " %f %f %d %d\n" dx dy chip~>iX chip~>jY)
		  )
		)
	      )
	    )
	  )
	)
  )
)

procedure( prbGetCouponAlignPt( chipName)
  let( ( cv inst label point chip)

;   open the coupon:
    cv = dbOpenCellViewByType( prbpl->libName chipName "layout" "maskLayout")
    cond(
      ( null( cv)
	prbErr( "failed to open coupon %s/%s/layout" prbpl->libName chipName)
	'(0 0)
      )
;	find the alignment label within the coupon chip itself:
      ( (label = car( exists( j cv~>shapes
                              and( j~>objType == "label"
                                   j~>theLabel == "align+point"))))

;	get the chip's location within the drop-in:
	chip = car( exists( c prbpl->mergedChipList c->name == chipName))

;	return the label's origin WRT the drop-in reticle:
	list( car( label~>xy) + caar( chip->chipPosn) 
	      cadr( label~>xy) + cadar( chip->chipPosn))
      )
;	find the alignment label within an instance of the chip:
      ( (inst = car( exists( i cv~>instances
                     (label = car( exists( j i~>master~>shapes
                                           and( j~>objType == "label"
                                                j~>theLabel == "align+point")))))))

;	get the align point within the chip's cell:
	point = dbTransformPoint( label~>xy inst~>transform)

;	get the chip's location within the drop-in:
	chip = car( exists( c prbpl->mergedChipList c->name == chipName))

;	return the label's origin WRT the drop-in reticle:
	list( car( point) + caar( chip->chipPosn) cadr( point) + cadar( chip->chipPosn))
      )
      ( t
	prbErr( "failed to find align+point label below coupon %s" chipName)
	'( 0 0)
      )
    )
  )
)


;-----------------------------------------------------------------------
;	generate chip list file for single-chip probe pass

procedure( prbChipListFile( pdpl)
  let( ( fp gp bp jYs chipNum flip)

;   produce 3 files:
;   inkName contains both inked and picked chips,
;   these are separated in the other two files:
    fp = outfile( pdpl->inkName)
    gp = outfile( pdpl->pickList)
    bp = outfile( pdpl->inkList)
    cond(
      ( null( and( fp gp bp))
	prbErr( "failed to write file %s" pdpl->inkName)
	nil
      )
      ( t
;	extract the chip number from the ink-list name
;	(NOTE only single-chip passes are considered here)
	chipNum = car( last( parseString( pdpl->inkName "_")))
	chipNum = car( parseString( chipNum "."))

;	write the prober steps for each reticle site:
;	cycle through reticle sites in serpentine fashion:
	for( iX 0 prbpl->nCols
	  for( jY 0 prbpl->nRows
	    jYs = if( flip prbpl->nRows - jY jY)
	    prbChipListStep( fp gp bp iX jYs chipNum pdpl)
	  )
	  flip = null( flip)
	)

;	close files:
	close( fp)  close( gp)  close( bp)
	prbMsg( "wrote %s" pdpl->inkName)
	prbMsg( "wrote %s" pdpl->pickList)
	prbMsg( "wrote %s" pdpl->inkList)
      )
    )
  )
)

procedure( prbChipListStep( fp gp bp iX jY chipNum pdpl)
  let( ( chips xnum ynum xpos ypos inked)

    when( xynIsFullSite( iX jY) || xynIsPartialSite( iX jY)

;     get the chip instances in this reticle site:
      chips = prbGetRetSiteInstances( iX jY pdpl->chips)

;     sort them first by y then x:
      chips = sort( chips 'xynInstYxSort)

;     write them to the list file:
      foreach( chip chips

	xpos = car( chip~>xy) * 1e-3
	ypos = cadr( chip~>xy) * 1e-3
	cond(
	  ( chip~>onWafer == 2
	    xnum = chip~>iX
	    ynum = chip~>jY
	    inked = 0
	    fprintf( gp "%s   x = %4d   y = %4d \n" chip~>cellName xnum ynum)
	  )
	  ( t
	    xnum = -1
	    ynum = -1
	    inked = 1
	    fprintf( bp "%s   x = %4d   y = %4d \n" chip~>cellName xnum ynum)
	  )
	)
	fprintf( fp "%s %-2d %-2d %f %f %d\n"
		 chipNum xnum ynum xpos ypos inked)
      )
    )
  )
)


;-----------------------------------------------------------------------
;  	log file and messaging

;	prbLogOpen		opens the main log file
;	prbLogClose		closes it
;	prbConfirm		prompts user to confirm w dialog box
;	prbMsg			writes message to ciw and log file
;	prbLog			writes message to log file only
;	prbErr			writes error to ciw and log file

procedure( prbLogOpen()

    prbLogClose()
    cond(
      ( (prbpl->logfp = outfile( strcat( prbpl->relDir prbpl->logfn)))
	fprintf( prbpl->logfp "%s prb log file opened\n"
		 getCurrentTime())
      )
      ( t
	prbErr( "failed to create log file %s" 	
		strcat( prbpl->relDir prbpl->logfn))
      )
    )

    prbpl->errMsg = ""
)

procedure( prbLogClose()

    when( portp( prbpl->logfp)
      prbMsg( "%s log file closed" getCurrentTime())
      close( prbpl->logfp)
      prbpl->logfp = nil
    )
)

procedure( prbConfirm( s @rest r)

    s = apply( 'sprintf cons( nil cons( s r)))
    hiDisplayModalDBox( 'prbCONF "WARNING!" s "" "")
)

procedure( prbMsg( s @rest r)

    s = apply( 'sprintf cons( nil cons( s r)))
    printf( "prb:  %s\n" s)
    when( prbpl->logfp fprintf( prbpl->logfp "%s\n" s))
    prbpl->errMsg = ""
)

procedure( prbLog( s @rest r)

    s = apply( 'sprintf cons( nil cons( s r)))
    when( prbpl->logfp fprintf( prbpl->logfp "%s\n" s))
    prbpl->errMsg = ""
)

procedure( prbErr( s @rest r)

    s = apply( 'sprintf cons( nil cons( s r)))
    unless( strcmp( s prbpl->errMsg) == 0
      hiGetAttention()
      printf( "prb:  ERROR  %s\n" s)
      when( prbpl->logfp fprintf( prbpl->logfp "ERROR  %s\n" s))
      prbpl->errMsg = s
    )
    nil
)

;---- end of prb.il
