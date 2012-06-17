package com.funrun.controller.signals {
	
	import com.funrun.model.vo.IPlaceable;
	
	import org.osflash.signals.Signal;
	
	public class RemovePlaceableRequest extends Signal {
		
		public function RemovePlaceableRequest() {
			super( IPlaceable );
		}
	}
}
