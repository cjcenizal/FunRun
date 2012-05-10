package com.funrun.game.controller.events {
	
	import away3d.cameras.Camera3D;
	
	import flash.events.Event;
	
	public class AddCameraFulfilled extends Event {
		
		public static const ADD_CAMERA_FULFILLED:String = "AddCameraFulfilled.ADD_CAMERA_FULFILLED";
		
		public var camera:Camera3D;
		
		public function AddCameraFulfilled( type:String, camera:Camera3D ) {
			super( type );
			this.camera = camera;
		}
	}
}
