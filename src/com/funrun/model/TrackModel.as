package com.funrun.model {
	
	import com.funrun.model.constants.Track;
	import com.funrun.model.vo.SegmentVO;
	
	import org.robotlegs.mvcs.Actor;
	
	public class TrackModel extends Actor implements IObstacleProvider {
		
		private var _obstacles:Array;
		
		public function TrackModel() {
			super();
			_obstacles = [];
		}
		
		public function addSegment( obstacle:SegmentVO ):void {
			_obstacles.push( obstacle );
			var len:int = _obstacles.length;
			_obstacles.sortOn( "z", [ Array.NUMERIC ] );
		}
		
		public function removeObstacleAt( index:int ):void {
			_obstacles.splice( index, 1 );
		}
		
		public function getObstacleAt( index:int ):SegmentVO {
			return _obstacles[ index ];
		}
		
		public function getObstacleArray():Array {
			return _obstacles;
		}
		
		public function get numObstacles():int {
			return _obstacles.length;
		}
		
		public function get depthOfLastObstacle():Number {
			if ( _obstacles.length > 0 ) {
				return ( _obstacles[ _obstacles.length - 1 ] as SegmentVO ).z;
			}
			return Track.DEPTH;
		}
		
		public function getDepthOfObstacleAt( index:int ):Number {
			if ( _obstacles.length >= index ) {
				return ( _obstacles[ index ] as SegmentVO ).z;
			}
			return 0;
		}
		
		public function get depthOfFirstObstacle():Number {
			if ( _obstacles.length > 0 ) {
				return ( _obstacles[ 0 ] as SegmentVO ).z;
			}
			return 0;
		}
	}
}
