package com.funrun.controller.signals.payload
{
	public class AddFloorPayload
	{
		public var startPos:Number;
		public var endPos:Number;
		public var increment:Number;
		
		public function AddFloorPayload( startPos:Number, endPos:Number, increment:Number )
		{
			this.startPos = startPos;
			this.endPos = endPos;
			this.increment = increment;
		}
	}
}