procedure( releaseClean()
  let( ( w1 w2 w3 w4 h3 form1 form2 form3 lib lb cellname view cvList cvObj 
        pname ind sys libPath)
  ; No internal GUI callbacks are used in this 
  ; code. Uses the existence of a selected value
  ; to sequence to the next GUI form.
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
      			 ?formTitle "Select Release Library To Clean"
      		         ?fields list( list( hiCreateListBoxField( ?name 'LIBLIST 
				    	  	                   ?prompt ""
						                   ?choices nil
						                   ?value nil
								  );hiCreateListBoxField
						                   10:10 
						                   400:400 
						                   0
				);list
			   );list
  );hiCreateForm
  ;##########################
  ; GUI Form 2
  ;##########################
  form2 = hiCreateAppForm( ?name 'FORM2 
      			 ?formTitle "Select Primary Reticle"
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
			      		                    ?labelText "Thanks for using Release Clean Utility!"
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
	   cvObj = makeInstance( 'cv )
	   ; populate its members
           cvObj->lib  = nth(0 form1->LIBLIST->value)
	   cvObj->view = view
	   ;###########################################
  	   ; Cellview Name Postfix List
   	   ;###########################################
  	   cvList = list( "0p_aeblemap" 
                    	  "0p_startmap" 
  		 	  "0p_sites" 
		 	  "0p_wafer" 
		 	  "0p_wafer_Flat" 
		 	  "0s_xyn" 
		 	  "0p_xyn" 
			  "0p_wpnums");list
	   printf("Selected Library Name: %s\n" lb->name)
	   printf("Selected Primary Name: %s\n" nth(0 form2->CELLLIST->value) )
	   ind = nindex(cellName "_")
;	   if(null(isDir(libPath) then
;	     println("ERROR: Primary reticle cell name does not conform to naming conventions!")
;	   else
	      pname = substring(cellName 1 ind)
	      foreach( cvName cvList
	      	    cvObj->name = strcat(pname cvName)
	      	    closeAndPurge(cvObj)
	     	    removeCell(cvObj)
              );foreach
	      sys = makeInstance('system)
	      libPath = strcat(setLibPath(lb) "/release")   
	      setName(sys libPath)
	      if(!null(isDirectory(sys)) then
	        printf("INFO: Removing directory: %s\n" libPath)
		setName(sys strcat("rm -rf " setLibPath(lb) "/release"))
	        sysExec(sys)
              else
	        printf("WARNING: No release directory found: %s\n" libPath) 
              );if
            setName(sys libPath) 
	    if(!isDirectory(sys) then
	      hiSetFormName( form3 "RELEASE CLEAN COMPLETED")
	      form3->ENDLABEL->value = ""
	      ;form3->ENDLABEL->value = strcat( "Removed Directory: " sys->name )
	      form3->_maxXExtent=700
	      form3->_maxYExtent=120	       
	    else
	      hiSetFormName( form3 "RELEASE CLEAN FAILED")
	      form3->ENDLABEL->value = strcat( "Release Directory Remove Error!. See CIW for ERRORS")
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


