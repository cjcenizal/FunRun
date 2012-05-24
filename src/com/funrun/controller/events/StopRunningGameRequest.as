package com.funrun.controller.events {

	import flash.events.Event;

	public class StopRunningGameRequest extends Event {

		public static const STOP_RUNNING_GAME_REQUEST:String = "StopRunningGameRequest.STOP_RUNNING_GAME_REQUEST";

		public function StopRunningGameRequest( type:String ) {
			super( type );
		}
	}
}
