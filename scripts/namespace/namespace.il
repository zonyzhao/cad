makeNamespace("myNs")
(addToNamespace "myNs" '("a" "b" "c"))
findNamespace("myNs")

myNs:::x = 0
defun( myNs:::y (a) list(a a))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
makeNamespace("cad")
findNamespace("cad")
defclass( cad:::cadObj ()
	  (
		( oid @reader getOid @writer setOid )
		( cid @reader getCid @writer setCid )
		( ref @reader getRef @writer setRef )
		( attributes @reader getAttributes  @writer setAttributes)
		( layer @reader getLayer @writer setLayer )
		( purpose @reader getPurpose @writer setPurpose )
		( grid @writer setGrid @reader getGrid )
		( temp @writer setTemp @reader getTemp )			
	  )
);defclass
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
defmethod( initializeInstance @after ((obj cad:::cadObj)) 
	   obj->oid=nil
	   obj->cid=nil
	   obj->ref=nil
	   obj->attributes=nil
	   obj->layer = "text"
	   obj->purpose = "drawing"
	   obj->grid = 0.1
);defmethod
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
defmethod( gridCheck (( cobj cad:::cadObj ) arg)
	if(cobj->grid != arg then
	  't
        else
           nil
        )
);defMethod
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

foo = makeInstance( 'cad:::cadObj )
foobar = makeInstance( 'cadObj )


getTemp(foo)
getTemp(foobar)

gridCheck(foo 0.1)
gridCheck(foobar 0.1)