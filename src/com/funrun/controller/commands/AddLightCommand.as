package com.funrun.controller.commands
{
	import com.funrun.controller.events.AddLightRequest;
	import com.funrun.model.LightsModel;
	
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