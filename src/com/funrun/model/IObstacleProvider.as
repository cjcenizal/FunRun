package com.funrun.model
{
	import com.funrun.model.vo.SegmentVO;

	public interface IObstacleProvider
	{
		function getObstacleAt( index:int ):SegmentVO;
		function get numObstacles():int;
	}
}