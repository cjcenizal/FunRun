package com.funrun.game.model
{
	import com.funrun.game.model.data.ObstacleData;

	public interface IObstacleProvider
	{
		function getObstacleAt( index:int ):ObstacleData;
		function get numObstacles():int;
	}
}