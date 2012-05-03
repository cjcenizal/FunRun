package com.funrun.model
{
	public class ObstaclesModel
	{
		private var _obstacles:Array;
		private var _length:int = 0;
		
		public function ObstaclesModel()
		{
			_obstacles = [];
			add(
				new ObstacleVO(
					"leftWall",
					[
						[ "empty",	"empty",	"empty",	"empty",	"empty",	"empty" ],
						[ "empty",	"empty",	"empty",	"empty",	"empty",	"empty" ],
						[ "wall",	"empty",	"empty",	"empty",	"empty",	"empty" ],
						[ "empty",	"empty",	"empty",	"empty",	"empty",	"empty" ],
						[ "empty",	"empty",	"empty",	"empty",	"empty",	"empty" ]
					]
				)
			);
			/*
			add(
				new ObstacleVO(
					"sideWalls",
					[
						[ "empty",	"empty",	"empty" ],
						[ "wall",	"wall",		"empty" ],
						[ "wall",	"empty",	"empty" ],
						[ "empty",	"empty",	"empty" ],
						[ "empty",	"empty",	"wall" ]
					]
				)
			);
			add(
				new ObstacleVO(
					"wideBeam",
					[
						[ "empty",	"empty",	"empty" ],
						[ "empty",	"empty",	"empty" ],
						[ "beam",	"beam",		"beam" ],
						[ "empty",	"empty",	"empty" ],
						[ "empty",	"empty",	"empty" ]
					]
				)
			);
			add(
				new ObstacleVO(
					"centerWall",
					[
						[ "empty",	"empty",	"empty" ],
						[ "empty",	"empty",	"empty" ],
						[ "beam",	"wall",		"empty" ],
						[ "empty",	"empty",	"wall" ],
						[ "empty",	"empty",	"empty" ]
					]
				)
			);
			add(
				new ObstacleVO(
					"corridor",
					[
						[ "wall",	"wall",		"empty" ],
						[ "wall",	"wall",		"empty" ],
						[ "wall",	"wall",		"empty" ],
						[ "wall",	"empty",	"empty" ],
						[ "wall",	"empty",	"empty" ]
					]
				)
			);*/
		}
		
		public function add( obstacle:ObstacleVO ):void {
			_length++;
			_obstacles.push( obstacle );
		}
		
		public function getRandomObstacle():ObstacleVO {
			return _obstacles[ Math.floor( Math.random() * _length ) ];
		}
	}
}