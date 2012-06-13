package com.funrun.controller.signals.payload {

	public class AddObstaclePayload {

		public var index:int;
		public var relativePositionZ:Number;

		public function AddObstaclePayload( index:int, relativePositionZ:Number ) {
			this.index = index;
			this.relativePositionZ = relativePositionZ;
		}
	}
}
