package com.funrun.model
{
	import com.funrun.model.collision.SegmentData;

	public interface IObstacleProvider
	{
		function getObstacleAt( index:int ):SegmentData;
		function get numObstacles():int;
	}
}