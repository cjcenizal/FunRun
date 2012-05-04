package com.funrun.game.controller.events
{
	import com.funrun.game.model.ObstacleVO;
	
	import flash.events.Event;
	
	public class AddObstacleFulfilled extends Event
	{
		public static const ADD_OBSTACLE_FULFILLED:String = "AddObstacleFulfilled.ADD_OBSTACLE_FULFILLED";
		
		public var data:ObstacleVO;
		
		public function AddObstacleFulfilled( type:String, data:ObstacleVO ) {
			super( type );
			this.data = data;
		}
	}
}
