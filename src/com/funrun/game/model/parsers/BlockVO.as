package com.funrun.game.model.parsers
{
	public class BlockVO
	{
		public var id:String;
		public var x:int;
		public var y:int;
		public var z:int;
		
		public function BlockVO( id:String, x:int, y:int, z:int )
		{
			this.id = id;
			this.x = x;
			this.y = y;
			this.z = z;
		}
	}
}