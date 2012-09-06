package com.funrun.controller.commands
{
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.tools.commands.Merge;
	
	import com.funrun.model.BlocksModel;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.vo.BoundingBoxVo;
	import com.funrun.model.constants.Block;
	import com.funrun.model.constants.Materials;
	import com.funrun.model.constants.Segment;
	import com.funrun.model.state.ShowBoundsState;
	import com.funrun.model.vo.BlockVo;
	import com.funrun.model.vo.ObstacleBlockVo;
	import com.funrun.model.vo.SegmentVo;
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
			var blockData:ObstacleBlockVo;
			var block:BlockVo;
			var blockMesh:Mesh;
			var obstacleMesh:Mesh = new Mesh( new Geometry() );
			var merge:Merge = new Merge( true );
			var boundingBoxes:Array = [];
			
			// Traverse block data and construct an obstacle mesh.
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
				boundingBoxes.push( new BoundingBoxVo(
					block,
					blockMesh.x, blockMesh.y, blockMesh.z,
					-Block.HALF_SIZE,
					-Block.HALF_SIZE,
					-Block.HALF_SIZE,
					Block.HALF_SIZE,
					Block.HALF_SIZE,
					Block.HALF_SIZE
				) );
			}
			
			// Add a bounds indicator.
			var boundsMesh:Mesh = null;
			if ( showBoundsState.showBounds ) {
				boundsMesh = new Mesh( new Geometry() );
				var blockGeo:Geometry = new CubeGeometry( Block.SIZE, Block.SIZE, Block.SIZE );
				var len:int = boundingBoxes.length;
				var box:BoundingBoxVo;
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
			
			var obstacle:SegmentVo = new SegmentVo( obstacleMesh, boundsMesh, boundingBoxes,
				obstacleMesh.bounds.min.x, obstacleMesh.bounds.min.y, obstacleMesh.bounds.min.z,
				obstacleMesh.bounds.max.x, obstacleMesh.bounds.max.y, obstacleMesh.bounds.max.z );
			segmentsModel.storeObstacle( obstacle );
		}
	}
}