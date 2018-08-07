;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Test Existence and Inheritance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'twoPointsLine )
tpl = makeInstance( 'twoPointsLine )
classp( tpl 'twoPointsLine)
classOf(tpl)
superclassesOf(classOf(tpt))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Create a line from 2 points
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
p1 = makeInstance( 'point )
p1->x = 0.0
p1->y = 0.0
p2 = makeInstance( 'point )
p2->x = 1.0
p2->y = 1.0
line = makeInstance( 'TwoPoints_Line ?P1 p1 ?P2 p2 )
Update( line )
Connect( p1 line )
Connect( p2 line )
line
