package com.funrun.controller.events
{
	import flash.events.Event;

	public class BuildGameRequest extends Event
	{
		public static const BUILD_GAME_REQUESTED:String = "BuildGameRequest.BUILD_GAME_REQUESTED";

		public function BuildGameRequest( type:String ) {
			super( type );
		}
	}
}