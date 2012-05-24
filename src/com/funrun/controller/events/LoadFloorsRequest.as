package com.funrun.controller.events
{
	import flash.events.Event;
	
	public class LoadFloorsRequest extends Event
	{
		public static const LOAD_FLOORS_REQUESTED:String = "LoadFloorsRequest.LOAD_FLOORS_REQUESTED";
		
		public function LoadFloorsRequest( type:String ) {
			super( type );
		}
	}
}