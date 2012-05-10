package com.funrun.game.controller.events {
	
	import away3d.entities.Mesh;
	
	import flash.events.Event;
	
	public class AddObstacleToSceneRequest extends Event {
		
		public static const ADD_OBSTACLE_TO_SCENE_REQUESTED:String = "AddObstacleToSceneRequest.ADD_OBSTACLE_TO_SCENE_REQUESTED";
		
		public var obstacle:Mesh;
		
		public function AddObstacleToSceneRequest( type:String, obstacle:Mesh ) {
			super( type );
			this.obstacle = obstacle;
		}
	}
}
