package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	public class DrawGameMessageRequest extends Signal {
		
		public function DrawGameMessageRequest() {
			super( String );
		}
	}
}
