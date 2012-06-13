package com.funrun.controller.signals.payload {

	public class UpdateTrackPayload {

		public var speed:Number;
		public var positionZ:Number;

		public function UpdateTrackPayload( speed:Number, positionZ:Number ) {
			this.speed = speed;
			this.positionZ = positionZ;
		}
	}
}
