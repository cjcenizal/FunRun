package com.funrun.model.collision
{
	public class BlockData
	{
		public var id:String;
		public var x:int;
		public var y:int;
		public var z:int;
		
		public function BlockData( id:String, x:int, y:int, z:int )
		{
			this.id = id;
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function toString():String {
			return (id + ": " + x + ", " + y + ", " + z);
		}
	}
}