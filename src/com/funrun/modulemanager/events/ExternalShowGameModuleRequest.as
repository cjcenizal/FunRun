package com.funrun.modulemanager.events {
	
	import flash.events.Event;

	public class ExternalShowGameModuleRequest extends Event {
		
		public static const EXTERNAL_SHOW_GAME_MODULE_REQUESTED:String = "ExternalShowGameModuleRequest.EXTERNAL_SHOW_GAME_MODULE_REQUESTED";

		public function ExternalShowGameModuleRequest( type:String ) {
			super( type );
		}
	}
}
