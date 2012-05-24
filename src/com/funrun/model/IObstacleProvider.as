package com.funrun.model
{
	import com.funrun.model.collision.ObstacleData;

	public interface IObstacleProvider
	{
		function getObstacleAt( index:int ):ObstacleData;
		function get numObstacles():int;
	}
}