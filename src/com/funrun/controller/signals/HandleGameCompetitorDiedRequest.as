package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	import playerio.Message;

	public class HandleGameCompetitorDiedRequest extends Signal {
		
		public function HandleGameCompetitorDiedRequest() {
			super( Message );
		}
	}
}
