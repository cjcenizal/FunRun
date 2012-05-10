package com.funrun.game.model {
	
	import away3d.entities.Mesh;
	
	import org.robotlegs.mvcs.Actor;
	
	public class ObstaclesModel extends Actor {
		
		private var _obstacles:Array;
		
		public function ObstaclesModel() {
			_obstacles = [];
		}
		
		public function addObstacle( obstacle:Mesh ):void {
			_obstacles.push( obstacle );
		}
		
		public function getRandomObstacleClone():Mesh {
			return ( _obstacles[ Math.floor( Math.random() * _obstacles.length ) ] as Mesh ).clone() as Mesh;
		}
	}
}
