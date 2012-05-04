package com.funrun.game.model {
	
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.PrimitiveBase;
	
	public class MaterialsModel {
		
		public const OBSTACLE_MATERIAL:String = "OBSTACLE_MATERIAL";
		public const PLAYER_MATERIAL:String = "PLAYER_MATERIAL";
		public const GROUND_MATERIAL:String = "GROUND_MATERIAL";
		private var _materials:Object;
		
		public function MaterialsModel() {
			_materials = {};
			_materials[ PLAYER_MATERIAL ] = new ColorMaterial( 0x00FF00 );
			_materials[ GROUND_MATERIAL ] = new ColorMaterial( 0xFF0000 );
			_materials[ OBSTACLE_MATERIAL ] = new ColorMaterial( 0x0000FF );
		}
		
		public function getMaterial( id:String ):ColorMaterial {
			return _geos[ id ];
		}
	}
}
