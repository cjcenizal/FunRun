package com.funrun.controller.signals {
	
	import org.osflash.signals.Signal;
	import away3d.containers.ObjectContainer3D;
	
	public class AddObjectToSceneRequest extends Signal {
		
		public function AddObjectToSceneRequest() {
			super( ObjectContainer3D );
		}
	}
}
