package com.funrun.controller.signals.vo
{
	public class CollectPointVo
	{
		
		public var segmentId:int;
		public var blockId:int;
		
		public function CollectPointVo( segmentId:int, blockId:int )
		{
			this.segmentId = segmentId;
			this.blockId = blockId;
		}
	}
}