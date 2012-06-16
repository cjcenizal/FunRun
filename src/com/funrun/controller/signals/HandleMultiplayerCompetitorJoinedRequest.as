package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	import playerio.Message;

	public class HandleMultiplayerCompetitorJoinedRequest extends Signal {
		
		public function HandleMultiplayerCompetitorJoinedRequest() {
			super( Message );
		}
	}
}
