package com.funrun.model {
	
	import com.funrun.model.vo.SegmentVO;
	import com.gskinner.utils.Rndm;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SegmentsModel extends Actor {
		
		private var _segments:Array;
		private var _histories:Array;
		private var _floor:SegmentVO;
		
		public function SegmentsModel() {
			super();
			_segments = [];
			_histories = [];
		}
		
		public function storeObstacle( segment:SegmentVO ):void {
			_segments.push( segment );
		}
		
		public function storeFloor( segment:SegmentVO ):void {
			_segments.unshift( segment );
		}
		
		/**
		 * Get next obstacle data.
		 * @param index The index of the desired obstacle.
		 * @return A clone of the original, since we need to duplicate obstacle mesh.
		 */
		public function getAt( index:int ):SegmentVO {
			while ( _histories.length < index + 1 ) {
				_histories.push( Rndm.float( 1 ) );
			}
			// If index is 0, return a floor. Else, return an obstacle.
			//var index:int = ( index == 0 ) ? index : Math.floor( _histories[ index ] * ( _segments.length - 1 ) ) + 1;
			var index:int = Math.floor( _histories[ index ] * ( _segments.length ) );
			return ( _segments[ index ] as SegmentVO ).clone();
		}
		
		public function set seed( val:int ):void {
			Rndm.seed = val;
		}
	}
}
