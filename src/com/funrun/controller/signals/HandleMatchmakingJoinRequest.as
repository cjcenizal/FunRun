package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	import playerio.Message;

	public class HandleMatchmakingJoinRequest extends Signal {
		
		public function HandleMatchmakingJoinRequest() {
			super( Message );
		}
	}
}
