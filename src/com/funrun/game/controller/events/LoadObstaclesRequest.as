package com.funrun.game.controller.events
{
	import flash.events.Event;
	
	public class LoadObstaclesRequest extends Event
	{
		public static const LOAD_OBSTACLES_REQUESTED:String = "LoadObstaclesRequest.LOAD_OBSTACLES_REQUESTED";
		
		public function LoadObstaclesRequest( type:String ) {
			super( type );
		}
	}
}