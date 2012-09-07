package com.funrun.model.vo
{
	public class PointVo
	{
		
		public var id:int;
		public var block:BlockVo;
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public function PointVo( id:int, block:BlockVo, x:Number, y:Number, z:Number )
		{
			this.id = id;
			this.block = block;
			this.x = x;
			this.y = y;
			this.z = z;
		}
	}
}