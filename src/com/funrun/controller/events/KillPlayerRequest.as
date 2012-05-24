package com.funrun.controller.events
{
	import flash.events.Event;

	public class KillPlayerRequest extends Event
	{
		public static const KILL_PLAYER_REQUESTED:String = "KillPlayerRequest.KILL_PLAYER_REQUESTED";
		
		public var death:String;
		
		public function KillPlayerRequest( type:String, death:String )
		{
			super( type );
			this.death = death;
		}
	}
}