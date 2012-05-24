package com.funrun.model.collision
{
	import com.funrun.model.vo.BlockVO;
	
	public class BoundingBoxData
	{
		public var block:BlockVO;
		public var x:Number;
		public var y:Number;
		public var z:Number;
		public var minX:Number;
		public var minY:Number;
		public var minZ:Number;
		public var maxX:Number;
		public var maxY:Number;
		public var maxZ:Number;
		
		public function BoundingBoxData( block:BlockVO, x:Number, y:Number, z:Number, minX:Number, minY:Number, minZ:Number, maxX:Number, maxY:Number, maxZ:Number )
		{
			this.block = block;
			this.x = x;
			this.y = y;
			this.z = z;
			this.minX = minX;
			this.minY = minY;
			this.minZ = minZ;
			this.maxX = maxX;
			this.maxY = maxY;
			this.maxZ = maxZ;
		}
	}
}