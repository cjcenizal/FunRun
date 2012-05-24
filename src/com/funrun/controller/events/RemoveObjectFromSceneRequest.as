package com.funrun.controller.events {
	
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	
	import flash.events.Event;
	
	public class RemoveObjectFromSceneRequest extends Event {
		
		public static const REMOVE_OBSTACLE_FROM_SCENE_REQUESTED:String = "RemoveObstacleFromSceneRequest.REMOVE_OBSTACLE_FROM_SCENE_REQUESTED";
		
		public var object:ObjectContainer3D;
		
		public function RemoveObjectFromSceneRequest( type:String, object:ObjectContainer3D ) {
			super( type );
			this.object = object;
		}
	}
}
