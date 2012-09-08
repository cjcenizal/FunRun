package com.funrun.model {
	
	import com.funrun.model.vo.SegmentVo;
	import com.gskinner.utils.Rndm;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SegmentsModel extends Actor {
		
		private var _segments:Array;
		private var _history:Array;
		private var _floor:SegmentVo;
		private var _random:Rndm;
		
		public function SegmentsModel() {
			super();
			_segments = [];
			_history = [];
			_random = new Rndm( Math.floor( Math.random() * 100 ) );
		}
		
		public function storeObstacle( segment:SegmentVo ):void {
			_segments.push( segment );
		}
		
		public function storeFloor( segment:SegmentVo ):void {
			_segments.unshift( segment );
		}
		
		public function reset():void {
			_history = [];
		}
		
		/**
		 * Get next obstacle data.
		 * @param index The index of the desired obstacle.
		 * @return A clone of the original, since we need to duplicate obstacle mesh.
		 */
		public function getAt( pos:int ):SegmentVo {
			while ( _history.length < pos + 1 ) {
				_history.push( _random.random() );
			}
			// If index is 0, return a floor. Else, return an obstacle.
			var index:int = ( pos == 0 ) ? pos : Math.floor( _history[ pos ] * ( _segments.length - 1 ) ) + 1;
			var segment:SegmentVo = ( _segments[ index ] as SegmentVo ).clone();
			segment.id = pos;
			return segment;
		}
		
		public function set seed( val:int ):void {
			Rndm.seed = val;
		}
	}
}
