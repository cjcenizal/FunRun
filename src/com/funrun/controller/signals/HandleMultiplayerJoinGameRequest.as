package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	import playerio.Message;

	public class HandleMultiplayerJoinGameRequest extends Signal {
		
		public function HandleMultiplayerJoinGameRequest() {
			super( Message );
		}
	}
}
