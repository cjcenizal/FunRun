package com.funrun.game.controller.events
{
	import away3d.containers.ObjectContainer3D;
	
	import flash.events.Event;
	
	public class AddSceneObjectFulfilled extends Event
	{
		public static const ADD_SCENE_OBJECT_FULFILLED:String = "AddSceneObjectFulFilled.ADD_SCENE_OBJECT_FULFILLED";
		
		public var object:ObjectContainer3D;
		
		public function AddSceneObjectFulfilled( type:String, object:ObjectContainer3D ) {
			super( type );
			this.object = object;
		}
	}
}
