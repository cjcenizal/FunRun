package com.funrun.modulemanager.events {
	
	import flash.events.Event;

	public class ExternalShowMainMenuModuleRequest extends Event {

		public static const EXTERNAL_SHOW_MAIN_MENU_MODULE_REQUESTED:String = "ExternalShowMainMenuModuleRequest.EXTERNAL_SHOW_MAIN_MENU_MODULE_REQUESTED";

		public function ExternalShowMainMenuModuleRequest( type:String ) {
			super( type );
		}
	}
}
