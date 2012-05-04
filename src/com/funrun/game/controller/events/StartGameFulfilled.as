package com.funrun.game.controller.events
{
	import flash.events.Event;
	
	public class StartGameFulfilled extends Event
	{
		public static const START_GAME_FULFILLED:String = "StartGameFulfilled.START_GAME_FULFILLED";
		
		public function StartGameFulfilled( type:String ) {
			super( type );
		}
	}
}