package com.funrun.model {
	
	import com.funrun.model.collision.ObstacleData;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Actor;
	
	public class TrackModel extends Actor implements IObstacleProvider {
		
		private var _obstacles:Array;
		
		public function TrackModel() {
			super();
			_obstacles = [];
		}
		
		public function addObstacle( obstacle:ObstacleData ):void {
			_obstacles.push( obstacle );
			var len:int = _obstacles.length;
			_obstacles.sortOn( "z", [ Array.NUMERIC ] );
		}
		
		public function move( amount:Number ):void {
			var len:int = _obstacles.length;
			for ( var i:int = 0; i < len; i++ ) {
				( _obstacles[ i ] as ObstacleData ).z += amount;
			}
		}
		
		public function removeObstacleAt( index:int ):void {
			_obstacles.splice( index, 1 );
		}
		
		public function getObstacleAt( index:int ):ObstacleData {
			return _obstacles[ index ];
		}
		
		public function get numObstacles():int {
			return _obstacles.length;
		}
		
		public function get depthOfLastObstacle():Number {
			if ( _obstacles.length > 0 ) {
				return ( _obstacles[ _obstacles.length - 1 ] as ObstacleData ).z;
			}
			return TrackConstants.TRACK_DEPTH;
		}
		
		public function get depthOfFirstObstacle():Number {
			if ( _obstacles.length > 0 ) {
				return ( _obstacles[ 0 ] as ObstacleData ).z;
			}
			return 0;
		}
	}
}
