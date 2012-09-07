package com.funrun.controller.commands
{
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.tools.commands.Merge;
	
	import com.funrun.model.BlocksModel;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.constants.Block;
	import com.funrun.model.constants.Collisions;
	import com.funrun.model.constants.Materials;
	import com.funrun.model.constants.Segment;
	import com.funrun.model.state.ShowBoundsState;
	import com.funrun.model.vo.BlockVo;
	import com.funrun.model.vo.BoundingBoxVo;
	import com.funrun.model.vo.CollidableVo;
	import com.funrun.model.vo.ObstacleBlockVo;
	import com.funrun.model.vo.PointVo;
	import com.funrun.model.vo.SegmentVo;
	import com.funrun.model.vo.StoreObstacleVo;
	import com.funrun.services.parsers.ObstacleParser;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	public class StoreObstacleCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var vo:StoreObstacleVo;
		
		// Models.
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		[Inject]
		public var segmentsModel:SegmentsModel;
		
		// State.
		
		[Inject]
		public var showBoundsState:ShowBoundsState;
		
		override public function execute():void {
			var obstacleData:ObstacleParser = new ObstacleParser( vo.blocks );
			
			// Set up obstacle mesh vars.
			var blockData:ObstacleBlockVo;
			var block:BlockVo;
			var blockMesh:Mesh;
			var obstacleMesh:Mesh = new Mesh( new Geometry() );
			var merge:Merge = new Merge( true );
			var boundingBoxes:Array = [];
			
			// Store min/max.
			var min:CollidableVo = new CollidableVo();
			var max:CollidableVo = new CollidableVo();
			
			// Points.
			var points:Array = new Array();
			
			// Traverse block data and construct an obstacle mesh.
			var len:int = obstacleData.numBlockData;
			for ( var i:int = 0; i < len; i++ ) {
				// Get position and mesh data for particular block.
				blockData = obstacleData.getAt( i );
				block = blocksModel.getBlock( blockData.id );
				if ( block.id == "point" ) {
					// Store points internally.
					points.push( new PointVo( i, block, blockData.x * Block.SIZE, blockData.y * Block.SIZE, blockData.z * Block.SIZE ) );
				} else {
					// Create and position a mesh from data.
					blockMesh = block.mesh.clone() as Mesh;
					blockMesh.x = blockData.x * Block.SIZE;
					blockMesh.y = blockData.y * Block.SIZE;
					blockMesh.z = blockData.z * Block.SIZE;
					// Merge the block mesh into the obstacle mesh.
					merge.apply( obstacleMesh, blockMesh );
				}
				// Add a bounding box so we can collide with the obstacle.
				var box:BoundingBoxVo = new BoundingBoxVo(
					i, block,
					blockMesh.x, blockMesh.y, blockMesh.z,
					block.boundsMin.x, block.boundsMin.y, block.boundsMin.z,
					block.boundsMax.x, block.boundsMax.y, block.boundsMax.z
				);
				boundingBoxes.push( box );
				min.takeMinFrom( box );
				max.takeMaxFrom( box );
			}
			
			// Add a bounds indicator.
			var boundsMesh:Mesh = null;
			if ( showBoundsState.showBounds ) {
				boundsMesh = new Mesh( new Geometry() );
				var len:int = boundingBoxes.length;
				var box:BoundingBoxVo;
				var indicator:Mesh;
				for ( var i:int = 0; i < len; i++ ) {
					box = boundingBoxes[ i ];
					var blockGeo:Geometry = new CubeGeometry( box.width, box.height, box.depth );
					indicator = new Mesh( blockGeo, Materials.DEBUG_BLOCK );
					indicator.x = box.x;
					indicator.y = box.y;
					indicator.z = box.z;
					merge.apply( boundsMesh, indicator );
				}
			}
			
			var obstacle:SegmentVo = new SegmentVo( vo.filename, obstacleMesh, boundsMesh, boundingBoxes,
				min.worldMinX, min.worldMinY, min.worldMinZ,
				max.worldMaxX, max.worldMaxY, max.worldMaxZ );
			obstacle.storePoints( points );
			segmentsModel.storeObstacle( obstacle );
		}
	}
}