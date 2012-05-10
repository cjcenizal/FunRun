package com.funrun.game.controller.events {
	
	import flash.events.Event;
	
	public class AddPlayerRequest extends Event {
		
		public static const ADD_PLAYER_REQUESTED:String = "AddPlayerRequest.ADD_PLAYER_REQUESTED";
		
		public function AddPlayerRequest( type:String ) {
			super( type );
		}
	}
}
