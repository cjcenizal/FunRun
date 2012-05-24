package com.funrun.controller.commands
{
	import com.funrun.controller.enum.GameType;
	import com.funrun.controller.events.AddLightRequest;
	import com.funrun.controller.events.AddMaterialRequest;
	import com.funrun.model.LightsModel;
	import com.funrun.model.MaterialsModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddMaterialCommand extends Command
	{
		[Inject]
		public var event:AddMaterialRequest;
		
		[Inject]
		public var model:MaterialsModel;
		
		override public function execute():void {
			model.addMaterial( event.id, event.material );
		}
	}
}