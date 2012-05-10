package com.funrun.game.controller.commands
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PrimitiveBase;
	import away3d.tools.commands.Merge;
	
	import com.funrun.game.model.BlockTypes;
	import com.funrun.game.model.BlocksModel;
	import com.funrun.game.model.Constants;
	import com.funrun.game.model.MaterialsModel;
	import com.funrun.game.model.ObstaclesModel;
	import com.funrun.game.model.parsers.BlockParser;
	import com.funrun.game.model.parsers.BlockVO;
	import com.funrun.game.model.parsers.ObstacleParser;
	import com.funrun.game.model.parsers.ObstaclesParser;
	import com.funrun.game.services.ObstaclesJsonService;
	
	import flash.geom.Point;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadObstaclesCommand extends Command
	{	
		[Inject]
		public var model:ObstaclesModel;
		
		[Inject]
		public var blocks:BlocksModel;
		
		[Inject]
		public var materials:MaterialsModel;
		
		[Inject]
		public var service:ObstaclesJsonService;
		
		override public function execute():void {
			var obstacles:ObstaclesParser = new ObstaclesParser( service.data );
			var len:int = obstacles.length;
			var geo:PrimitiveBase, mesh:Mesh, minX:int, minZ:int, maxX:int, maxZ:int;
			var merge:Merge = new Merge( true );
			var material:ColorMaterial = materials.getMaterial( MaterialsModel.OBSTACLE_MATERIAL );
			for ( var i:int = 0; i < len; i++ ) {
				var obstacle:ObstacleParser = obstacles.getAt( i );
				var obs:Mesh = new Mesh( new CubeGeometry( 0, 0, 0 ), material );
				minX = 0;
				minZ = 0;
				maxX = 0;
				maxZ = 0;
				for ( var j:int = 0; j < obstacle.numBlocks; j++ ) {
					var data:BlockVO = obstacle.getBlockAt( j );
					var geoData:BlockParser = blocks.getBlock( data.id );
					geo = geoData.geo;
					mesh = new Mesh( geo, material );
					mesh.x = data.x * Constants.BLOCK_SIZE - Constants.TRACK_WIDTH * .5 + Constants.BLOCK_SIZE * .5;
					mesh.y = data.y * Constants.BLOCK_SIZE + Constants.BLOCK_SIZE * .5;
					mesh.z = data.z * Constants.BLOCK_SIZE + Constants.BLOCK_SIZE * .5;
					merge.apply( obs, mesh );
					// Store bounds of obstacle.
					minX = Math.min( data.x, minX );
					minZ = Math.min( data.z, minZ );
					maxX = Math.max( data.x, maxX );
					maxZ = Math.max( data.z, maxZ );
				}
				
				geo = blocks.getBlock( BlockTypes.FLOOR ).geo;
				for ( var x:int = minX; x <= maxX; x ++ ) {
					for ( var z:int = minZ; z <= maxZ; z ++ ) {
						mesh = new Mesh( geo, material );
						mesh.x = x * Constants.BLOCK_SIZE - Constants.TRACK_WIDTH * .5 + Constants.BLOCK_SIZE * .5;
						mesh.y = Constants.BLOCK_SIZE * -.5;
						mesh.z = z * Constants.BLOCK_SIZE + Constants.BLOCK_SIZE * .5;
						merge.apply( obs, mesh );
					}
				}
				
				// Traverse the floorplan of the obstacle.
				
				// If there is no block at or less than 0, add a floor block.
				
				model.addObstacle( obs );
			}
		}
	}
}