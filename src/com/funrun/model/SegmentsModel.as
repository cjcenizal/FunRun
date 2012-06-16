package com.funrun.model {
	
	import com.funrun.model.collision.SegmentData;
	import com.gskinner.utils.Rndm;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SegmentsModel extends Actor {
		
		private var _segments:Object;
		private var _histories:Object;
		
		public function SegmentsModel() {
			super();
			_segments = {};
			_histories = {};
		}
		
		public function addSegment( segment:SegmentData ):void {
			if ( !_segments[ segment.type ] ) {
				_segments[ segment.type ] = new Array();
				_histories[ segment.type ] = new Array();
			}
			_segments[ segment.type ].push( segment );
		}
		
		public function set seed( val:int ):void {
			Rndm.seed = val;
		}
		
		/**
		 * Get next obstacle data.
		 * @param index The index of the desired obstacle.
		 * @return A clone of the original, since we need to duplicate obstacle mesh.
		 */
		public function getOfType( type:String, index:int ):SegmentData {
			var history:Array = _histories[ type ];
			while ( history.length < index + 1 ) {
				history.push( Rndm.float( 1 ) );
			}
			var segments:Array = _segments[ type ];
			return ( segments[ Math.floor( history[ index ] * segments.length ) ] as SegmentData ).clone();
		}
	}
}
