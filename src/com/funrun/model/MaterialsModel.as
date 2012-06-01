package com.funrun.model {
	
	import away3d.materials.ColorMaterial;
	
	import org.robotlegs.mvcs.Actor;
	
	public class MaterialsModel extends Actor {
		
		public static const OBSTACLE_MATERIAL:String = "OBSTACLE_MATERIAL";
		public static const PLAYER_MATERIAL:String = "PLAYER_MATERIAL";
		public static const GROUND_MATERIAL:String = "GROUND_MATERIAL";
		
		private var _materials:Object;
		
		public function MaterialsModel() {
			super();
			_materials = {};
		}
		
		public function addMaterial( id:String, material:ColorMaterial ):void {
			_materials[ id ] = material;
		}
		
		public function getMaterial( id:String ):ColorMaterial {
			return _materials[ id ];
		}
	}
}
