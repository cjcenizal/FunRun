package com.funrun.game.controller.commands
{
	import com.funrun.game.controller.enum.GameType;
	import com.funrun.game.controller.events.AddObstacleFulfilled;
	import com.funrun.game.model.ObstaclesModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddObstacleCommand extends Command
	{
		[Inject]
		public var model:ObstaclesModel;
		
		override public function execute():void {
			trace(this, "exec");
			eventDispatcher.dispatchEvent( new AddObstacleFulfilled( AddObstacleFulfilled.ADD_OBSTACLE_FULFILLED, model.getRandomObstacle() ) );
		}
	}
}