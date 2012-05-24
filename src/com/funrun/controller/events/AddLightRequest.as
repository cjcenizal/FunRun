package com.funrun.controller.events
{
	import away3d.lights.LightBase;
	
	import flash.events.Event;
	
	public class AddLightRequest extends Event
	{
		public static const ADD_LIGHT_REQUESTED:String = "AddLightRequest.ADD_LIGHT_REQUESTED";
		
		public var id:String;
		public var light:LightBase;
		
		public function AddLightRequest( type:String, id:String, light:LightBase ) {
			super( type );
			this.id = id;
			this.light = light;
		}
	}
}
