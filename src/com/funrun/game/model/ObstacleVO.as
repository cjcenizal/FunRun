package com.funrun.game.model
{
	public class ObstacleVO
	{
		public var id:String;
		public var x:int;
		public var y:int;
		public var z:int;
		
		public function ObstacleVO( id:String, x:int, y:int, z:int )
		{
			this.id = id;
			this.x = x;
			this.y = y;
			this.z = z;
		}
	}
}