package com.funrun.mainmenu.controller.events {
	
	import flash.events.Event;

	public class ToggleMainMenuOptionsRequest extends Event {

		public static const TOGGLE_MAIN_MENU_OPTIONS_REQUESTED:String = "ToggleMainMenuOptionsRequest.TOGGLE_MAIN_MENU_OPTIONS_REQUESTED";

		public var enabled:Boolean

		public function ToggleMainMenuOptionsRequest( type:String, enabled:Boolean ) {
			super( type );
			this.enabled = enabled;
		}
	}
}
