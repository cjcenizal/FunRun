package com.funrun.game.controller.events {
	
	import flash.events.Event;

	public class StartGameRequest extends Event {

		public static const START_GAME_REQUESTED:String = "StartGameRequest.START_GAME_REQUESTED";

		public function StartGameRequest( type:String ) {
			super( type );
		}
	}
}
