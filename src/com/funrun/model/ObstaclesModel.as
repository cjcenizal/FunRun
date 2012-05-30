package com.funrun.model {
	
	import away3d.entities.Mesh;
	
	import com.funrun.model.collision.ObstacleData;
	
	import org.robotlegs.mvcs.Actor;
	
	public class ObstaclesModel extends Actor {
		
		private var _obstacles:Array;
		private var _queue:Array;
		private var _pointer:int = 0;
		
		public function ObstaclesModel() {
			_obstacles = [];
			_queue = [];
		}
		
		public function addObstacle( obstacle:ObstacleData ):void {
			_obstacles.push( obstacle );
		}
		
		public function addToQueue( rand:Number ):void {
			_queue.push( rand );
		}
		
		/**
		 * Get next obstacle data.
		 * @return A clone of the original, since we need to duplicate obstacle mesh.
		 */
		public function getNext():ObstacleData {
			var rand:Number = _queue[ _pointer++ ];
			return ( _obstacles[ Math.floor( rand * _obstacles.length ) ] as ObstacleData ).clone();
		}
		
		public function get remainingInQueue():int {
			return _queue.length - _pointer;
		}
	}
}
