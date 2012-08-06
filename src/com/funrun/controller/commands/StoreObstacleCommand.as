package com.funrun.controller.commands
{
	import away3d.entities.Mesh;
	import away3d.tools.commands.Merge;
	
	import com.funrun.model.BlocksModel;
	import com.funrun.model.collision.BoundingBoxData;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.vo.BlockVO;
	import com.funrun.model.vo.ObstacleBlockVO;
	import com.funrun.services.parsers.BlockParser;
	import com.funrun.services.parsers.ObstacleParser;
	
	import org.robotlegs.mvcs.Command;
	
	public class StoreObstacleCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var json:Array;
		
		// Models.
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		override public function execute():void {
			var obstacleData:ObstacleParser = new ObstacleParser( json );
			
			// Set up obstacle mesh vars.
			var blockData:ObstacleBlockVO;
			var block:BlockVO;
			var blockMesh:Mesh;
			var obstacleMesh:Mesh = new Mesh();
			var merge:Merge = new Merge( true );
			var boundingBoxes:Array = [];
			
			// A map of all pit locations in the obstacle.
			var pitMap:Object = makePitMap();
			
			// Traverse block data and construct an obstacle mesh, filling in floors where necessary.
			var len:int = obstacleData.numBlockData;
			for ( var i:int = 0; i < len; i++ ) {
				// Get position and mesh data for particular block.
				blockData = obstacleData.getAt( i );
				block = blocksModel.getBlock( blockData.id );
				// Create and position a mesh from data.
				blockMesh = block.mesh.clone() as Mesh;
				blockMesh.x = blockData.x * TrackConstants.BLOCK_SIZE;
				blockMesh.y = blockData.y * TrackConstants.BLOCK_SIZE;
				blockMesh.z = blockData.z * TrackConstants.BLOCK_SIZE;
				// Merge the block mesh into the obstacle mesh.
				merge.apply( obstacleMesh, blockMesh );
				// Add a bounding box so we can collide with the obstacle.
				boundingBoxes.push( new BoundingBoxData(
					blocksModel.getBlock( blockData.id ),
					blockMesh.x, blockMesh.y, blockMesh.z,
					blockMesh.x - TrackConstants.BLOCK_SIZE_HALF,
					blockMesh.y - TrackConstants.BLOCK_SIZE_HALF,
					blockMesh.z - TrackConstants.BLOCK_SIZE_HALF,
					blockMesh.x + TrackConstants.BLOCK_SIZE_HALF,
					blockMesh.y + TrackConstants.BLOCK_SIZE_HALF,
					blockMesh.z + TrackConstants.BLOCK_SIZE_HALF
				) );
				// If the block is below ground-level, it signals a pit.
				if ( blockData.y < 0 ) {
					// So mark it as positive in the pitmap.
					markPitAt( pitMap, blockData.x, blockData.z );
				}
			}
		}
		
		private function makePitMap():Object {
			// TO-DO: Import a Maya obstacle with pits to make sure this logic is sound.
			var pitMap:Object = {};
			for ( var x:Number = 0; x < 12; x++ ) {
				pitMap[ x ] = {};
				for ( var z:Number = 0; z < 24; z++ ) {
					pitMap[ x ][ z ] = false;
				}
			}
			return pitMap;
		}
		
		private function markPitAt( pitMap:Object, posX:Number, posZ:Number ):void {
			pitMap[ Math.round( posX - .5 ) ][ Math.round( posZ - .5 ) ] = true;
		}
		
		
	}
}