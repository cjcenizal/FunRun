package com.funrun.services.parsers {
	
	public class SegmentsParser extends AbstractParser {
		
		private const LIST:String = "list";
		
		public function SegmentsParser( data:Object ) {
			super( data );
		}
		
		public function getAt( index:int ):SegmentParser {
			return new SegmentParser( data[ LIST ][ index ] );
		}
		
		public function get length():int {
			return ( data[ LIST ] as Array ).length;
		}
	}
}
