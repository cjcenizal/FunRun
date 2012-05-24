package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	public class ShowScreenRequest extends Signal {
		
		public function ShowScreenRequest() {
			super( String );
		}
	}
}
