package com.funrun.modulemanager.controller.events {
	
	import com.funrun.game.controller.signals.payloads.ToggleMainMenuOptionsPayload;
	
	import flash.events.Event;

	public class ExternalToggleMainMenuOptionsRequest extends Event {
		
		public static const EXTERNAL_TOGGLE_MAIN_MENU_OPTIONS_REQUESTED:String = "ExternalToggleMainMenuOptionsRequest.EXTERNAL_TOGGLE_MAIN_MENU_OPTIONS_REQUESTED";
		
		public var payload:ToggleMainMenuOptionsPayload;
		
		public function ExternalToggleMainMenuOptionsRequest( type:String, payload:ToggleMainMenuOptionsPayload ) {
			super( type );
			this.payload = payload;
		}
	}
}
