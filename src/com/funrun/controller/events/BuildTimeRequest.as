package com.funrun.controller.events
{
	import flash.events.Event;
	
	public class BuildTimeRequest extends Event
	{
		public static const BUILD_TIME_REQUESTED:String = "BuildTimeRequest.BUILD_TIME_REQUESTED";
		
		public function BuildTimeRequest( type:String ) {
			super( type );
		}
	}
}