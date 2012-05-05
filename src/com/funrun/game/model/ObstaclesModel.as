package com.funrun.game.model
{
	public class ObstaclesModel
	{
		private var _obstacles:Array;
		private var _length:int = 0;
		
		public function ObstaclesModel()
		{
			_obstacles = [];
		}
		
		public function addObstacle( obstacle:ObstacleVO ):void {
			_length++;
			_obstacles.push( obstacle );
		}
		
		public function getRandomObstacle():ObstacleVO {
			return _obstacles[ Math.floor( Math.random() * _length ) ];
		}
	}
}