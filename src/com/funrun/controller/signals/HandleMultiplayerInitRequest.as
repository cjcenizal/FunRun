package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	import playerio.Message;

	public class HandleMultiplayerInitRequest extends Signal {
		
		public function HandleMultiplayerInitRequest() {
			super( Message );
		}
	}
}
