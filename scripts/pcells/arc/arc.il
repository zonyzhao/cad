;arcPcell.il 
;Version 1.0
;Algorithm based on CORDIC or Volder's Algorithm
;
;This file contains functions for a layout PCELL that draws a arc shape out
;of polygons. All points remain on the grid specified and only lines with angles 
;a multiple of 4 degrees are used.

;The arc is created by starting at position 0, Radius with a direction of 0 degrees (X=r,Y=0)
;(using the direction numbers as shown below). To keep the angles smooth the
;next direction can only be one of 7. To choose which of these to take,
;the equation of a circle x^ + y^ = r^ is used to determine which of the
;three possible directions is closest to the actual radius.
;If the number of points in the polygon is going to exceed 2048 then it is split
;into multiple polygons, resulting in an appearance of a round cheese chopped
;into pieces.
;Direction
;      5  6  7
;       \ | / 
;     4 - o - 0
;       / | \
;      3  2  1
;--- Using it ---
;You'll need to modify the call to pcDefinePCell() below to specify your
;preferred librarycell names and possibly the default radius, grid and layer.
;Once you've done that just use 'load("pathtoarcPcell.il")' in the CIW 
;the libInit.il file for your library.

procedure( RALgetNextPoint(direction X Y grid radius)
  let( (X0 Y0 R0 D0 X1 Y1 R1 D1 X2 Y2 R2 D2 X3 Y3 R3 D3 
        X4 Y4 R4 D4 X5 Y5 R5 D5 X6 Y6 R6 D6 X7 Y7 R7 D7 ret)
 	  if( (direction == 0 || direction == 1 || direction == 7) then
   	     X0 = X + grid
   	     Y0 = Y
	     R0 = (X0**2 + Y0**2)**0.5
	     D0 = abs(R0-radius)
          );if
	  if( (direction ==  1 || direction == 2 || direction == 0) then
	     X1 = X + grid
	     Y1 = Y - grid
	     R1 = (X1**2 + Y1**2)**0.5
	     D1 = abs(R1-radius)
	  );if
	  if( (direction ==  2 || direction == 3 || direction == 1) then
	     X2 = X
	     Y2 = Y - grid
	     R2 = (X2**2 + Y2**2)**0.5
	     D2 = abs(R2-radius)
	  );if
	  if( (direction == 3 || direction == 4 || direction == 2) then
	     X3 = X - grid
   	     Y3 = Y - grid
	     R3 = (X3**2 + Y3**2)**0.5
	     D3 = abs(R3-radius)
 	  );if
	  if( (direction == 4 || direction == 5 || direction == 3) then
	     X4 = X - grid
	     Y4 = Y
	     R4 = (X4**2 + Y4**2)**0.5
	     D4 = abs(R4-radius)
	  );if
	  if( (direction == 5 || direction == 6 || direction == 4) then
	     X5 = X - grid
	     Y5 = Y + grid
	     R5 = (X5**2 + Y5**2)**0.5
	     D5 = abs(R5-radius)
	  );if
	  if( (direction == 6 || direction == 7 || direction == 5) then
	     X6 = X
	     Y6 = Y + grid
	     R6 = (X6**2 + Y6**2)**0.5
	     D6 = abs(R6-radius)
	  );if
	  if( (direction == 7 || direction == 0 || direction == 6) then
	     X7 = X + grid
	     Y7 = Y + grid
	     R7 = (X7**2 + Y7**2)**0.5
	     D7 = abs(R7-radius)
	  );if
	  caseq( direction
	 	(0
		  ; Possible 7 0 1  
		  if( (D0 < D1 && D0 < D7) then
		    ;Go D0 
		    ret = list(X0 Y0 0)
	          else
	            if( (D1 < D0 && D1 < D7) then
	              ; Go D1 
		      ret = list(X1 Y1 1)
		    else
		      ; Go D7 
		      ret = list(X7 Y7 7)
		    );if
		  );if
	        );0
                (1
		  ; Possible 0 1 2   
		  if( (D1 < D2 && D1 < D0) then
		     ;Go D 
		     ret = list(X1 Y1 1)
		   else
		      if( (D2 < D1 && D2 < D0) then
		        ; Go D2 
		        ret = list(X2 Y2 2)
		       else
		        ; Go D0 
		        ret = list(X0 Y0 0)
		    );if
		  );if
	        );1
                (2
		  ;  Possible 1 2 3
		  if( (D2 < D3 && D2 < D1) then
		    ; Go D 
		     ret = list(X2 Y2 2)
		  else
		    if( (D3 < D2 && D3 < D1) then
 		       ; Go D3 
 		      ret = list(X3 Y3 3)
 		    else
 		       ;Go D1 
 		      ret = list(X1 Y1 1)
 		   );if
   		  );if
 	       	);2
                (3
 	          ;Possible 2 3 4 
		  if( (D3 < D4 && D3 < D2) then
   		    ;Go D3 
  		    ret = list(X3 Y3 3)
   		   else
		     if( (D4 < D3 && D4 < D2) then
 		       ; Go D4 
 		       ret = list(X4 Y4 4)
 		      else
			; Go D2 
 			ret = list(X2 Y2 2)
 		     );if
   		  );if
 	        );3
   	        (4
		  ; Possible  3 4 5 
 		  (if D4 < D5 && D4 < D3 then
   		    ; Go D4
   		     ret = list(X4 Y4 4)
   		   else
		     (if D5 < D4 && D5 < D3 then
 		       ; Go D5 
 		       ret = list(X5 Y5 5)
 		      else
 		       ; Go D3 
 		       ret = list(X3 Y3 3)
 		     );if
   		   );if
                 );4
	         (5
		   ;Possible 4 5 6 
 		   if( (D5 < D6 && D5 < D4) then
   		     ; Go D5 
   		     ret = list(X5 Y5 5)
   		    else
   		      if( (D6 < D5 && D6 < D4) then
 		        ; Go D6 
 		        ret = list(X6 Y6 6)
 		      else
 		       ; Go D4 
 		         ret = list(X4 Y4 4)
		     );if
   		   );if
 	         );5
   	         (6
		   ; Possible  5 6 7 
 		   if( (D6 < D7 && D6 < D5) then
   		     ; Go D6 
   		     ret = list(X6 Y6 6)
                    else
                      if( (D7 < D6 && D7 < D5) then
 		        ;Go D7 
 		        ret = list(X7 Y7 7)
 		      else
		        ;Go D5 
 		        ret = list(X5 Y5 5)
 		     );if
   		   );if
	         );6
    	         (7
	           ;Possible 6 7 0 
 		   if( D7 < D0 && D7 < D6 then
   		     ;Go D7 
   		     ret = list(X7 Y7 7)
   		    else
   		       if( (D0 < D7 && D0 < D6) then
 		         ;Go D0 
		         ret = list(X0 Y0 0)
 		        else
		         ;Go D6 
 		         ret = list(X6 Y6 6)
 		       );if
   		    );if
 	         );7
  	   );caseq
      ret
  );let
);procedure

pcDefinePCell(list(ddGetObj("test") "arc" "layout") 
             ((Radius float 2.0) 
	      (Grid float 0.01) 
	      (Layer string "sd"))
    	     let(( pcParameters pcParamProp pcLayer pcPurpose polyList
             	   X Y direction ret cheese points)
 		   pcParameters = pcCellView->parameters->value
		   pcParamProp = car(exists(prop pcParameters (prop~>name == "Radius")))
		   Radius = pcParamProp->value
		   pcParamProp = car(exists(prop pcParameters (prop~>name == "Grid"))) 
		   Grid = pcParamProp->value 
		   pcParamProp = car(exists(prop pcParameters (prop~>name == "Layer")))
		   Layer = pcParamProp->value
		   dbReplaceProp( pcCellView "viewSubType" "string" "maskLayoutParamCell") 
		   polyList = '()
		   ; Adding in the origin
		   polyList = tconc(polyList list(0.0 0.0))
		   X = 0.0
		   Y = Radius
		   direction = 0
 		   pcLayer = Layer
		   pcPurpose = "drawing" 
		   polyList = tconc(polyList list(X Y))
		   ret = RALgetNextPoint(direction X Y Grid Radius)
		   X = car(ret)
		   Y = cadr(ret)
 		   direction = caddr(ret)
		   polyList = tconc(polyList list(X Y))
		   points = 1
		   cheese = 0
		   while( !( abs(X-Radius) < Grid && abs(Y) < Grid)
		   	  points = points + 1
			  ret = RALgetNextPoint(direction X Y Grid Radius)
			  X = car(ret)
			  Y = cadr(ret)
			  direction = caddr(ret)
			  polyList = tconc(polyList list(X Y))
	     		  ; Split into multiple polygons if the number of points will exceed
	     		  ; the maximum. If this happens, the final polygon must contain an
	     		  ; additional point at 0,0 so that it closes properly. This is
	     		  ; controlled with the "cheese" variable because the output shape
	     		  ; resembles a round cheese chopped into pieces. 
	       		  if( (points == 2047) then
			      polyList = tconc(polyList list(0.0 0.0))
			      dbCreatePolygon(pcCellView 
			      		      list(pcLayer pcPurpose)
			      		      polyList)
			      points = 0
			      cheese = cheese=1
			      polyList=list(list(X Y))
  			  );if	  
			      
		   );while
		   polyList = tconc(polyList list(Radius 0.0))
		   polyList = tconc(polyList list(0.0 0.0))
		   polyList = tconc(polyList list(0.0 Radius))
		   if( onep(cheese) then
	   	       polyList = tconc(polyList list(0.0 0.0))
		   )
        	   dbCreatePolygon(pcCellView
       			list(pcLayer pcPurpose)
			car(polyList))
		  t
	);let
);pcDefinePCell
