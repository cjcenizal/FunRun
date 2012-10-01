package com.funrun.controller.signals.vo
{
	public class ShakeCameraVo
	{
		
		public var x:Number;
		public var y:Number;		
		public var z:Number;
		public var seconds:Number;
		
		public function ShakeCameraVo( x:Number, y:Number, z:Number, seconds:Number )
		{
			this.x = x;
			this.y = y;
			this.z = z;
			this.seconds = seconds;
		}
	}
}