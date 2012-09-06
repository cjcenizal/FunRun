package com.funrun.model {
	
	import away3d.lights.LightBase;
	import away3d.materials.lightpickers.LightPickerBase;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.SoftShadowMapMethod;
	
	import org.robotlegs.mvcs.Actor;
	
	public class LightsModel extends Actor {
		
		public static const SUN:String = "SUN";
		public static const SPOTLIGHT:String = "SPOTLIGHT";
		private var _lights:Object;
		public var lightPicker:StaticLightPicker;
		public var shadowMethod:SoftShadowMapMethod;
		
		public function LightsModel() {
			super();
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
