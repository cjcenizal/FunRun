package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	public class DrawMessageRequest extends Signal {
		
		public function DrawMessageRequest() {
			super( String );
		}
	}
}
