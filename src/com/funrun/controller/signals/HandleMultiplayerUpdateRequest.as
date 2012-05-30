package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	import playerio.Message;

	public class HandleMultiplayerUpdateRequest extends Signal {
		
		public function HandleMultiplayerUpdateRequest() {
			super( Message );
		}
	}
}
