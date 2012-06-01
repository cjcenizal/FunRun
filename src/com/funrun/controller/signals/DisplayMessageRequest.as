package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	public class DisplayMessageRequest extends Signal {
		
		public function DisplayMessageRequest() {
			super( String );
		}
	}
}
