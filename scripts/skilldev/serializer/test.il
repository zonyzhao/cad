;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0; Existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'serializer )
ser = makeInstance( 'serializer )
classp( ser 'serilizer)
classOf(ser)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1; Serialize a dpl
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
dpl = '( nil
	version			1.23		
	procTypes		( 
                                 "RF" "DC" "RFDC" 
                                );procTypes
	waferSizes		(	
	  "4"
				);waferSizes
	numTypes		( 	
	  "numbers" "reverse"	                
				);numTypes
	numOffsets		( nil		
		L		( 40 100)       
		M		( 30 70 110)   
		S		( 20 45 70)
				);numOffsets
	reticleLayer		"resistor"      
	mergedChipList		nil             
    );nil
);dpl
ser = makeInstance( 'serializer )
setPlist(ser dpl)
setPath(ser "/users/1127110")
setName(ser "serializerTest")
serialize(ser)