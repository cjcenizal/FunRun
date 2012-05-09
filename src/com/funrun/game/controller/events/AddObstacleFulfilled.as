package com.funrun.game.controller.events
{
	import away3d.entities.Mesh;
	
	import flash.events.Event;
	
	public class AddObstacleFulfilled extends Event
	{
		public static const ADD_OBSTACLE_FULFILLED:String = "AddObstacleFulfilled.ADD_OBSTACLE_FULFILLED";
		
		public var obstacle:Mesh;
		
		public function AddObstacleFulfilled( type:String, obstacle:Mesh ) {
			super( type );
			this.obstacle = obstacle;
		}
	}
}
