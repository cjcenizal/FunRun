package com.funrun.controller.signals {

	import com.funrun.model.vo.IPlaceable;

	import org.osflash.signals.Signal;

	public class AddPlaceableRequest extends Signal {
		
		public function AddPlaceableRequest() {
			super( IPlaceable );
		}
	}
}
