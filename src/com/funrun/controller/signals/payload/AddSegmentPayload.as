package com.funrun.controller.signals.payload {

	public class AddSegmentPayload {

		public var type:String;
		public var index:int;

		public function AddSegmentPayload( type:String, index:int ) {
			this.type = type;
			this.index = index;
		}
	}
}
