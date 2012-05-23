package com.funrun.modulemanager.controller.events {
	
	import com.funrun.modulemanager.controller.signals.payloads.ToggleMainMenuOptionsRequestPayload;
	
	import flash.events.Event;

	public class ExternalToggleMainMenuOptionsRequest extends Event {
		
		public static const EXTERNAL_TOGGLE_MAIN_MENU_OPTIONS_REQUESTED:String = "ExternalToggleMainMenuOptionsRequest.EXTERNAL_TOGGLE_MAIN_MENU_OPTIONS_REQUESTED";
		
		public var payload:ToggleMainMenuOptionsRequestPayload;
		
		public function ExternalToggleMainMenuOptionsRequest( type:String, payload:ToggleMainMenuOptionsRequestPayload ) {
			super( type );
			this.payload = payload;
		}
	}
}
