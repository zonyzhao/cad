;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Test Existence and Inheritance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'twoPointsLine )
tpl = makeInstance( 'twoPointsLine )
classp( tpl 'twoPointsLine)
classOf(tpl)
superclassesOf(classOf(tpl))
className(classOf(tpl))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Create the object and 
;       describe it
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Two points line object
tpl = makeInstance( 'twoPointsLine)
setP1(tpl list(0.0 0.0))
setP2(tpl list(1.0 1.0))
Describe(tpl)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Create a line from 2 points
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Point #1
tpl = makeInstance( 'twoPointsLine)
setP1(tpl list(0.0 0.0))
setP2(tpl list(1.0 1.0))
Update( tpl )
Validate( tpl )
Describe( tpl )
Connect( getPoint1(tpl) tpl )
Connect( getPoint2(tpl) tpl )
Update(getPoint1(tpl))
Update(getPoint2(tpl))
Update(tpl)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Helper
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Helper Procedure For Connecting the points to the line (constraining the
; points to be on the line and the line to be on the points)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( make_TwoPoints_Line( p1 p2 )
  let( ( line )
       line = makeInstance( 'twoPointsLine ?P1 p1 ?P2 p2 )
       Update( line )
       Connect( p1 line )
       Connect( p2 line )
       line
  );let
);procedure

