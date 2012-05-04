package com.funrun.game.controller.commands
{
	import com.funrun.game.controller.enum.GameType;
	import com.funrun.game.controller.events.AddLightRequest;
	import com.funrun.game.controller.events.AddMaterialRequest;
	import com.funrun.game.model.LightsModel;
	import com.funrun.game.model.MaterialsModel;
	
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