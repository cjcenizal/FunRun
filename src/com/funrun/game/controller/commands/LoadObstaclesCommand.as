package com.funrun.game.controller.commands
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PrimitiveBase;
	import away3d.tools.commands.Merge;
	
	import com.funrun.game.model.BlocksModel;
	import com.funrun.game.model.MaterialsModel;
	import com.funrun.game.model.ObstaclesModel;
	import com.funrun.game.model.constants.BlockTypes;
	import com.funrun.game.model.constants.TrackConstants;
	import com.funrun.game.model.data.BlockData;
	import com.funrun.game.model.data.ObstacleData;
	import com.funrun.game.model.parsers.BlockParser;
	import com.funrun.game.model.parsers.ObstacleParser;
	import com.funrun.game.model.parsers.ObstaclesParser;
	import com.funrun.game.services.ObstaclesJsonService;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadObstaclesCommand extends Command
	{	
		[Inject]
		public var obstaclesModel:ObstaclesModel;
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		[Inject]
		public var materialsModel:MaterialsModel;
		
		[Inject]
		public var obstaclesService:ObstaclesJsonService;
		
		override public function execute():void {
			var geo:PrimitiveBase, mesh:Mesh, material:ColorMaterial, pitMap:Object, minX:int, minZ:int, maxX:int, maxZ:int;
			var merge:Merge = new Merge( true );
			var obstacles:ObstaclesParser = new ObstaclesParser( obstaclesService.data );
			var len:int = obstacles.length;
			for ( var i:int = 0; i < len; i++ ) {
				material = materialsModel.getMaterial( MaterialsModel.OBSTACLE_MATERIAL );
				var obstacle:ObstacleParser = obstacles.getAt( i );
				var obstacleMesh:Mesh = new Mesh( new CubeGeometry( 0, 0, 0 ), material );
				var boundingBoxes:Array = [];
				pitMap = {};
				minX = 0;
				minZ = 0;
				maxX = TrackConstants.TRACK_WIDTH_BLOCKS - 1;
				maxZ = 0;
				// Add obstacle geometry.
				for ( var j:int = 0; j < obstacle.numBlocks; j++ ) {
					var data:BlockData = obstacle.getBlockAt( j );
					var geoData:BlockParser = blocksModel.getBlock( data.id );
					geo = geoData.geo;
					mesh = new Mesh( geo, material );
					mesh.x = data.x * TrackConstants.BLOCK_SIZE - TrackConstants.TRACK_WIDTH * .5 + TrackConstants.BLOCK_SIZE * .5;
					mesh.y = data.y * TrackConstants.BLOCK_SIZE + TrackConstants.BLOCK_SIZE * .5;
					mesh.z = data.z * TrackConstants.BLOCK_SIZE + TrackConstants.BLOCK_SIZE * .5;
					merge.apply( obstacleMesh, mesh );
					// Store pit location.
					if ( !pitMap[ data.x ] ) {
						pitMap[ data.x ] = {};
					}
					if ( data.y < 0 ) {
						// We only want to store positives, not negative.
						pitMap[ data.x ][ data.z ] = true;
					}
					// Update bounds of obstacle.
					minX = Math.min( data.x, minX );
					minZ = Math.min( data.z, minZ );
					maxX = Math.max( data.x, maxX );
					maxZ = Math.max( data.z, maxZ );
				}
				// Fill in floor geometry wherever no pits exist.
				geo = blocksModel.getBlock( BlockTypes.FLOOR ).geo;
				material = materialsModel.getMaterial( MaterialsModel.GROUND_MATERIAL );
				for ( var x:int = minX; x <= maxX; x ++ ) {
					for ( var z:int = minZ; z <= maxZ; z ++ ) {
						if ( !pitMap[ x ] || !pitMap[ x ][ z ] ) {
							mesh = new Mesh( geo, material );
							mesh.x = x * TrackConstants.BLOCK_SIZE - TrackConstants.TRACK_WIDTH * .5 + TrackConstants.BLOCK_SIZE * .5;
							mesh.y = TrackConstants.BLOCK_SIZE * -.5;
							mesh.z = z * TrackConstants.BLOCK_SIZE + TrackConstants.BLOCK_SIZE * .5;
							merge.apply( obstacleMesh, mesh );
						}
					}
				}
				// Store this sucker.
				obstaclesModel.addObstacle( new ObstacleData( obstacleMesh, boundingBoxes ) );
			}
		}
	}
}