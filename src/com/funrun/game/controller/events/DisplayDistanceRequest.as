package com.funrun.game.controller.events {
	
	import flash.events.Event;
	
	public class DisplayDistanceRequest extends Event {
		
		public static const DISPLAY_DISTANCE_REQUESTED:String = "DisplayDistanceRequest.DISPLAY_DISTANCE_REQUESTED";
		
		public var distance:Number;
		
		public function DisplayDistanceRequest( type:String, distance:Number ) {
			super( type );
			this.distance = distance;
		}
	}
}
