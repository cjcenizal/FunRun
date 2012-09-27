package com.funrun.model {
	
	import com.funrun.model.vo.SegmentVo;
	
	import org.robotlegs.mvcs.Actor;
	
	public class TrackModel extends Actor {
		
		private var _segments:Array;
		
		public function TrackModel() {
			super();
			_segments = [];
		}
		
		public function addSegment( segment:SegmentVo ):void {
			_segments.push( segment );
			var len:int = _segments.length;
			_segments.sortOn( "z", [ Array.NUMERIC ] );
		}
		
		public function removeSegmentAt( index:int ):void {
			_segments.splice( index, 1 );
		}
		
		public function getSegmentAt( index:int ):SegmentVo {
			return _segments[ index ];
		}
		
		public function getSegmentArray():Array {
			return _segments;
		}
		
		public function get numSegments():int {
			return _segments.length;
		}
		
		public function get depthOfLastSegment():Number {
			if ( _segments.length > 0 ) {
				return ( _segments[ _segments.length - 1 ] as SegmentVo ).z;
			}
			return 0;
		}
		
		public function getDepthOfSegmentAt( index:int ):Number {
			if ( _segments.length >= index ) {
				return ( _segments[ index ] as SegmentVo ).z;
			}
			return 0;
		}
		
		public function get depthOfFirstSegment():Number {
			if ( _segments.length > 0 ) {
				return ( _segments[ 0 ] as SegmentVo ).z;
			}
			return 0;
		}
	}
}
