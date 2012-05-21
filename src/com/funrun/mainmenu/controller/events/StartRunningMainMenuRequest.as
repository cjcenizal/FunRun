package com.funrun.mainmenu.controller.events {
	
	import flash.events.Event;

	public class StartRunningMainMenuRequest extends Event {

		public static const START_RUNNING_MAIN_MENU_REQUESTED:String = "StartRunningMainMenuRequest.START_RUNNING_MAIN_MENU_REQUESTED";

		public function StartRunningMainMenuRequest( type:String ) {
			super( type );
		}
	}
}
