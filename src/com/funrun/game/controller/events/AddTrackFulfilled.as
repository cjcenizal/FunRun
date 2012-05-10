package com.funrun.game.controller.events {
	
	import flash.events.Event;
	
	public class AddTrackFulfilled extends Event {
		
		public static const ADD_TRACK_FULFILLED:String = "AddTrackFulfilled.ADD_TRACK_FULFILLED";
		
		public function AddTrackFulfilled( type:String ) {
			super( type );
		}
	}
}
