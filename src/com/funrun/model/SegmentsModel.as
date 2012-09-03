package com.funrun.model {
	
	import com.funrun.model.vo.SegmentVo;
	import com.gskinner.utils.Rndm;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SegmentsModel extends Actor {
		
		private var _segments:Array;
		private var _histories:Array;
		private var _floor:SegmentVo;
		
		public function SegmentsModel() {
			super();
			_segments = [];
			_histories = [];
		}
		
		public function storeObstacle( segment:SegmentVo ):void {
			_segments.push( segment );
		}
		
		public function storeFloor( segment:SegmentVo ):void {
			_segments.unshift( segment );
		}
		
		/**
		 * Get next obstacle data.
		 * @param index The index of the desired obstacle.
		 * @return A clone of the original, since we need to duplicate obstacle mesh.
		 */
		public function getAt( index:int ):SegmentVo {
			while ( _histories.length < index + 1 ) {
				_histories.push( Rndm.float( 1 ) );
			}
			// If index is 0, return a floor. Else, return an obstacle.
			var index:int = ( index == 0 ) ? index : Math.floor( _histories[ index ] * ( _segments.length - 1 ) ) + 1;
			return ( _segments[ index ] as SegmentVo ).clone();
		}
		
		public function set seed( val:int ):void {
			Rndm.seed = val;
		}
	}
}
