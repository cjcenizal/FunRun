package com.funrun.game.model.data
{
	import com.funrun.game.model.parsers.BlockParser;
	
	public class BoundingBoxData
	{
		public var block:BlockParser;
		public var minX:Number;
		public var minY:Number;
		public var minZ:Number;
		public var maxX:Number;
		public var maxY:Number;
		public var maxZ:Number;
		
		public function BoundingBoxData( block:BlockParser, minX:Number, minY:Number, minZ:Number, maxX:Number, maxY:Number, maxZ:Number )
		{
			this.block = block;
			this.minX = minX;
			this.minY = minY;
			this.minZ = minZ;
			this.maxX = maxX;
			this.maxY = maxY;
			this.maxZ = maxZ;
		}
	}
}