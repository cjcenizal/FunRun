package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	import playerio.Message;

	public class HandleGameCompetitorJoinedRequest extends Signal {
		
		public function HandleGameCompetitorJoinedRequest() {
			super( Message );
		}
	}
}
