;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Procdure to load the Release menu which allows for the execution 
; of release skill scripts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( ReleaseMenu(args)
  let( (I0 I1 I2 I3 I4 I5 I6)
	printf("Inserting Release menu in cell %s" args->cellName)
	I0=hiCreateMenuItem(
		?name 'I0
		?itemText "XYnumbers"
		?callback "xynums()"
		);hiCreateMenuItem
	I1=hiCreateMenuItem(
		?name 'I1
		?itemText "PhotoInfo"
		?callback "photoInfo()"
		);hiCreateMenuItem
        I2=hiCreateMenuItem(
		?name 'I2
		?itemText "SD Fill"
		?callback "fillgui()"
		);hiCreateMenuItem
	I3=hiCreateMenuItem(
		?name 'I3
		?itemText "cell2png"
		?callback "cell2png()"
		);hiCreateMenuItem
        I4=hiCreateMenuItem(
		?name 'I4
		?itemText "divaFrac"
		?callback "divaFrac()"
		);hiCreateMenuItem
	I5=hiCreateMenuItem(
		?name 'I5
		?itemText "splitData"
		?callback "splitData()"
		);hiCreateMenuItem
	I6=hiCreateMenuItem(
		?name 'I6
		?itemText "Clean Release Data"
		?callback "releaseClean()"
		);hiCreateMenuItem
	hiCreatePulldownMenu(
		'myMenu 
		"Release"
		list(I0 I1 I2 I3 I4 I5 I6)
		);hiCreatePulldownMenu
	hiInsertBannerMenu(hiGetCurrentWindow() 'myMenu 99)
  );let
);procedure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Register the user callback procedure "ReleaseMenu"
; triggered upon the opening of a layout
; cellview with layout cellview property of "maskLayout"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
deRegUserTriggers("maskLayout" nil nil 'ReleaseMenu)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
