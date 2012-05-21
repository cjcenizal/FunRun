package com.funrun.mainmenu.controller.events {
	
	import flash.events.Event;

	public class StopRunningMainMenuRequest extends Event {

		public static const STOP_RUNNING_MAIN_MENU_REQUESTED:String = "StopMainMenuRequest.STOP_RUNNING_MAIN_MENU_REQUESTED";

		public function StopRunningMainMenuRequest( type:String ) {
			super( type );
		}
	}
}
