package com.funrun.game.controller.commands
{
	import com.funrun.game.controller.enum.GameType;
	import com.funrun.game.controller.events.AddLightRequest;
	import com.funrun.game.model.LightsModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddLightCommand extends Command
	{
		[Inject]
		public var event:AddLightRequest;
		
		[Inject]
		public var model:LightsModel;
		
		override public function execute():void {
			model.addLight( event.id, event.light );
		}
	}
}