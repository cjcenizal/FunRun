package com.funrun.game.controller.events
{
	import away3d.materials.ColorMaterial;
	
	import flash.events.Event;
	
	public class AddMaterialRequest extends Event
	{
		public static const ADD_MATERIAL_REQUESTED:String = "AddMaterialRequest.ADD_MATERIAL_REQUESTED";
		
		public var id:String;
		public var material:ColorMaterial;
		
		public function AddMaterialRequest( type:String, id:String, material:ColorMaterial ) {
			super( type );
			this.id = id;
			this.material = material;
		}
	}
}
