package com.funrun.game.controller.events {
	
	import flash.events.Event;
	
	public class EnablePlayerInputRequest extends Event {
		public static const ENABLE_PLAYER_INPUT_REQUESTED:String = "EnablePlayerInputRequest.ENABLE_PLAYER_INPUT_REQUESTED";
		
		public function EnablePlayerInputRequest( type:String ) {
			super( type );
		}
	}
}
