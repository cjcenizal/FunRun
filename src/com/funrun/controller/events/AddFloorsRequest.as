package com.funrun.controller.events {
	
	import flash.events.Event;

	public class AddFloorsRequest extends Event {
		
		public static const ADD_FLOORS_REQUESTED:String = "AddFloorRequest.ADD_FLOORS_REQUESTED";
		
		public var startPos:Number;
		public var endPos:Number;
		public var increment:Number;

		public function AddFloorsRequest( type:String, startPos:Number, endPos:Number, increment:Number ) {
			super( type );
			this.startPos = startPos;
			this.endPos = endPos;
			this.increment = increment;
		}
	}
}
