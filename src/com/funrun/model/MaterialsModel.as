package com.funrun.model {
	
	import away3d.materials.MaterialBase;
	
	import org.robotlegs.mvcs.Actor;
	
	public class MaterialsModel extends Actor {
		
		//public static const OBSTACLE_MATERIAL:String = "OBSTACLE_MATERIAL";
		//public static const PLAYER_MATERIAL:String = "PLAYER_MATERIAL";
		//public static const FLOOR_MATERIAL:String = "GROUND_MATERIAL";
		
		private var _materials:Object;
		
		public function MaterialsModel() {
			super();
			_materials = {};
		}
		
		public function addMaterial( id:String, material:MaterialBase ):void {
			_materials[ id ] = material;
		}
		
		public function getMaterial( id:String ):MaterialBase {
			return _materials[ id ];
		}
	}
}
