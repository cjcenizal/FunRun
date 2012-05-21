package com.funrun.game.controller.events {

	import flash.events.Event;

	public class StopGameRequest extends Event {

		public static const STOP_GAME_REQUESTED:String = "StopGameRequest.STOP_GAME_REQUESTED";

		public function StopGameRequest( type:String ) {
			super( type );
		}
	}
}
