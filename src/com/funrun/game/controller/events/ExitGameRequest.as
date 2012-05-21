package com.funrun.game.controller.events {
	
	import flash.events.Event;

	public class ExitGameRequest extends Event {

		public static const EXIT_GAME_REQUESTED:String = "ExitGameRequest.EXIT_GAME_REQUESTED";

		public function ExitGameRequest( type:String ) {
			super( type );
		}
	}
}
