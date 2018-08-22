;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Test Existence and Inheritance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'lineThruPnt  )
ltp = makeInstance( 'lineThruPnt  )
classp( ltp 'lineThruPnt )
classOf(ltp)
superclassesOf(classOf(ltp))
className(classOf(ltp))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Test creation of a line
;       through point
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ltp = makeInstance( 'lineThruPnt  )
setP(ltp list(0.0 0.0))
setL(ltp list(1.0 0.0) list(0.0 1.0))
Update(ltp)
Validate(ltp)
Describe(ltp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( make_lineThruPoint( point line )
  let( (parallel_line)
    parallel_line = makeInstance('ParallelLineThroughPoint_Line
				 ?P point
				 ?L line)
    Update( parallel_line )
    Connect( point parallel_line )
    Connect( line parallel_line )
    parallel_line
  );let
);procedure