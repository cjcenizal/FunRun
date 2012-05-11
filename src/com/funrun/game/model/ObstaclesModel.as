package com.funrun.game.model {
	
	import away3d.entities.Mesh;
	
	import com.funrun.game.model.data.ObstacleData;
	
	import org.robotlegs.mvcs.Actor;
	
	public class ObstaclesModel extends Actor {
		
		private var _obstacles:Array;
		
		public function ObstaclesModel() {
			_obstacles = [];
		}
		
		public function addObstacle( obstacle:ObstacleData ):void {
			_obstacles.push( obstacle );
		}
		
		/**
		 * Get obstacle data at random.
		 * @return A clone of the original, since we need to duplicate obstacle mesh.
		 */
		public function getRandomObstacle():ObstacleData {
			return ( _obstacles[ Math.floor( Math.random() * _obstacles.length ) ] as ObstacleData ).clone();
		}
	}
}
