
# Traverse each layer and export an obstacle file.

# From http://www.rtrowbridge.com/blog/2008/11/maya-python-vs-mel-data-storage/
# This could be useful for file IO: http://www.mattmurrayanimation.com/archives/243
# http://forums.cgsociety.org/archive/index.php/t-671022.html
# http://www.rodgreen.com/?p=250

import os
import maya.cmds as cmds

# Save original selection.
originalSelection = cmds.ls( sl=True )

# Store only user-created layers.
allLayers = cmds.ls( long=True, type='displayLayer' )
layers = []
for l in allLayers:
	if ( cmds.getAttr( l + ".identification" ) > 0 ):
		layers.append( l )

# Now iterate over each layer.
for currLayer in layers:
	# Select everything in the scene.
	cmds.select( all=True )
	sel = cmds.ls( sl=True, type="transform" )
	
	# Iterate through selected nodes
	for obj in sel:
		layers = cmds.listConnections( obj, type="displayLayer" )
		if layers == None:
			break;
		layer = layers[ 0 ]
		if layer == currLayer:
			children = cmds.listRelatives( obj )
			for child in children:
				if ( child.find( 'locator' ) >= 0 ):
					nameParts = child.split( '_' )
					name = nameParts[ 1 ]
					translateX = cmds.getAttr( obj + '.translateX' )
					translateY = cmds.getAttr( obj + '.translateY' )
					translateZ = cmds.getAttr( obj + '.translateZ' )
					cmds.setAttr( obj + '.translateX', round( translateX - .5 ) + .5 )
					cmds.setAttr( obj + '.translateY', round( translateY ) + 0 )
					cmds.setAttr( obj + '.translateZ', round( translateZ - .5 ) + .5 )
					translateX2 = cmds.getAttr( obj + '.translateX' )
					translateY2 = cmds.getAttr( obj + '.translateY' )
					translateZ2 = cmds.getAttr( obj + '.translateZ' )
					if translateX != translateX2 or translateY != translateY2 or translateZ != translateZ2:
					  print "Moved [" + currLayer + "]" + obj + " from (" + str(translateX) + ", " + str(translateY) + ", " + str(translateZ) + ") to (" + str(translateX2) + ", " + str(translateY2) + ", " + str(translateZ2) + ")"
					
# Select the original selection.
cmds.select( deselect=True )
cmds.select( originalSelection )