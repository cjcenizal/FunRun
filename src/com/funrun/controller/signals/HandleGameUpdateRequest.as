package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	import playerio.Message;

	public class HandleGameUpdateRequest extends Signal {
		
		public function HandleGameUpdateRequest() {
			super( Message );
		}
	}
}
