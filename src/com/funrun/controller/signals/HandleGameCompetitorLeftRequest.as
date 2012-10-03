package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	import playerio.Message;

	public class HandleGameCompetitorLeftRequest extends Signal {
		
		public function HandleGameCompetitorLeftRequest() {
			super( Message );
		}
	}
}
