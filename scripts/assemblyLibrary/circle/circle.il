;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;  circle.il: On Grid Circle Generator Object 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
defclass( circle (polygon2)
	  (
		( radius @writer setRadius )
		( orig @writer setOrig )
		( direction )
		( X )
		( Y )		  
	  )
) ; defClass

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Class Constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
defmethod( initializeInstance @after ((obj circle)) 
	   obj->radius = 1.0
	   obj->orig=list(0.0 0.0)
	   obj->X=0.0
           obj->Y=0.0
	   obj->direction=0
);defmethod

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This method generates the next on-grid vertex of the circle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
defmethod( genNextVertex ((cir circle))
  let( ( (grid cir->grid)
         X0 Y0 R0 D0 X1 Y1 R1 D1 X2 Y2 R2 D2 X3 Y3 R3 D3 
         X4 Y4 R4 D4 X5 Y5 R5 D5 X6 Y6 R6 D6 X7 Y7 R7 D7)
 	  if( (cir->direction == 0 || cir->direction == 1 || cir->direction == 7) then
   	     X0 = cir->X + grid
   	     Y0 = cir->Y
	     R0 = (X0**2 + Y0**2)**0.5
	     D0 = abs(R0-cir->radius)
          );if
	  if( (cir->direction ==  1 || cir->direction == 2 || cir->direction == 0) then
	     X1 = cir->X + grid
	     Y1 = cir->Y - grid
	     R1 = (X1**2 + Y1**2)**0.5
	     D1 = abs(R1-cir->radius)
	  );if
	  if( (cir->direction ==  2 || cir->direction == 3 || cir->direction == 1) then
	     X2 = cir->X
	     Y2 = cir->Y - grid
	     R2 = (X2**2 + Y2**2)**0.5
	     D2 = abs(R2-cir->radius)
	  );if
	  if( (cir->direction == 3 || cir->direction == 4 || cir->direction == 2) then
	     X3 = cir->X - grid
   	     Y3 = cir->Y - grid
	     R3 = (X3**2 + Y3**2)**0.5
	     D3 = abs(R3-cir->radius)
 	  );if
	  if( (cir->direction == 4 || cir->direction == 5 || cir->direction == 3) then
	     X4 = cir->X - grid
	     Y4 = cir->Y
	     R4 = (X4**2 + Y4**2)**0.5
	     D4 = abs(R4-cir->radius)
	  );if
	  if( (cir->direction == 5 || cir->direction == 6 || cir->direction == 4) then
	     X5 = cir->X - grid
	     Y5 = cir->Y + grid
	     R5 = (X5**2 + Y5**2)**0.5
	     D5 = abs(R5-cir->radius)
	  );if
	  if( (cir->direction == 6 || cir->direction == 7 || cir->direction == 5) then
	     X6 = cir->X
	     Y6 = cir->Y + grid
	     R6 = (X6**2 + Y6**2)**0.5
	     D6 = abs(R6-cir->radius)
	  );if
	  if( (cir->direction == 7 || cir->direction == 0 || cir->direction == 6) then
	     X7 = cir->X + grid
	     Y7 = cir->Y + grid
	     R7 = (X7**2 + Y7**2)**0.5
	     D7 = abs(R7-cir->radius)
	  );if
	  caseq( cir->direction
	 	(0
		  ; Possible 7 0 1  
		  if( (D0 < D1 && D0 < D7) then
		    ;Go D0 
		    cir->X = X0
 		    cir->Y = Y0
		    cir->direction= 0
	          else
	            if( (D1 < D0 && D1 < D7) then
	              ; Go D1 
		      cir->X = X1
 		      cir->Y = Y1
		      cir->direction= 1
		    else
		      ; Go D7 
		      cir->X = X7
 		      cir->Y = Y7
		      cir->direction= 7
		    );if
		  );if
	        );0
                (1
		  ; Possible 0 1 2   
		  if( (D1 < D2 && D1 < D0) then
		     ;Go D1 
		     cir->X = X1
 		     cir->Y = Y1
		     cir->direction= 1
		   else
		      if( (D2 < D1 && D2 < D0) then
		        ; Go D2 
			cir->X = X2
 		     	cir->Y = Y2
		     	cir->direction= 2
		       else
		        ; Go D0
			cir->X = X0
 		     	cir->Y = Y0
		     	cir->direction= 0 
		    );if
		  );if
	        );1
                (2
		  ;  Possible 1 2 3
		  if( (D2 < D3 && D2 < D1) then
		    ; Go D2 
		     cir->X = X2
 		     cir->Y = Y2
		     cir->direction= 2 
		  else
		    if( (D3 < D2 && D3 < D1) then
 		       ; Go D3 
		       cir->X = X3
 		       cir->Y = Y3
		       cir->direction= 3 
 		    else
 		       ;Go D1 
		       cir->X = X1
 		       cir->Y = Y1
		       cir->direction= 1 
 		   );if
   		  );if
 	       	);2
                (3
 	          ;Possible 2 3 4 
		  if( (D3 < D4 && D3 < D2) then
   		    ;Go D3 
		    cir->X = X3
 		    cir->Y = Y3
		    cir->direction= 3 
   		   else
		     if( (D4 < D3 && D4 < D2) then
 		       ; Go D4 
		       cir->X = X4
 		       cir->Y = Y4
		       cir->direction= 4
 		      else
			; Go D2 
			cir->X = X2
 		        cir->Y = Y2
		        cir->direction= 2
 		     );if
   		  );if
 	        );3
   	        (4
		  ; Possible  3 4 5 
 		  (if D4 < D5 && D4 < D3 then
   		    ; Go D4
		     cir->X = X4
 		     cir->Y = Y4
		     cir->direction= 4
   		   else
		     (if D5 < D4 && D5 < D3 then
 		       ; Go D5 
		       cir->X = X5
 		       cir->Y = Y5
		       cir->direction= 5
 		      else
 		       ; Go D3 
		       cir->X = X3
 		       cir->Y = Y3
		       cir->direction= 3
 		     );if
   		   );if
                 );4
	         (5
		   ;Possible 4 5 6 
 		   if( (D5 < D6 && D5 < D4) then
   		     ; Go D5 
		     cir->X = X5
 		     cir->Y = Y5
		     cir->direction= 5
   		    else
   		      if( (D6 < D5 && D6 < D4) then
 		        ; Go D6 
			cir->X = X6
 		        cir->Y = Y6
		        cir->direction= 6
 		      else
 		       ; Go D4
		         cir->X = X4
 		         cir->Y = Y4
		         cir->direction= 4 
		     );if
   		   );if
 	         );5
   	         (6
		   ; Possible  5 6 7 
 		   if( (D6 < D7 && D6 < D5) then
   		     ; Go D6 
		     cir->X = X6
 		     cir->Y = Y6
		     cir->direction= 6
                    else
                      if( (D7 < D6 && D7 < D5) then
 		        ;Go D7 
			cir->X = X7
 		     	cir->Y = Y7
		     	cir->direction= 7
 		      else
		        ;Go D5 
			cir->X = X5
 		     	cir->Y = Y5
		     	cir->direction= 5
 		     );if
   		   );if
	         );6
    	         (7
	           ;Possible 6 7 0 
 		   if( D7 < D0 && D7 < D6 then
   		     ;Go D7 
		     cir->X = X7
 		     cir->Y = Y7
		     cir->direction= 7
   		    else
   		       if( (D0 < D7 && D0 < D6) then
 		         ;Go D0 
			 cir->X = X0
 		    	 cir->Y = Y0
		     	 cir->direction= 0
 		        else
		         ;Go D6
			 cir->X = X6
 		     	 cir->Y = Y6
		     	 cir->direction= 6 
 		       );if
   		    );if
 	         );7
  	   );caseq
  );let
);defmethod

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This method generates the ON-GRID "circle" vertex list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
defmethod( generate (( cir circle ))
	   let( (count)
	   	;Initialize Members
	   	cir->vertices = '()
           	cir->direction= 0
	   	cir->vertices = cons(list(0.0 cir->radius) cir->vertices)
		cir->X = 0.0
		cir->Y = cir->radius
		cir->orig = list(cir->X cir->Y)
		genNextVertex(cir)
		count = 0
	   	while( !( (abs(cir->X) < (cir->grid)) && (abs((cir->radius)-(cir->Y)) < (cir->grid)) )
	   	        count = count + 1
		 	genNextVertex(cir)
		 	cir->vertices = cons(list(cir->X cir->Y) cir->vertices)	  		      
	   	);while
	   	if( count > 0 then
		    ; add in origin vertex to close circle
	       	    count
	   	else
		    nil
	   	);if
		setRecTran(cir)
		calculateCentroid(cir)
	   );let
) ; defMethod

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






	
