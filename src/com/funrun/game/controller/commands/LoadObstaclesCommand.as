package com.funrun.game.controller.commands
{
	import com.funrun.game.model.ObstaclesModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadObstaclesCommand extends Command
	{	
		[Inject]
		public var model:ObstaclesModel;
		
		override public function execute():void {
		}
	}
}