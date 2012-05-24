package com.funrun.controller.events {
	
	import flash.events.Event;

	public class InternalShowMainMenuRequest extends Event {

		public static const INTERNAL_SHOW_MAIN_MENU_REQUESTED:String = "InternalShowMainMenuRequest.INTERNAL_SHOW_MAIN_MENU_REQUESTED";

		public function InternalShowMainMenuRequest( type:String ) {
			super( type );
		}
	}
}
