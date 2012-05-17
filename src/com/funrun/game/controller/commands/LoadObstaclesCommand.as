package com.funrun.game.controller.commands {
	
	import away3d.materials.ColorMaterial;
	
	import com.funrun.game.model.BlocksModel;
	import com.funrun.game.model.MaterialsModel;
	import com.funrun.game.model.ObstaclesModel;
	import com.funrun.game.model.collision.ObstacleData;
	import com.funrun.game.model.parsers.ObstacleParser;
	import com.funrun.game.model.parsers.ObstaclesParser;
	import com.funrun.game.services.ObstaclesJsonService;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadObstaclesCommand extends Command {
		[Inject]
		public var obstaclesModel:ObstaclesModel;
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		[Inject]
		public var materialsModel:MaterialsModel;
		
		[Inject]
		public var obstaclesService:ObstaclesJsonService;
		
		override public function execute():void {
			var material:ColorMaterial = materialsModel.getMaterial( MaterialsModel.OBSTACLE_MATERIAL );
			var obstacles:ObstaclesParser = new ObstaclesParser( obstaclesService.data );
			var len:int = obstacles.length;
			for ( var i:int = 0; i < len; i++ ) {
				var obstacle:ObstacleParser = obstacles.getAt( i );
				// Store this sucker.
				obstaclesModel.addObstacle( ObstacleData.make( blocksModel, materialsModel, obstacle ) );
				if ( obstacle.flip ) {
					// Store mirror version if required.
					obstaclesModel.addObstacle( ObstacleData.make( blocksModel, materialsModel, obstacle, true ) );
				}
			}
		}
	}
}