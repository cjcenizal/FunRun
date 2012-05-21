package com.funrun.game.controller.events {
	
	import flash.events.Event;

	public class ResetPlayerRequest extends Event {

		public static const RESET_PLAYER_REQUESTED:String = "ResetPlayerRequest.RESET_PLAYER_REQUESTED";

		public function ResetPlayerRequest( type:String ) {
			super( type );
		}
	}
}
