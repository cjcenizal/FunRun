package com.funrun.controller.commands
{
	import away3d.lights.LightBase;
	
	import com.funrun.model.LightsModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddLightCommand extends Command
	{
		[Inject]
		public var lightName:String;
		
		[Inject]
		public var light:LightBase;
		
		[Inject]
		public var model:LightsModel;
		
		override public function execute():void {
			model.addLight( lightName, light );
		}
	}
}