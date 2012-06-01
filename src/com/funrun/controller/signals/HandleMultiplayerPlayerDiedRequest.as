package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	import playerio.Message;

	public class HandleMultiplayerPlayerDiedRequest extends Signal {
		
		public function HandleMultiplayerPlayerDiedRequest() {
			super( Message );
		}
	}
}
