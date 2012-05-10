package com.funrun.game.model.data
{
	import flash.geom.Point;

	public class BoundingBoxData
	{
		public var min:Point;
		public var max:Point;
		
		public function BoundingBoxData()
		{
			min = new Point();
			max = new Point();
		}
	}
}