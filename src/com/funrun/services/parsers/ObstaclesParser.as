package com.funrun.services.parsers {
	
	public class ObstaclesParser extends AbstractParser {
		
		private const LIST:String = "list";
		
		public function ObstaclesParser( data:Object ) {
			super( data );
		}
		
		public function getAt( index:int ):ObstacleParser {
			return new ObstacleParser( data[ LIST ][ index ] );
		}
		
		public function get length():int {
			return ( data[ LIST ] as Array ).length;
		}
	}
}
