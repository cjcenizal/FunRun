package com.funrun.game.model {
	
	import away3d.lights.LightBase;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.PrimitiveBase;
	
	public class LightsModel {
		
		public static const SUN:String = "SUN";
		public static const SPOTLIGHT:String = "SPOTLIGHT";
		private var _lights:Object;
		
		public function LightsModel() {
			_lights = {};
		}
		
		public function addLight( id:String, light:LightBase ):void {
			_lights[ id ] = light;
		}
		
		public function getLight( id:String ):LightBase {
			return _lights[ id ];
		}
	}
}