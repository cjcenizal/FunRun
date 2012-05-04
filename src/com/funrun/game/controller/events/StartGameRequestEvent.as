package com.funrun.game.controller.events
{
	import flash.events.Event;

	public class StartGameRequestEvent extends Event
	{
		public static const START_GAME_REQUESTED:String = "GameEvent.START_GAME_REQUESTED";

		public function StartGameRequestEvent( type:String ) {
			super( type );
		}
	}
}
