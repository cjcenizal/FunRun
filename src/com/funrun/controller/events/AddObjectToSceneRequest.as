package com.funrun.controller.events {
	
	import away3d.containers.ObjectContainer3D;
	
	import flash.events.Event;
	
	public class AddObjectToSceneRequest extends Event {
		
		public static const ADD_OBSTACLE_TO_SCENE_REQUESTED:String = "AddObstacleToSceneRequest.ADD_OBSTACLE_TO_SCENE_REQUESTED";
		
		public var object:ObjectContainer3D;
		
		public function AddObjectToSceneRequest( type:String, object:ObjectContainer3D ) {
			super( type );
			this.object = object;
		}
	}
}
