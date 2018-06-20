/*	file:	uwBindKeys.il
	date:	04 jan 93 mm

	additional bindkeys for Artist Microwave version 4.2.1.
	.../samples/local/schBindKeys.il and
	.../samples/local/leBindKeys.il should also be loaded.
*/


alias bk hiSetBindKey

;---------------------------------------------------------------------
;	CIW

;	F1					F2	load contexts
;	F3					F4
;	F5					F6
;	F7					F8
;	F9					F10

v = "Command Interpreter"
bk( v 	"<Key>F2" 		"uwLoadContexts()")


;---------------------------------------------------------------------
;	SCHEMATICS & SYMBOLS

foreach( v '( "Schematics" "Symbol")

;	Edge-style select/deselect keys:
bk( v	"<Key>a"		"mouseAddSelectPt()")
bk( v	"Shift<Key>a"		"geAddSelectBox()")
bk( v	"Ctrl<Key>a"		"geSelectAll()")

;	digitization aids:
bk( v	"Shift<Btn1Down>EF" 	"mouseFinishPt()")
bk( v	"SpaceEF"		"applyEnterFun()")

;	edit instance or properties (favors CDF-oriented editing):
bk( v	"None<Btn2Down>(2)" 	"schHiEditInst()")
bk( v	"<Key>q" 		"schHiEditInst()")
bk( v	"Shift<Key>q" 		"geQuerySelSet( hiGetCurrentWindow())")

;	window operations:
bk( v   "<Key>3"                "geDeselectAllFig()")
bk( v   "<Key>q"                "geQuerySelSet( hiGetCurrentWindow())")
bk( v   "<Key>s"                "geSubSelectPoint()")
bk( v	"Shift<Key>z"	"hiZoomRelativeScale( hiGetCurrentWindow() 0.5)")
bk( v	"Ctrl<Key>z"		"hiPrevWinView( hiGetCurrentWindow())")
bk( v	"Ctrl<Key>l" 		"hiRedraw()")
bk( v	"Space" 		"hiRedraw()")
bk( v "Alt<Key>4"       "schHiGridOptions()")
)


;---------------------------------------------------------------------
;	SCHEMATICS

v = "Schematics"

;	design variable support:
bk( v	"<Key>F7" 		"artCellViewDesignVarMenuCB()")
bk( v	"<Key>F8" 		"artCellViewDesignVarSearchMenuCB()")
bk( v	"<Key>F9" 		"artCellViewDesignVarUpdateMenuCB()")

;	hierarchy:
bk( v	"<Key>e"		"schHiDescendEdit()")
bk( v	"Ctrl<Key>h"		"schHiReturn()")

;	Artist simulation start-up:
bk( v	"<Key>s"	"avsiDisplayToolStartupMenuCB( hiGetCurrentWindow())")

;	close window:
bk( v	"<Key>]" 		"hiCloseWindow( hiGetCurrentWindow())")
bk( v	"Shift<Key>]" 		"prog( () schHiCheckandSave() \
         			 hiCloseWindow( hiGetCurrentWindow()))")

bk( v   "<Key>2"                "hiZoomRelativeScale(hiGetCurrentWindow() 2.0)")
bk( v   "<Key>5"                "hiZoomRelativeScale(hiGetCurrentWindow() 0.5)")
bk( v "<Key>b"		"uwdleXProbe()")
bk( v "Ctrl<Key>b"	"geDeleteAllProbe( getCurrentWindow() t)")

;---------------------------------------------------------------------
;---------------------------------------------------------------------
;	AWV
;	f			fit
;	Z			zoom out 2x
;	Btn 1			make current
;	c or ]			close
;	w			open another wave window
;	space			redraw

;	
v = "awv"
bk( v	"<Key>f"		"awviFitMenuCB()")
bk( v	"<Key>]"		"awviCloseWindowMenuCB()")
bk( v	"<Key>c"		"awviCloseWindowMenuCB()")
bk( v	"Shift<Key>z"		"awviZoomOutBy2MenuCB()")
bk( v	"None<Btn1Down>"	"awviMakeWindowCurrentCB()")
bk( v	"Space"			"awviRedrawWindowCB()")
bk( v	"<Key>w"		"awvCreatePlotWindow()")


;---------------------------------------------------------------------
;	LAYOUT

v = "Layout"

;	F1	Cycle snapMode			F2	toggle repeat commands
;	F3	toggle form			F4	toggle partial select
;	F5	deOpen				F6	toggle LSW
;	F7	edit design variables		F8	search design vars
;	F9	update design variables		F10

bk( v	"<Key>F2"		"pfnToggleRepeatCommands()") 
bk( v	"<Key>F6" 
	"if( leIsLSWIconified() leDeiconifyLSW() leIconifyLSW())")
bk( v	"<Key>F7" 		"artCellViewDesignVarMenuCB()")
bk( v	"<Key>F8" 		"artCellViewDesignVarSearchMenuCB()")
bk( v	"<Key>F9" 		"artCellViewDesignVarUpdateMenuCB()")
bk( v	"None<Btn3Down>(2)"	"uwlePopUpSelectLayer()")
bk( v	"None<Btn2Down>(2)" 	"leHiEditProp()")
bk( v	"<Key>Delete" 		"uwleNonModal( \"leHiDelete()\")")
bk( v	"<Key>DeleteEF" 	"uwleNonModal( \"leHiDelete()\")")
bk( v	"<Key>]" 		"hiCloseWindow( hiGetCurrentWindow())")
bk( v	"Shift<Key>]" 		"prog( () geSave() \
         			 hiCloseWindow( hiGetCurrentWindow()))")
bk( v	"Space" 		"hiRedraw()")
bk( v	"<Key>?" 		"convertLabel()")

bk( v	"<Key>0" 		"leHiClearRuler(), hiRedraw()")
bk( v	"<Key>1" 		"hiToggleEnterForm()")
bk( v	"<Key>1EF" 		"hiToggleEnterForm()")
bk( v	"<Key>2"		"hiZoomRelativeScale(hiGetCurrentWindow() 2.0)")
bk( v	"<Key>3"		"geDeselectAllFig()")
bk( v	"<Key>4"		"changeRect()")
bk( v	"<Key>5" 		"hiZoomRelativeScale(hiGetCurrentWindow() 0.5)")
bk( v	"<Key>6"		"hiSaveView(\"default\")")
bk( v	"<Key>7"		"hiRestoreView(\"default\")")
bk( v	"<Key>8"		"changeRect()")
bk( v	"<Key>9"		"roundCorners()")
bk( v	"Shift<Key>0"		"geTogglePartialSelect()")
bk( v	"Shift<Key>1"		"uwleSetGrid( .25)")
bk( v	"Shift<Key>2"		"uwleSetGrid( .50)")
bk( v	"Shift<Key>3"		"uwleSetGrid( 0.1)")
bk( v	"Ctrl<Key>1" 		"uwleSetGrid( 2.0)")    
bk( v	"Ctrl<Key>2" 		"uwleSetGrid( 5.0)")
bk( v	"Ctrl<Key>3"		"uwleSetGrid( 10.0)")
;bk( v	"<Key>1EF" 		"uwleSetGrid( 0.25)")    
bk( v	"<Key>2EF" 		"uwleSetGrid( 0.5)")
bk( v	"<Key>3EF"		"uwleSetGrid( 1.0)")
bk( v	"Shift<Key>1EF"		"uwleSetGrid( 2.0)")
bk( v	"Shift<Key>2EF"		"uwleSetGrid( 5.0)")
bk( v	"Shift<Key>3EF"		"uwleSetGrid( 10.0)")
bk( v	"Alt<Key>4"		"uwleSetGrid(0.0)")
bk( v	"Ctrl<Key>1EF" 		"uwleSetGrid( 20.)")    
bk( v	"Ctrl<Key>2EF" 		"uwleSetGrid( 50.)")
bk( v	"Ctrl<Key>3EF"		"uwleSetGrid( 100.)")

bk( v	"<Key>a"		"mouseAddSelectPt()")
bk( v	"Shift<Key>a"		"geAddSelectBox()")
bk( v	"Ctrl<Key>a"		"geSelectAll()")
bk( v	"Alt<Key>a"     	"arrayGeom()")

bk( v 	"<Key>b"		"uwleGetGrid() pfnCreatePath() uwleSetGrid(snapSize)")
bk( v 	"Shift<Key>b"		"adleHiVerifyIncompleteNets()")
bk( v 	"Ctrl<Key>b"		"geDeleteAllProbe( getCurrentWindow() t)")

bk( v 	"<Key>c"		"uwleGetGrid() leHiCopy() uwleSetGrid(snapSize)")
bk( v 	"Shift<Key>c"		"uwleGetGrid() leHiChop() uwleSetGrid(snapSize)")
bk( v	"Alt<Key>c"		"makeCap()")

bk( v 	"<Key>d"		"leHiDescend()")
bk( v 	"Shift<Key>d"		"ivHiDRC()")

bk( v	"<Key>e"		"uwleGetGrid() leHiCreateEllipse() uwleSetGrid(snapSize)")
bk( v	"Shift<Key>e"		"geHiExplainMarker()")
bk( v	"Ctrl<Key>e"		"leHiEditInPlace()")

bk( v	"<Key>f"		"hiZoomAbsoluteScale(hiGetCurrentWindow() 0.9)")
bk( v	"Shift<Key>f"		"hiZoomAbsoluteScale(hiGetCurrentWindow() 0.9)")
bk( v	"Ctrl<Key>f"		"fitSelMar()")
bk( v 	"Alt<Key>f"		"flattenCells()")
bk( v	"<Key>h"		"geChangeCellView()")

bk( v	"<Key>i"		"leHiCreateInst()")
bk( v	"Shift<Key>i"		"plotQueueStatusForm()")
bk( v   "Alt<Key>i"		"inductor()")
bk( v	"<Key>g" 		"pathLen()")
bk( v	"<Key>gEF"		"leToggleGravity()")
bk( v	"Shift<Key>g" 		"uwleCycleGravity()")
bk( v	"Shift<Key>gEF" 	"uwleCycleGravity()")
bk( v	"Ctrl<Key>g"		"prog( ()\
        leSetEnv( \"gravityOn\" t)\
        leSetEnv( \"gravityType\" list( \"centerline\" \"pin\" \"end\"))\
        leSetEnv( \"gravityAperture\" 10.)\
        leSetEnv( \"gravityDepth\" 2))")
bk( v	"Ctrl<Key>gEF"		"prog( ()\
        leSetEnv( \"gravityOn\" t)\
        leSetEnv( \"gravityType\" list( \"centerline\" \"pin\" \"end\"))\
        leSetEnv( \"gravityAperture\" 10.)\
        leSetEnv( \"gravityDepth\" 2))")

bk( v   "Shift<Key>k"           "skillBanner()")

bk( v	"Shift<Key>l"		"addLabel()")
bk( v	"Alt<Key>l"		"layerArea()")

bk( v	"<Key>m" 		"uwleGetGrid() leHiMove() uwleSetGrid( snapSize)")
bk( v	"Alt<Key>m"		"leHiMakeCell()")
bk( v	"Shift<Key>m" 		"uwleGetGrid() pfnSetHorizontalLock() leHiStretch() \
				pfnRestoreHorizontalLock() uwleSetGrid(snapSize)")
bk( v	"Ctrl<Key>m" 		"uwleGetGrid() leHiMerge() uwleSetGrid(snapSize)")

bk( v	"<Key>n" 		"hiRedraw()")
bk( v	"Shift<Key>n" 		"hiGetCurrentWindow()->stopLevel = 20")
bk( v	"Ctrl<Key>n" 		"hiGetCurrentWindow()->stopLevel = 0")

bk( v	"<Key>o" 		"hiZoomOut()")

bk( v	"<Key>p"		"hiPan()")
bk( v	"Ctrl<Key>p"		"leHiCreatePin()")

bk( v	"Ctrl<Key>q"		"hiQuit()")
bk( v	"Shift<Key>q" 		"geQuerySelSet( hiGetCurrentWindow())")

bk( v	"<Key>r"		"uwleGetGrid() leHiCreateRect() uwleSetGrid(snapSize)")
bk( v	"Shift<Key>r"		"leHiCreateRuler()")
bk( v   "Alt<Key>r"		"removeChangeLayer()")

bk( v	"<Key>s"		"geSubSelectPoint()")
bk( v	"Shift<Key>s"		"geSubSelectBox()")
bk( v	"Ctrl<Key>s"		"geDeselectAll()")
bk( v   "Alt<Key>s"		"leHiSize()")

bk( v	"<Key>t"		"leHiLayerTap()")
bk( v	"Shift<Key>t" 		"uwleGetGrid() leHiCreateTrl() uwleSetGrid(snapSize)")
bk( v	"Ctrl<Key>t" 		"uwleGetGrid() leHiCreateTaper() uwleSetGrid(snapSize)")

bk( v	"<Key>u"		"geReturn()")
bk( v	"Shift<Key>u"		"hiUndo()")


bk( v "<Key>v" 		"adleHiPlaceSingleComponent()")
bk( v "Shift<Key>v"	"adleHiPlaceAllComponents()")
bk( v "Ctrl<Key>v"	"adleHiVerifyMissingDevices()")

bk( v   "Alt<Key>x"             "stackedCapArea()")
bk( v	"<Key>x" 		"uwleGetGrid() kbdMvx() uwleSetGrid(snapSize)")
bk( v	"Shift<Key>x"		"auDeleteTrlDummyInstances( geGetWindowCellView())")

bk( v	"<Key>y" 		"uwleGetGrid() kbdMvy() uwleSetGrid(snapSize)")

bk( v	"<Key>z" 		"hiZoomIn()")
bk( v	"Shift<Key>z"		"hiZoomRelativeScale( hiGetCurrentWindow() 0.5)")
bk( v	"Ctrl<Key>z"		"geSave()")
bk( v   "Alt<Key>z"		"stackedCapArea()")

bk( v	"<Key>," 		"copyToLayer()")
bk( v   "<Key>."                "moveToLayer()")
bk( v	"Shift<Key>comma" 	"pfnToggleHorizontalLock()")
bk( v	"<Key>F1" 		"pfnCyclePathLock")
bk( v   "None<Btn4Down>"	"hiZoomInAtMouse()")
bk( v   "None<Btn5Down>"	"hiZoomOutAtMouse()")


;-------------------------------------------------------------------------
;	local skill referenced by these bindkeys:


;	uwLoadContexts
;	bound to a ciw function key,
;	this will pre-loadthe contexts we're most likely to use

procedure( uwLoadContexts()
  let( ( path)

        path = prependInstallPath( "etc/context")
        foreach( cxt '( "auCore" "schView" "schematic" "cdf"
                        "pCellGen" "le"
                        "asimenv" "librai" "uwExt")
          loadContext( sprintf( nil "%s/%s.cxt" path cxt))
        )
  )
)


;	uwleNonModal
;	within the layout editor, the performs the specified
;	function non-modally so that it doesn't automatically
;	repeat.  this assumes one is normally working with modal On.
 
procedure( uwleNonModal( function)

       	hiiSetCurrentForm( 'leEditorOptionsForm)
	if( leEditorOptionsForm->options->modalCommands->value then
	  leEditorOptionsForm->options->modalCommands->value = nil
	  hiFormDone( leEditorOptionsForm)
          evalstring( function)
       	  hiiSetCurrentForm( 'leEditorOptionsForm)
	  leEditorOptionsForm->options->modalCommands->value = t
	  hiFormDone( leEditorOptionsForm)
        else
          evalstring( function)
        )
)


;	uwleCycleGravity
;	this cycles through some of the more useful types
;	of gravity within the layout editor.  the is particularly
;	useful when bound to key with the EF (enterfunction) option.

uwleGravityDefault = list( "centerline" "pin" "end")

procedure( uwleCycleGravity()
  let( ( old new)

	old = leGetEnv( "gravityType")
        if( length( old) > 1 then
          uwleGravityDefault = old
          new = '("vertex")
        else
          case( car( old)
            ("vertex"           new = '("pin"))
            ("pin"              new = '("centerline"))
            ("centerline"       new = '("edge"))
            (t                  new = uwleGravityDefault)
          )
        )
	leSetEnv( "gravityType" new)
        println( new)
  )
)


;	uwleSetGrid
;	a simple function that sets the X & Y snap size in the
;	layout editor to the specified amount in editor units.
;	if bound to several keys this can make it easy to switch
;	snap size in the middle of digitizing without popping-up a form.

procedure( uwleSetGrid( snapSize)

        hiiSetCurrentForm('leDisplayOptionsForm)
        leDisplayOptionsForm->windowId = hiGetCurrentWindow()
        leDisplayOptionsForm->xSnap->value = snapSize
        leDisplayOptionsForm->ySnap->value = snapSize
        hiFormDone( leDisplayOptionsForm)
)
; created version2 to grab snapSize from form 

procedure( uwleGetGrid()
        snapSize = envGetVal("layout" "xSnapSpacing" 'float)
)



procedure( uwlePopUpSelectLayer()
  let( ( (choices nil) libId form )

	libId = geGetWindowCellView()~>lib
        foreach( l libId~>tech~>layers
          when( l~>number < 126 
            foreach( p l~>prop
              when( p~>name == "auViewTypeList" &&
                    member( "maskLayout" p~>value)
                choices = cons( l~>name choices))
              )
          )
        )

    	hiCreateForm( 'form "Select Mask Layer" "" 
	  list(
	    list( hiCreateCyclicField( ?name 'layer 
	      ?value  car( leGetEntryLayer())
	      ?prompt "Layer" ?choices choices) 0:0 150:25 170)
          ) "ciw"
    	)
    	when( hiDisplayForm( form)
	  leSetEntryLayer(
	    dbGetLayerNum( libId form->layer->value))
    	)
  )
)


;	uwdleXProbe
;	this procedure can be tied to a bind key and executed
;	while pointing at an instance in schematic or layout.
;	if the other view in the workingViewPair (defined by DLE)
;	is open, the corresponding instance (if any) will be
;	highlighted.  this provides a nice cross-probe-devicefunction.

procedure( uwdleXProbe()
  prog( ( cv pcv i window p b)

;	get the current cv:
	when( ! (cv = geGetWindowCellView( hiGetCurrentWindow())) ||
	    ! member( cv~>viewName list( "schematic" "layout"))
	  printf( "udleXprobe must be run from schematic or layout window.\n")
	  return( nil)
	)

;	find the instance pointed to:
	p = hiGetCommandPoint( hiGetCurrentWindow())
	b = list( p  car(p)+.01 : cadr(p)+.01)
	when( length( (i = dbGetOverlaps( cv b))) == 0
	  printf( "No instance was pointed to.\n")
	  return( nil)
	)
	i = car( i)
	printf( "uwdleXProbe instance name: %s\n" i~>name)

;	get the cv of this cellview's pair:
	unless( (pcv = adleGetCellViewPair( cv))
	  printf( "Failed to find paired cellview.\n")
	)

;	find the window containing the pair view:
	window = nil
	foreach( k hiGetWindowList()
	  when( hiGetWindowMenu( k)
	    when( geGetWindowCellView( k) == pcv window = k)
	  )
	)
	unless( window
	  printf( "Paired cellview is not open in a window.\n")
	  return( nil)
	)

;	find the matching instance if it exists and select it:
	p = nil
	foreach( j pcv~>instances
	  when( j~>name ==  i~>name
		hiSetCurrentWindow( window)
		geAddInstProbe( window '("y0" "drawing") j~>xy)
		p = j
          )
	)
	unless( p
	  printf( "uwdleXProbe failed to find matching instance\n")
	  printf( "instances found:\n")
	  println( pcv~>instances~>name)
	  return( nil)
	)
	return( t)
  )
)

procedure( pfnSetHorizontalLock()

	hiiSetCurrentForm('leDisplayOptionsForm)
	leDisplayOptionsForm->windowId = hiGetCurrentWindow()
	pfnHorizontalLockState = leDisplayOptionsForm->segSnapMode->value 
	leDisplayOptionsForm->segSnapMode->value = "orthogonal"
	hiFormDone( leDisplayOptionsForm )
)

procedure( pfnRestoreHorizontalLock()

	hiiSetCurrentForm('leDisplayOptionsForm)
	leDisplayOptionsForm->windowId = hiGetCurrentWindow()
	leDisplayOptionsForm->segSnapMode->value = pfnHorizontalLockState 
	hiFormDone( leDisplayOptionsForm )
)

procedure( pfnToggleHorizontalLock()

	hiiSetCurrentForm('leDisplayOptionsForm)
	leDisplayOptionsForm->windowId = hiGetCurrentWindow()
	if( leDisplayOptionsForm->segSnapMode->value == "orthogonal"
		then leDisplayOptionsForm->segSnapMode->value = "anyAngle"
		else leDisplayOptionsForm->segSnapMode->value = "orthogonal"
	)
	hiFormDone( leDisplayOptionsForm )
)

procedure( pfnCyclePathLock()
	let( (old new)
		hiiSetCurrentForm('le0PathForm)
		le0PathForm->windowId = hiGetCurrentWindow()
		old = le0PathForm->snapMode->value 
		case( old
			("anyAngle" new = "diagonal")
			("diagonal" new = "L90XFirst")
			("L90XFirst" new = "anyAngle")
			(t new = "anyAngle")
		)
		le0PathForm->snapMode->value = new
		println( new )
	)
)

procedure( pfnCreatePath()
    prog(()
        le0PathForm->windowId = hiGetCurrentWindow()
;        le0PathForm->snapMode->value = "diagonal"
       le0PathForm->snapMode->value = "orthogonal"
        leHiCreatePath()
    )
)

procedure( pfnToggleRepeatCommands()
    prog( ()
        if( leGetEnv( "modalCommands" ) == t then
                leSetEnv( "modalCommands" nil)
            else
                leSetEnv( "modalCommands" t)
        )
    )
)

;---------------------------------------------------------------------
;	end of uwBindKeys.il
