package com.funrun.game.model
{
	import com.funrun.game.model.parsers.ObstacleParser;

	public class ObstaclesModel
	{
		private var _obstacles:Array;
		private var _length:int = 0;
		
		public function ObstaclesModel()
		{
			_obstacles = [];
		}
		
		public function addObstacle( obstacle:ObstacleParser ):void {
			_length++;
			_obstacles.push( obstacle );
		}
		
		public function getRandomObstacle():ObstacleParser {
			return _obstacles[ Math.floor( Math.random() * _length ) ];
		}
	}
}