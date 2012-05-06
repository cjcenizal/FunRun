package com.funrun.game.controller.commands
{
	import com.funrun.game.model.ObstaclesModel;
	import com.funrun.game.model.parsers.ObstacleParser;
	import com.funrun.game.model.parsers.ObstaclesParser;
	import com.funrun.game.services.ObstaclesJsonService;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadObstaclesCommand extends Command
	{	
		[Inject]
		public var model:ObstaclesModel;
		
		[Inject]
		public var service:ObstaclesJsonService;
		
		override public function execute():void {
			var obstacles:ObstaclesParser = new ObstaclesParser( service.data );
			var len:int = obstacles.length;
			var obstacle:ObstacleParser;
			for ( var i:int = 0; i < len; i++ ) {
				obstacle = obstacles.getAt( i );
				model.addObstacle( obstacle );
			}
		}
	}
}