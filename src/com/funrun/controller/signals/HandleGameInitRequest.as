package com.funrun.controller.signals {

	import org.osflash.signals.Signal;

	import playerio.Message;

	public class HandleGameInitRequest extends Signal {
		
		public function HandleGameInitRequest() {
			super( Message );
		}
	}
}
