package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	import playerio.Message;

	public class HandleMultiplayerNewPlayerJoinedRequest extends Signal {
		
		public function HandleMultiplayerNewPlayerJoinedRequest() {
			super( Message );
		}
	}
}
