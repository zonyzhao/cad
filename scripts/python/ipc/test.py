# Skill Commands to enter into the interactive
# Python shell
"graph = makeInstance( 'graphical )"
"lib = symbolToString('test)"
"cell = symbolToString('textAcopy)"
"view = symbolToString('layout)"
"setLib(graph lib)"
"setCell(graph cell)"
"setView(graph view)"
"openWindow(graph)"
"shps = graph->ref~>shapes"
"println(shps)"
"dbDeleteObject(nth(0 graph->ref~>shapes))"
"shps = graph->ref~>shapes"
"println(shps)"
"refreshWindow(graph)"
"saveWindow(graph)"
"closeWindow(graph)"

########################################
# Test the interactive python skill
# command file interpreter
########################################
"source ./skill.cmd"


########################################
# Experimental Code
########################################

from IPython import embed
# ??
embed()

########################################

import readline
import code
vars = globals().copy()
vars.update(locals())
shell = code.InteractiveConsole(vars)
shell.interactive()


########################################
mkfifo in
python <in &
echo "print 3+2" >in

