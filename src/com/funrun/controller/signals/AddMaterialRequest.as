package com.funrun.controller.signals {
	
	import away3d.materials.ColorMaterial;
	import away3d.materials.MaterialBase;
	
	import org.osflash.signals.Signal;
	
	public class AddMaterialRequest extends Signal {
		
		public function AddMaterialRequest() {
			super( String, MaterialBase );
		}
	}
}
