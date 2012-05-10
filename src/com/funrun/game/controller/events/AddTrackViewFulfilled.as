package com.funrun.game.controller.events {
	
	import flash.events.Event;
	
	public class AddTrackViewFulfilled extends Event {
		
		public static const ADD_TRACK_FULFILLED:String = "AddTrackViewFulfilled.ADD_TRACK_FULFILLED";
		
		public function AddTrackViewFulfilled( type:String ) {
			super( type );
		}
	}
}
