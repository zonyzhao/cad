;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Test Existence 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'geomObject )
tpl = makeInstance( 'geomObject )
classp( tpl 'twoPointsLine)
classOf(tpl)
superclassesOf(classOf(tpt))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Create points and describe
;       them
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
P = makeInstance( 'Point2 ?x 0 ?y 4 )
Describe( P )     
R = makeInstance( 'Point2 ?x 3 ?y 0 )
Describe( R ) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2 Construct a line that passes
;      between points P and R and
;      describe it
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
L = make_TwoPoints_Line( P R ) 
Describe( L )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3 Change the coordinate of P
;      to 1 and call the Update
;      function to propagate the
;      changed coordinates of P
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
P->x=1
Update( P )
Describe( L )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Create four points P, Q, S,
;      and R.
;      Construct the line PQ passing
;      through points P and Q
;      Construct a line SR passing
;      through pints S and R
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
P = makeInstance( 'Point ?x 0 ?y 4)
Q = makeInstance( 'Point ?x 0 ?y -4)
S = makeInstance( 'Point ?x -3 ?y 0)
R = makeInstance( 'Point ?x 3 ?y 0)
PQ = make_TwoPoints_Line( P Q )
SR = make_TwoPoints_Line( P Q )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5: Construct the point Z that is 
;       on both the lines PQ and SR and
;       describes the point Z
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Z = make_IntersectionTwoLines_Point( PQ SR )
Describe( Z )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6: Change the y coordinate of S
;       to 4 and update point S, and
;       describe the point Z to verify
;       that it was updated
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
S->y=4
Update( S )
Describe( Z )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Experimental Code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Extending the implementation
; 1.) Protecting the implementation from inconsistent
;     access:
;              One can currently use the -> operator to change coordinates of any point,
;              even a contrained point. Extend teh implementation to
;              allow the user to change only coordinates of free
;              points
;
; 2.) Adding Graphics: Extend the implementation to associate a database object with each
;                      point or line and update the database object at appropriate times.
;                      You should only have to affect the Point and Line classes
;                      
