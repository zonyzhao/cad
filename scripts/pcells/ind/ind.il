pcellMaster=pcDefinePCell(list(ddGetObj("pa0715"), "ind", "layout")
                              (
	                        (W "float" 1000)
		                (S "float" 100)
		                (OD "float" 90) 
		                (GAP "float" 10) 
	      	                (DIV "float" 3.5) 
		                (LEAD "float" 20.0)
		                (NT "int"  2)
		                (dmy_en "boolean" nil)
		                (DMY_TEXT "string" "ind_a")
	                      )
				; Body of the PCELL
	                        let((techfile_lib techFileID superMaster inst)
	                        		  techfile_lib=techGetTechLibName(pcCellView->lib)
		                		  techFileID=techGetTechFile(ddGetObj(techfile_lib))
		                		  superMaster=dbOpenCellViewByType("pa0715" "ind_oct_t" "layout")
		                		  inst = dbCreateParamInst(pcCellView superMaster nil 0:0 "R0" 1
                                                         	           list(
										list("OD" "float" OD-(NT-1)*2*LEAD)
						              			list("W" "float" W)
						              			list("S" "float" S)
						              			list("GAP" "float" GAP)
						              			list("DIV" "float" DIV)
						              			list("dmy_en" "boolean" dmy_en)
					                     			);list
                                                        		    );dbCreateParamInst
		                		dbCreateRect(pcCellView,list("sd" "drawing"),list(0:0 W:W))
		                		dbCreateLabel(pcCellView,list("text" "drawing"),0:0,DMY_TEXT, "centerCenter","R0","roman",0.2)
		            	);let
);pcDefinePCell