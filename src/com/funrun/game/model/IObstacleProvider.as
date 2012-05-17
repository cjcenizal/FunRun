package com.funrun.game.model
{
	import com.funrun.game.model.collision.ObstacleData;

	public interface IObstacleProvider
	{
		function getObstacleAt( index:int ):ObstacleData;
		function get numObstacles():int;
	}
}