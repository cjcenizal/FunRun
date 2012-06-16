package com.funrun.model {
	
	import com.funrun.model.collision.SegmentData;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Actor;
	
	public class TrackModel extends Actor implements IObstacleProvider {
		
		private var _obstacles:Array;
		
		public function TrackModel() {
			super();
			_obstacles = [];
		}
		
		public function addSegment( obstacle:SegmentData ):void {
			_obstacles.push( obstacle );
			var len:int = _obstacles.length;
			_obstacles.sortOn( "z", [ Array.NUMERIC ] );
		}
		
		public function removeObstacleAt( index:int ):void {
			_obstacles.splice( index, 1 );
		}
		
		public function getObstacleAt( index:int ):SegmentData {
			return _obstacles[ index ];
		}
		
		public function get numObstacles():int {
			return _obstacles.length;
		}
		
		public function get depthOfLastObstacle():Number {
			if ( _obstacles.length > 0 ) {
				return ( _obstacles[ _obstacles.length - 1 ] as SegmentData ).z;
			}
			return TrackConstants.TRACK_DEPTH;
		}
		
		public function get depthOfFirstObstacle():Number {
			if ( _obstacles.length > 0 ) {
				return ( _obstacles[ 0 ] as SegmentData ).z;
			}
			return 0;
		}
	}
}
