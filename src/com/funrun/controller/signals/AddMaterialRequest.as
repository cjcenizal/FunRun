package com.funrun.controller.signals {
	
	import away3d.materials.ColorMaterial;
	
	import org.osflash.signals.Signal;
	
	public class AddMaterialRequest extends Signal {
		
		public function AddMaterialRequest() {
			super( String, ColorMaterial );
		}
	}
}
