package com.funrun.view
{
	public class Obstacle
	{
		public var y:Number;
		public var id:String;
		
		public function Obstacle( id:String, startPos:Number )
		{
			this.id = id;
			y = startPos;
		}
		
		public function destroy():void {
			
		}
	}
}