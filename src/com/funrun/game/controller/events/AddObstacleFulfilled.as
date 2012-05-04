package com.funrun.game.controller.events
{
	import com.funrun.game.model.ObstacleVO;
	import com.funrun.game.view.Obstacle;
	
	import flash.events.Event;
	
	public class AddObstacleFulfilled extends Event
	{
		public static const ADD_OBSTACLE_FULFILLED:String = "AddObstacleFulfilled.ADD_OBSTACLE_FULFILLED";
		
		public var obstacle:Obstacle;
		
		public function AddObstacleFulfilled( type:String, obstacle:Obstacle ) {
			super( type );
			this.obstacle = obstacle;
		}
	}
}
