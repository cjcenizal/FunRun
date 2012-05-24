package com.funrun.controller.events {
	
	import flash.events.Event;

	public class ResetGameRequest extends Event {

		public static const RESET_GAME_REQUESTED:String = "ResetGameRequest.DistanceModel";

		public function ResetGameRequest( type:String ) {
			super( type );
		}
	}
}
