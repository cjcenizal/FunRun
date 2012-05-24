package com.funrun.controller.commands
{
	import away3d.materials.ColorMaterial;
	
	import com.funrun.model.MaterialsModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddMaterialCommand extends Command
	{
		[Inject]
		public var materialName:String;
		
		[Inject]
		public var material:ColorMaterial;
		
		[Inject]
		public var model:MaterialsModel;
		
		override public function execute():void {
			model.addMaterial( materialName, material );
		}
	}
}