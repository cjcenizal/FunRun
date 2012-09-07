package com.funrun.model.vo
{
	public class StoreObstacleVo
	{
		
		public var filename:String;
		public var blocks:Array;
		
		public function StoreObstacleVo( filename:String, blocks:Array )
		{
			this.filename = filename;
			this.blocks = blocks;
		}
	}
}