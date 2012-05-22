package com.funrun.modulemanager.controller.events {
	
	import flash.events.Event;

	public class ExternalToggleMainMenuOptionsRequest extends Event {
		
		public static const EXTERNAL_TOGGLE_MAIN_MENU_OPTIONS_REQUESTED:String = "ExternalToggleMainMenuOptionsRequest.EXTERNAL_TOGGLE_MAIN_MENU_OPTIONS_REQUESTED";
		
		public var enabled:Boolean;
		
		public function ExternalToggleMainMenuOptionsRequest( type:String, enabled:Boolean ) {
			super( type );
			this.enabled = enabled;
		}
	}
}
