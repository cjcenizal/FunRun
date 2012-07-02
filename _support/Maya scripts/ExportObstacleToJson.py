
# Traverse each layer and export an obstacle file.

# From http://www.rtrowbridge.com/blog/2008/11/maya-python-vs-mel-data-storage/
# This could be useful for file IO: http://www.mattmurrayanimation.com/archives/243
# http://forums.cgsociety.org/archive/index.php/t-671022.html
# http://www.rodgreen.com/?p=250

import os
import maya.cmds as cmds

# Define a new class called Node
# This class will help store a hiearchy of nodes in memory
class Node:

	# Initialize Node
	def __init__(self, name = None, parent=None, childs=None):

		# Create three public attributes inside Node
		# Note that it is easy to add new properties later
		self.name = name
		self.parent = parent
		self.childs = childs

# Function to recurse the selected nodes hiearchy
def recurseNodes( node ):

	# Get the children of the current node
	# Restrict our selection to transforms only.
	childs = cmds.listRelatives( node.name, children = True, type = "transform" )

	childNodes = []

	# Recurse children
	if( childs != None ):
		for child in childs:
			childNode = Node( name = child, parent = node )
			getChild = recurseNodes( childNode )
			childNodes.append( getChild )

	# Set the attributes
	node.childs = childNodes

	return node

# Store only user-created layers.
allLayers = cmds.ls( long=True, type='displayLayer' )
layers = []
for l in allLayers:
	if ( cmds.getAttr( l + ".identification" ) > 0 ):
		layers.append( l )

# Now iterate over each layer.
for l in layers:
	
	# Select everything in the scene.
	cmds.select( all=True )
	sel = cmds.ls( sl=True, type="transform" )

	# Returned nodes
	nodes = []

	# Iterate through selected nodes
	for s in sel:

		# Create an instance of Node
		newNode = Node(name = s)

		# Recurse one the user selected nodes
		getNode = recurseNodes( newNode )

		nodes.append( getNode )

	# Create a new file.
	projectPath = cmds.file( query=True, list=True )[ 0 ]
	fileName = l
	f = open( os.path.abspath( projectPath + '/../Exported JSON/' + fileName + '.json' ), 'w' )

	# Recurse through the nodeList and save each locator name and position to the file.
	def recurseNodeList( node ):

		# Only write contents of the current layer.
		layer = cmds.listConnections( node.name, type="displayLayer" )[0]
		if ( layer == l ):
		
			# Print the current node being recursed through
			# Find out if it's a locator or not through its name (this is hacky!).
			if ( node.name.find( 'locator' ) >= 0 ):
				nameParts = node.name.split( '_' )
				name = nameParts[ 1 ]
				translateX = cmds.getAttr( node.parent.name + '.translateX' )
				translateY = cmds.getAttr( node.parent.name + '.translateY' )
				translateZ = cmds.getAttr( node.parent.name + '.translateZ' )
				f.write( name + ": " + str( translateX ) + ", " + str( translateY ) + ", " + str( translateZ ) )

			# Get the children to iterate through
			childs = node.childs
			for child in childs:
				recurseNodeList( child )

	# This is a bit more complex than just iterating through an array
	# This might seem crazy after using MEL
	# but it can make it easier and faster to look up data
	for node in nodes:
		recurseNodeList( node )

	# Close the file.
	f.close()
