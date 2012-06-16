package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	import playerio.Message;

	public class HandleMultiplayerCompetitorDiedRequest extends Signal {
		
		public function HandleMultiplayerCompetitorDiedRequest() {
			super( Message );
		}
	}
}
