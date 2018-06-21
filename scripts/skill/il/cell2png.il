procedure( cell2png()
  let( ( w1 w2 w3 w4 h3 form1 form2 form3 lib lb cellname view pngObj)
  ; No internal GUI callbacks are used in this 
  ; code. Uses the existence of a selected value
  ; to sequence to the next GUI form.
  ; FIXME: Add "Save to World Drive" Option
  ;###########################################
  ; Define some positional globals
  ;###########################################
  w1 = 400
  w2 = 50
  w3 = 300
  w4 = 50
  h3 = 300
  ;###########################################
  ; Define form structures
  ;###########################################
  ;##########################
  ; GUI Form 1
  ;##########################
  form1 = hiCreateAppForm( ?name 'FORM1 
      			 ?formTitle "Select Library"
      		         ?fields list( list( hiCreateListBoxField( ?name 'LIBLIST 
				    	  	                   ?prompt ""
						                   ?choices nil
						                   ?value nil
								  );hiCreateListBoxField
						                   10:10 
						                   250:250 
						                   0
				);list
			   );list
  );hiCreateForm
  ;##########################
  ; GUI Form 2
  ;##########################
  form2 = hiCreateAppForm( ?name 'FORM2 
      			 ?formTitle "Select Cell"
      		         ?fields list( list( hiCreateListBoxField( ?name 'CELLLIST 
				    	  	                   ?prompt ""
						                   ?choices nil
						                   ?value nil
								  );hiCreateListBoxField
						                   10:10 
						                   250:250 
						                   0
				            );list
					list( hiCreateCyclicField( ?name 'VIEW 
					      			   ?prompt "View" 
								   ?value "layout"
								   ?choices '( "schematic" "layout" "both") 
								   );hiCreateCyclicFiled
								   15+w3+w4+10:10 
								   125:25 
								   50
					    );list
			   ); ?fields list
					    
  );hiCreateForm
  ;###################################################
  ; Define the exit forms
  ;###################################################
  ; GUI Form 3 definition
  ;###################################################
  form3 = hiCreateAppForm( ?name 'FORM3 
      			 ?formTitle "PNG SAVED"
      		         ?fields list( list( hiCreateLabel( ?name 'ENDLABEL 
			      		                    ?labelText "Thanks for using cell2png!"
							  );hiCreateLabel
					                  15:35 
					                  w1:35 
					                  0
			 	            );list
				      );fields list
  );hiCreateAppForm
  ;###################################################
  ; beginning of serialized GUI procedure begins here
  ;###################################################
  ; Get all library entried in the cds.lib file
  ;#############################################
  lib = makeInstance( 'library )
  genLibList(lib)
  form1->LIBLIST->choices = libList=lib->libList->elems
  ; #############################################
  ; callback structure for serialized GUI forms
  ; using nested conditionals without callback	
  ; definitions
  ; #############################################
  cond(
    ; if the form is cancelled, do nothing:
    ( null( hiDisplayForm(form1))
	  nil
    )
    ; if a value was chosen, sequence to the library selection form:
    ( form1->LIBLIST->value
      ;lib->name = nth(0 form1->LIBLIST->choices)
       lb = makeInstance('lib)
       setName(lb nth(0 form1->LIBLIST->value))
       ;setName(lb form1->LIBLIST->value)
       genCellNameList(lb)
       form2->CELLLIST->choices=lb->cellNameList
       println("INFO: Callback - getting cellName list")
       cond(
	 ; if the form is cancelled, do nothing:
	 ( null( hiDisplayForm( form2))
	     nil
	 );null
	 ; if a value was chosen, sequence to the cell name and view  selection form:
         ( form2->CELLLIST->value
	   println("INFO: Callback - getting cell name and view")
	   cellName = nth(0 form2->CELLLIST->choices)
	   view = form2->VIEW->value
	   ; Create png generation object
	   pngObj = makeInstance( 'cell2png )
	   ; populate its members
	   pngObj->cell = nth(0 form2->CELLLIST->value)
           pngObj->lib  = nth(0 form1->LIBLIST->value)
	   pngObj->view = view
	   ; set the design path member
	   setDesignPath(pngObj)
	   ; check for existence of directory. creates it if needed.
	   checkPngDir(pngObj)
	   ; attempt to save the png file and display results in text label window
	   if( savePng(pngObj) then
	     hiSetFormName( form3 "PNG SAVE COMPLETED")
	     form3->ENDLABEL->value = strcat( "FILE: " pngObj->dir "/" pngObj->cell ".png")
	     form3->_maxXExtent=700
	     form3->_maxYExtent=120	       
	   else
	     hiSetFormName( form3 "PNG SAVE FAILED")
	     form3->ENDLABEL->value = strcat( "FILE SAVE ERROR!. See CIW for ERRORS")
	     form3->_maxXExtent=200
	     form3->_maxYExtent=60
	    );if  
	    hiDisplayForm(form3)
	  );form2
          ; if nothing was selected, set the parent's field to blank:
	  ( t
	     get( form2 symbol)->value = ""
          );t
	);cond
      );form1
      ; if nothing was selected, set the parent's field to blank:
      ( t
         get( form2 symbol)->value = ""
      );t
   );cond
  );let
);procedure