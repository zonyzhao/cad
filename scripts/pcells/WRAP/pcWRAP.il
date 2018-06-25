pcDefinePCell(
	list(ddGetObj("test") "WRAP" "layout")
	(
		( ringW "float" 0.100000)
		( ringS "float" 0.100000)
		( cyanW "float" 0.600000)
		( cyanL "float" 0.200000)
		( greenW "float" 0.200000)
		( greenL "float" 0.800000)
	
	let(pcell)
		pcell = makeInstance('WRAP)
		setPcellParams(pcell pcCellView)
		draw(pcell)
	)
)
