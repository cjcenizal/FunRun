package com.funrun.model {
	
	import away3d.entities.Mesh;
	import com.funrun.model.constants.TrackConstants;
	
	import com.funrun.model.collision.ObstacleData;
	import com.gskinner.utils.Rndm;
	
	import org.robotlegs.mvcs.Actor;
	
	public class ObstaclesModel extends Actor {
		
		private var _obstacles:Array;
		private var _history:Array;
		
		public function ObstaclesModel() {
			super();
			_obstacles = [];
			_history = [];
		}
		
		public function addObstacle( obstacle:ObstacleData ):void {
			_obstacles.push( obstacle );
		}
		
		public function set seed( val:int ):void {
			Rndm.seed = val;
		}
		
		/**
		 * Get next obstacle data.
		 * @param index The index of the desired obstacle.
		 * @return A clone of the original, since we need to duplicate obstacle mesh.
		 */
		public function getAt( index:int ):ObstacleData {
			while ( _history.length < index + 1 ) {
				_history.push( Rndm.float( 1 ) );
			}
			var obstacleData:ObstacleData = ( _obstacles[ Math.floor( _history[ index ] * _obstacles.length ) ] as ObstacleData ).clone();
			obstacleData.z = index * TrackConstants.SEGMENT_DEPTH;
			return obstacleData;
		}
	}
}
