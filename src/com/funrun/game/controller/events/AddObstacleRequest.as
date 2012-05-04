package com.funrun.game.controller.events
{
	import flash.events.Event;
	
	public class AddObstacleRequest extends Event
	{
		public static const ADD_OBSTACLE_REQUESTED:String = "AddObstacleRequest.ADD_OBSTACLE_REQUESTED";
		
		public function AddObstacleRequest( type:String ) {
			super( type );
		}
	}
}
