package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	import playerio.Message;

	public class HandleMultiplayerPlayerLeftRequest extends Signal {
		
		public function HandleMultiplayerPlayerLeftRequest() {
			super( Message );
		}
	}
}
