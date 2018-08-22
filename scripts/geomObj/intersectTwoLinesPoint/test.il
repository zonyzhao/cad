;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Test Existence and Inheritance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'intersectTwoLines )
inter = makeInstance( 'intersectTwoLines )
classp( inter 'intersectTwoLines)
classOf(inter)
superclassesOf(classOf(inter))
className(classOf(inter))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
inter = makeInstance( 'intersectTwoLines )
setL1(inter list(0.0 0.0) list(1.0 1.0))
setL2(inter list(1.0 0.0) list(0.0 1.0))
Update(inter)
Validate(inter)
Describe(inter)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-N
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( make_intersectTwoLines( line1 line2)
  let( (point) 
    point = makeInstance( 'IntersectionTwoLines_Point ?L1 line1 ?L2 line2)
    Update( point )
    Connect( line1 point )
    Connect( line2 point )
    point
  );let
);procedure