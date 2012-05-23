package com.funrun.modulemanager.controller.signals.payloads {

	public class ToggleMainMenuOptionsRequestPayload {

		public var enabled:Boolean;

		public function ToggleMainMenuOptionsRequestPayload( enabled:Boolean ) {
			this.enabled = enabled;
		}
	}
}
