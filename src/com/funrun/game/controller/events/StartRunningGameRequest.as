package com.funrun.game.controller.events {
	
	import flash.events.Event;

	public class StartRunningGameRequest extends Event {

		public static const START_RUNNING_GAME_REQUESTED:String = "StartRunningGameRequest.START_RUNNING_GAME_REQUESTED";

		public function StartRunningGameRequest( type:String ) {
			super( type );
		}
	}
}
