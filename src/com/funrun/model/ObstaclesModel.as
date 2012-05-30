package com.funrun.model {
	
	import away3d.entities.Mesh;
	
	import com.funrun.model.collision.ObstacleData;
	import com.gskinner.utils.Rndm;
	
	import org.robotlegs.mvcs.Actor;
	
	public class ObstaclesModel extends Actor {
		
		private var _obstacles:Array;
		
		public function ObstaclesModel() {
			_obstacles = [];
		}
		
		public function addObstacle( obstacle:ObstacleData ):void {
			_obstacles.push( obstacle );
		}
		
		public function set seed( val:int ):void {
			Rndm.seed = val;
		}
		
		/**
		 * Get next obstacle data.
		 * @return A clone of the original, since we need to duplicate obstacle mesh.
		 */
		public function getNext():ObstacleData {
			return ( _obstacles[ Math.floor( Rndm.float( 1 ) * _obstacles.length ) ] as ObstacleData ).clone();
		}
	}
}
