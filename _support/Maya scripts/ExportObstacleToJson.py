
# Traverse each layer and export an obstacle file.

# From http://www.rtrowbridge.com/blog/2008/11/maya-python-vs-mel-data-storage/
# This could be useful for file IO: http://www.mattmurrayanimation.com/archives/243
# http://forums.cgsociety.org/archive/index.php/t-671022.html
# http://www.rodgreen.com/?p=250

import os
import maya.cmds as cmds
import json

# Save original selection.
originalSelection = cmds.ls( sl=True )

# Store only user-created layers.
allLayers = cmds.ls( long=True, type='displayLayer' )
layers = []
for l in allLayers:
	if ( l != "Floorplan" and cmds.getAttr( l + ".identification" ) > 0 ):
		layers.append( l )

# Now iterate over each layer.
for currLayer in layers:
	
	# Create a new file.
	projectPath = cmds.file( query=True, list=True )[ 0 ]
	fileName = currLayer
	filePath = projectPath + '/../Exported JSON/' + fileName + '.json'
	jsonFile = open( os.path.abspath( filePath ), 'w' )
	
	# Create object to build.
	jsonObject = []
	
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
					# Create object to store properties for this block.
					childObj = {}
					jsonObject.append( childObj )
					# Add the id.
					childObj[ 'id' ] = child.split( '_' )[ 1 ]
					# Add the position.
					childObj[ 'x' ] = cmds.getAttr( obj + '.translateX' )
					childObj[ 'y' ] = cmds.getAttr( obj + '.translateY' )
					childObj[ 'z' ] = cmds.getAttr( obj + '.translateZ' )
	
	# Close the file.
	jsonFile.write( json.dumps( jsonObject ) )
	jsonFile.close()
	
	print "Exported " + filePath

# Select the original selection.
cmds.select( deselect=True )
cmds.select( originalSelection )