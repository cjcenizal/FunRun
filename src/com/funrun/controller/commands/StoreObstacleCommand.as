package com.funrun.controller.commands
{
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.primitives.CubeGeometry;
	import away3d.tools.commands.Merge;
	
	import com.funrun.controller.signals.vo.StoreObstacleVo;
	import com.funrun.model.BlockStylesModel;
	import com.funrun.model.BlockTypesModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.constants.Block;
	import com.funrun.model.constants.Materials;
	import com.funrun.model.vo.BlockStyleVo;
	import com.funrun.model.vo.BlockTypeVo;
	import com.funrun.model.vo.BoundingBoxVo;
	import com.funrun.model.vo.CollidableVo;
	import com.funrun.model.vo.ObstacleBlockVo;
	import com.funrun.model.vo.PointVo;
	import com.funrun.model.vo.SegmentVo;
	import com.funrun.services.parsers.ObstacleParser;
	
	import org.robotlegs.mvcs.Command;
	
	public class StoreObstacleCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var vo:StoreObstacleVo;
		
		// Models.
		
		[Inject]
		public var blockTypesModel:BlockTypesModel;
		
		[Inject]
		public var blockStylesModel:BlockStylesModel;
		
		[Inject]
		public var segmentsModel:SegmentsModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		override public function execute():void {
			var obstacleData:ObstacleParser = new ObstacleParser( vo.blocks );
			
			for ( var j:int = 0; j < blockStylesModel.numStyles; j++ ) {
				var style:BlockStyleVo = blockStylesModel.getStyleAt( j );
				blockStylesModel.currentStyle = style;
			
				// Set up obstacle mesh vars.
				var blockData:ObstacleBlockVo;
				var blockType:BlockTypeVo;
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
					trace(blockData)
					blockType = blockTypesModel.getWithId( blockData.id );
					if ( !( blockType.id == "point" && !gameModel.usePoints ) ) {
						if ( blockType.id == "point" ) {
							// Store points internally.
							points.push( new PointVo( i, blockType, blockData.x * Block.SIZE, blockData.y * Block.SIZE, blockData.z * Block.SIZE ) );
						} else {
							// Create and position a mesh from data.
							blockMesh = blockStylesModel.getMeshCloneForBlock( blockType.id );
							blockMesh.x = blockData.x * Block.SIZE;
							blockMesh.y = blockData.y * Block.SIZE;
							blockMesh.z = blockData.z * Block.SIZE;
							// Merge the block mesh into the obstacle mesh.
							merge.apply( obstacleMesh, blockMesh );
						}
						// Add a bounding box so we can collide with the obstacle.
						var box:BoundingBoxVo = new BoundingBoxVo(
							i, blockType,
							blockData.x * Block.SIZE, blockData.y * Block.SIZE, blockData.z * Block.SIZE,
							blockType.boundsMin.x, blockType.boundsMin.y, blockType.boundsMin.z,
							blockType.boundsMax.x, blockType.boundsMax.y, blockType.boundsMax.z
						);
						boundingBoxes.push( box );
						min.takeMinFrom( box );
						max.takeMaxFrom( box );
					}
				}
				
				// Add a bounds indicator.
				var boundsMesh:Mesh = null;
				if ( gameModel.showBounds ) {
					boundsMesh = new Mesh( new Geometry() );
					var len2:int = boundingBoxes.length;
					var box2:BoundingBoxVo;
					var indicator:Mesh;
					for ( var k:int = 0; k < len2; k++ ) {
						box2 = boundingBoxes[ k ];
						var blockGeo:Geometry = new CubeGeometry( box2.width, box2.height, box2.depth );
						indicator = new Mesh( blockGeo, Materials.DEBUG_BLOCK );
						indicator.x = box2.x;
						indicator.y = box2.y;
						indicator.z = box2.z;
						merge.apply( boundsMesh, indicator );
					}
				}
				
				var obstacle:SegmentVo = new SegmentVo( vo.filename, obstacleMesh, boundsMesh, boundingBoxes,
					min.worldMinX, min.worldMinY, min.worldMinZ,
					max.worldMaxX, max.worldMaxY, max.worldMaxZ );
				obstacle.storePoints( points );
				segmentsModel.storeObstacle( style.id, obstacle );
			}
		}
	}
}