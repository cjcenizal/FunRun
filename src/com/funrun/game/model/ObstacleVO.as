package com.funrun.game.model
{
	public class ObstacleVO
	{
		public var id:String;
		public var geos:Array;
		
		public function ObstacleVO( id:String, geos:Array )
		{
			this.id = id;
			this.geos = geos;
		}
	}
}