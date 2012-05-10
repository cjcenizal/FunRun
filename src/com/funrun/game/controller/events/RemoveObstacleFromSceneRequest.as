package com.funrun.game.controller.events {
	
	import away3d.entities.Mesh;
	
	import flash.events.Event;
	
	public class RemoveObstacleFromSceneRequest extends Event {
		
		public static const REMOVE_OBSTACLE_FROM_SCENE_REQUESTED:String = "RemoveObstacleFromSceneRequest.REMOVE_OBSTACLE_FROM_SCENE_REQUESTED";
		
		public var obstacle:Mesh;
		
		public function RemoveObstacleFromSceneRequest( type:String, obstacle:Mesh ) {
			super( type );
			this.obstacle = obstacle;
		}
	}
}
