;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'point2 )
p0 = makeInstance( 'point2 )
classp( p0 'point2)
classOf(p0)
p0->x
p0->y
getCoord(p0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Set Coordinates of a 
;       point based upon a 
;       coordinte list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pnt = makeInstance( 'point2 )
setCoord(pnt list(1.0 1.0))
getCoord(pnt)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Set Coordinates of a 
;       point based upon 
;       individual values
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pnt = makeInstance( 'point2 )
setX(pnt 2.0)
setY(pnt 2.0)
getCoord(pnt)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Translate a point using
;       a translation list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pnt = makeInstance( 'point2 )
setCoord(pnt list(1.0 1.0))
getCoord(pnt)
x = 2.0
y = -3.0
tp = list(x y)
translate(pnt tp)
getCoord(pnt)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Translate a point using
;       individually set coords
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pnt = makeInstance( 'point2 )
setX(pnt 1.0)
setY(pnt 1.0)
getCoord(pnt)
x = 2.0
y = -3.0
tp = list(x y)
translate(pnt tp)
getCoord(pnt)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5: Lower Left test #0
; (nil expected)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pnt = makeInstance( 'point2 )
setPoint(pnt list(1.0 1.0))
xp = 0.0
yp = 0.0
pnt1 = list(xp yp)
lowerLeftPoint(pnt pnt1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6: Lower Left test #1
; (t expected)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pnt = makeInstance( 'point2 )
setPoint(pnt list(0.0 0.0))
xp = 1.0
yp = 1.0
pnt1 = list(xp yp)
lowerLeftPoint(pnt pnt1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-?: Lower Left test #2
; (nil expected)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pnt = makeInstance( 'point2 )
setPoint(pnt list(0.0 0.0))
xp = -1.0
yp = 0.0
pnt1 = list(xp yp)
lowerLeftPoint(pnt pnt1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-8: Lower Left test #3
; (t expected)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pnt = makeInstance( 'point2 )
setPoint(pnt list(-1.0 0.0))
xp = 0.0
yp = 0.0
pnt1 = list(xp yp)
lowerLeftPoint(pnt pnt1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-9: Serialize and Deserialize
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fname = "/net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa3/cad/scripts/skilldev/point2/pnt.dat"
pnt = makeInstance( 'point2 )
setPoint(pnt list(-1.0 0.0))
getPoint(pnt)
serialize(pnt fname)
pnt = makeInstance( 'point2 )
getPoint(pnt)
deserialize(pnt fname)
getPoint(pnt)
getX(pnt)
getY(pnt)
pnt->x
pnt->y

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-?: Lower Left test #4
; (nil expected)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pnt = makeInstance( 'point2 )
setPoint(pnt list(0.0 0.0))
xp =  0.0
yp = -1.0
pnt1 = list(xp yp)
lowerLeftPoint(pnt pnt1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-?: Lower Left test #5
; (t expected)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pnt = makeInstance( 'point2 )
setPoint(pnt list(0.0 -1.0))
xp = 0.0
yp = 0.0
pnt1 = list(xp yp)
lowerLeftPoint(pnt pnt1)



