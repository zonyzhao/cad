procedure(autoloads()
	println( "INFO: Loading Skill Scripts")
	ilList = getDirFiles(ilDir0)
	foreach(i ilList
        	  if( !((strcmp( i ".") == 0) || (strcmp( i "..") == 0) || (strcmp( i ".svn") == 0)) then 
		      len=strlen(i)
		      endch = substring(i len)
		      if( !(strcmp( endch "~") == 0) then
            	      	  sprintf(file "%s/%s" ilDir0 i)
            	      	  load(file)
            	      	  println(file)
			  );if
       		  );if
        );foreach
	println( "INFO: Done Loading Skill Scripts")

	println( "INFO: Loading Skill++ Scripts")
	ilList = getDirFiles(ilDir1)	
	foreach(i ilList
        	  if( !((strcmp( i ".") == 0) || (strcmp( i "..") == 0) || (strcmp( i ".svn") == 0)) then 
		      len=strlen(i)
		      endch = substring(i len)
		      if( !(strcmp( endch "~") == 0) then
            	      	  sprintf(file "%s/%s" ilDir1 i)
            	      	  load(file)
            	      	  println(file)
			  );if
       		  );if
        );foreach
	println( "INFO: Done Loading Skill++ Scripts")
);procedure
