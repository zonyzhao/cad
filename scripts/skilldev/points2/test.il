;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'points2 )
pt2 = makeInstance( 'points2 )
classp( pt2 'points2)
classOf(pt2)
pt2->points

getPoints(pt2)
getCollection(pt2->points)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Add points to colection 
;       and read them out by index
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; define coordinate list
c0 = list(0.0 0.0)
c1 = list(0.0 100.0)
c2 = list(100.0 100.0)
c3 = list(100.0 0.0)
c4 = list(0.0 0.0)
coordList = list(c0 c1 c2 c3 c4)
pts2 = makeInstance( 'points2 )
; Reset the point collection
resetPoints(pts2)
; Add points to the collection
foreach(coord coordList
  p2 = makeInstance( 'point2 )
  setCoord(p2 coord)
  appendPoint(pts2 p2)
);foreach
; List the collection of points
foreach(pt getCollection(pts2->points)
   printf("Point: %L\n", getCoord(pt))
);foreach

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Translate all points in 
;       collection
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
c0 = list(0.0 0.0)
c1 = list(0.0 100.0)
c2 = list(100.0 100.0)
c3 = list(100.0 0.0)
c4 = list(0.0 0.0)
coordList = list(c0 c1 c2 c3 c4)
pts2 = makeInstance( 'points2 )
; Reset the point collection
resetPoints(pts2)
; Add points to the collection
foreach(coord coordList
  p2 = makeInstance( 'point2 )
  setCoord(p2 coord)
  appendPoint(pts2 p2)
);foreach
; List the collection of points
foreach(pt getCollection(pts2->points)
   printf("Point: %L\n", getCoord(pt))
);foreach
translate(pts2 list(5.0 5.0))
foreach(pt getCollection(pts2->points)
   printf("Point: %L\n", getCoord(pt))
);foreach

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: mirror all points about the
;       y axis
;       (centroid of points collection
;        must be at origin)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
c0 = list(-50.0 -100.0)
c1 = list( 50.0 -100.0)
c2 = list( 50.0 100.0)
c3 = list(-50 100.0)
coordList = list(c0 c1 c2 c3)
pts2 = makeInstance( 'points2 )
; Reset the point collection
resetPoints(pts2)
addPoints(pts2 coordList)
foreach(pt getCollection(pts2->points)
   printf("Point: %L\n", getCoord(pt))
);foreach
mirrory(pts2)
foreach(pt getCollection(pts2->points)
   printf("Point: %L\n", getCoord(pt))
);foreach

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: mirror points about the 
;       x direction. 
;       (centroid of points collection
;        must be at origin)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
c0 = list(-50.0 -100.0)
c1 = list( 50.0 -100.0)
c2 = list( 50.0 100.0)
c3 = list(-50 100.0)
coordList = list(c0 c1 c2 c3)
pts2 = makeInstance( 'points2 )
; Reset the point collection
resetPoints(pts2)
addPoints(pts2 coordList)
foreach(pt getCollection(pts2->points)
   printf("Point: %L\n", getCoord(pt))
);foreach
mirrorx(pts2)
foreach(pt getCollection(pts2->points)
   printf("Point: %L\n", getCoord(pt))
);foreach