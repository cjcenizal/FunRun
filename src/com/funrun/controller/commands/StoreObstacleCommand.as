package com.funrun.controller.commands
{
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.tools.commands.Merge;
	
	import com.funrun.model.BlocksModel;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.vo.BoundingBoxVO;
	import com.funrun.model.constants.Block;
	import com.funrun.model.constants.Materials;
	import com.funrun.model.constants.Segment;
	import com.funrun.model.state.ShowBoundsState;
	import com.funrun.model.vo.BlockVO;
	import com.funrun.model.vo.ObstacleBlockVO;
	import com.funrun.model.vo.SegmentVO;
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
		
		[Inject]
		public var segmentsModel:SegmentsModel;
		
		// State.
		
		[Inject]
		public var showBoundsState:ShowBoundsState;
		
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
				blockMesh.x = blockData.x * Block.SIZE;
				blockMesh.y = blockData.y * Block.SIZE;
				blockMesh.z = blockData.z * Block.SIZE;
				// Merge the block mesh into the obstacle mesh.
				merge.apply( obstacleMesh, blockMesh );
				// Add a bounding box so we can collide with the obstacle.
				boundingBoxes.push( new BoundingBoxVO(
					block,
					blockMesh.x, blockMesh.y, blockMesh.z,
					-Block.HALF_SIZE,
					-Block.HALF_SIZE,
					-Block.HALF_SIZE,
					Block.HALF_SIZE,
					Block.HALF_SIZE,
					Block.HALF_SIZE
				) );
				// If the block is below ground-level, it signals a pit.
				if ( blockData.y < 0 ) {
					// So mark it as positive in the pitmap.
					markPitAt( pitMap, blockData.x - .5, blockData.z - .5 );
				}
			}
			
			//  Fill in floors where necessary.
			var floorBlockRefMesh:Mesh = blocksModel.getBlock( "floor" ).mesh;
			var floorBlockMesh:Mesh;
			for ( var x:int = 0; x < Segment.NUM_BLOCKS_WIDE; x++ ) {
				for ( var z:int = 0; z < Segment.NUM_BLOCKS_DEPTH; z++ ) {
					// Put floor blocks wherever the pit map is negative.
					if ( !pitMap[ x ] || !pitMap[ x ][ z ] ) {
						// Create a floor block mesh in the appropriate place.
						floorBlockMesh = floorBlockRefMesh.clone() as Mesh;
						floorBlockMesh.x = x * Block.SIZE + Block.HALF_SIZE;
						floorBlockMesh.y = -1 * Block.SIZE;
						floorBlockMesh.z = z * Block.SIZE;
						// Merge it into the obstacle.
						merge.apply( obstacleMesh, floorBlockMesh );
						// Add a bounding box so we can collide with the floor.
						boundingBoxes.push( new BoundingBoxVO(
							blocksModel.getBlock( "floor" ),
							floorBlockMesh.x, floorBlockMesh.y, floorBlockMesh.z,
							-Block.HALF_SIZE,
							-Block.HALF_SIZE,
							-Block.HALF_SIZE,
							Block.HALF_SIZE,
							Block.HALF_SIZE,
							Block.HALF_SIZE
						) );
					}
				}
			}
			
			// Add a bounds indicator.
			var boundsMesh:Mesh = null;
			if ( showBoundsState.showBounds ) {
				boundsMesh = new Mesh();
				var blockGeo:Geometry = new CubeGeometry( Block.SIZE, Block.SIZE, Block.SIZE );
				var len:int = boundingBoxes.length;
				var box:BoundingBoxVO;
				var indicator:Mesh;
				for ( var i:int = 0; i < len; i++ ) {
					box = boundingBoxes[ i ];
					indicator = new Mesh( blockGeo, Materials.DEBUG_BLOCK );
					indicator.x = box.x;
					indicator.y = box.y;
					indicator.z = box.z;
					merge.apply( boundsMesh, indicator );
				}
			}
			
			var obstacle:SegmentVO = new SegmentVO( blockData.id, obstacleMesh, boundsMesh, boundingBoxes,
			obstacleMesh.bounds.min.x, obstacleMesh.bounds.min.y, obstacleMesh.bounds.min.z,
			obstacleMesh.bounds.max.x, obstacleMesh.bounds.max.y, obstacleMesh.bounds.max.z );
			segmentsModel.storeObstacle( obstacle );
		}
		
		private function makePitMap():Object {
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
			pitMap[ Math.round( posX ) ][ Math.round( posZ ) ] = true;
		}
		
		
	}
}